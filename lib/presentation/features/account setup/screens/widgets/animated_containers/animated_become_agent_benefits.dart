import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/extensions/context_extensions.dart';
import 'package:bundlegram/core/extensions/widget_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/account%20setup/screens/becomeagent_screen.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Animated Benefits List Widget
class AnimatedBenfitList extends StatefulWidget {
  final List<Benfit> benefits;

  const AnimatedBenfitList({
    super.key,
    required this.benefits,
  });

  @override
  State<AnimatedBenfitList> createState() => _AnimatedBenfitListState();
}

class _AnimatedBenfitListState extends State<AnimatedBenfitList>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  final List<AnimationController> _itemControllers = [];
  final List<Animation<double>> _slideAnimations = [];
  final List<Animation<double>> _fadeAnimations = [];
  final List<Animation<double>> _scaleAnimations = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create individual controllers for each benefit
    for (int i = 0; i < widget.benefits.length; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      );

      // Slide animation (from right to left)
      final slideAnimation = Tween<double>(
        begin: 1.0,
        end: 0.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.6,
          curve: Curves.easeOutCubic,
        ),
      ));

      // Fade animation
      final fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.0,
          0.8,
          curve: Curves.easeOut,
        ),
      ));

      // Scale animation with bounce effect
      final scaleAnimation = Tween<double>(
        begin: 0.3,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.2,
          1.0,
          curve: Curves.elasticOut,
        ),
      ));

      _itemControllers.add(controller);
      _slideAnimations.add(slideAnimation);
      _fadeAnimations.add(fadeAnimation);
      _scaleAnimations.add(scaleAnimation);
    }
  }

  void _startAnimations() {
    _mainController.forward();

    // Stagger the animations with increasing delays
    for (int i = 0; i < _itemControllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 150 + 200), () {
        if (mounted) {
          _itemControllers[i].forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    for (var controller in _itemControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title animation
        AnimatedBuilder(
          animation: _mainController,
          builder: (context, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -0.5),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: _mainController,
                curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
              )),
              child: FadeTransition(
                opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _mainController,
                    curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
                  ),
                ),
                child: Text(
                  'What\'s in it for you?',
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleMedium!.copyWith(
                    color: AppColors.grey33,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
        24.verticalSpace,
        // Benefits list
        ...List.generate(widget.benefits.length, (index) {
          return AnimatedBuilder(
            animation: _itemControllers[index],
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(_slideAnimations[index].value * 100, 0),
                child: Transform.scale(
                  scale: _scaleAnimations[index].value,
                  child: FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: AnimatedBenefitTile(
                      benefit: widget.benefits[index],
                      index: index,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}

// Individual animated benefit tile
class AnimatedBenefitTile extends StatefulWidget {
  final Benfit benefit;
  final int index;

  const AnimatedBenefitTile({
    super.key,
    required this.benefit,
    required this.index,
  });

  @override
  State<AnimatedBenefitTile> createState() => _AnimatedBenefitTileState();
}

class _AnimatedBenefitTileState extends State<AnimatedBenefitTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: 0.0,
      end: 8.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.blue.withOpacity(0.02),
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _hoverController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            margin: EdgeInsets.only(bottom: 24.h),
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(12),
              boxShadow: _elevationAnimation.value > 0
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: _elevationAnimation.value,
                        offset: Offset(0, _elevationAnimation.value / 2),
                        spreadRadius: 1,
                      ),
                    ]
                  : null,
            ),
            child: MouseRegion(
              onEnter: (_) {
                setState(() => _isHovered = true);
                _hoverController.forward();
              },
              onExit: (_) {
                setState(() => _isHovered = false);
                _hoverController.reverse();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: context.symmetricPadding(
                  _isHovered ? 12 : 0,
                  _isHovered ? 16 : 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Animated icon with pulse effect
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0.8, end: 1.0),
                      duration:
                          Duration(milliseconds: 600 + (widget.index * 100)),
                      curve: Curves.elasticOut,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: AppSvgIcon(
                              path: widget.benefit.asset,
                              width: 24,
                              height: 24,
                            ),
                          ),
                        );
                      },
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Animated title with typewriter effect
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: context.textTheme.bodyMedium!.copyWith(
                              fontWeight: _isHovered
                                  ? FontWeight.w600
                                  : FontWeight.normal,
                              color: _isHovered
                                  ? Theme.of(context).primaryColor
                                  : null,
                            ),
                            child: Text(widget.benefit.title),
                          ),
                          8.verticalSpace,
                          // Animated description
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 300),
                            style: context.textTheme.labelMedium!.copyWith(
                              height: _isHovered ? 1.6 : 1.4,
                            ),
                            child: Text(
                              widget.benefit.label,
                              maxLines: null,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Alternative: Shimmer loading effect for benefits
class ShimmerBenefitsList extends StatefulWidget {
  final List<Benfit> benefits;

  const ShimmerBenefitsList({
    super.key,
    required this.benefits,
  });

  @override
  State<ShimmerBenefitsList> createState() => _ShimmerBenefitsListState();
}

class _ShimmerBenefitsListState extends State<ShimmerBenefitsList>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _shimmerAnimation = Tween<double>(
      begin: -2.0,
      end: 2.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    _shimmerController.repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'What\'s in it for you?',
          textAlign: TextAlign.center,
          style: context.textTheme.titleMedium!.copyWith(
            color: AppColors.grey33,
            fontWeight: FontWeight.w500,
          ),
        ),
        24.verticalSpace,
        ...widget.benefits.asMap().entries.map((entry) {
          final index = entry.key;
          final benefit = entry.value;

          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 300 + (index * 100)),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset((1 - value) * 50, 0),
                child: Opacity(
                  opacity: value,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppSvgIcon(path: benefit.asset),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                benefit.title,
                                style: context.textTheme.bodyMedium,
                              ),
                              8.verticalSpace,
                              Text(
                                benefit.label,
                                style: context.textTheme.labelMedium,
                                maxLines: null,
                                softWrap: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ],
    );
  }
}
