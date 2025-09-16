import 'package:bundlegram/data/models/faqs_model.dart';
import 'package:bundlegram/presentation/features/account%20setup/notifier/accountsetup_data.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with TickerProviderStateMixin {
  String searchQuery = '';
  List<FAQItem> filteredFAQs = HelpCenterFAQData.faqItems;
  late AnimationController _searchController;
  late AnimationController _listController;
  late Animation<double> _searchAnimation;
  late Animation<double> _listAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _searchController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _listController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Create animations
    _searchAnimation = CurvedAnimation(
      parent: _searchController,
      curve: Curves.easeOutBack,
    );

    _listAnimation = CurvedAnimation(
      parent: _listController,
      curve: Curves.easeOut,
    );

    // Start animations
    Future.delayed(const Duration(milliseconds: 200), () {
      _searchController.forward();
    });

    Future.delayed(const Duration(milliseconds: 400), () {
      _listController.forward();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _filterFAQs(String query) {
    setState(() {
      searchQuery = query;
      if (query.isEmpty) {
        filteredFAQs = HelpCenterFAQData.faqItems;
      } else {
        filteredFAQs = HelpCenterFAQData.faqItems
            .where((faq) =>
                faq.question.toLowerCase().contains(query.toLowerCase()) ||
                faq.answer.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Help center (FAQs)',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Animated Search Bar
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.3),
              end: Offset.zero,
            ).animate(_searchAnimation),
            child: ScaleTransition(
              scale: _searchAnimation,
              child: Container(
                margin: EdgeInsets.only(left: 12.w, right: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.searchbarColor,
                  borderRadius: BorderRadius.circular(80.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: AppTextField(
                  decoration: InputDecoration(
                    fillColor: AppColors.searchbarColor,
                    filled: true,
                    prefixIcon: AnimatedBuilder(
                      animation: _searchAnimation,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _searchAnimation.value * 0.1,
                          child: const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.search,
                              color: AppColors.grey8E,
                            ),
                          ),
                        );
                      },
                    ),
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.searchHintColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(80.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(80.r),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(80.r),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(80.r),
                    ),
                  ),
                  onChange: _filterFAQs,
                ),
              ),
            ),
          ),

          // Animated Divider
          FadeTransition(
            opacity: _searchAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0),
                end: Offset.zero,
              ).animate(_searchAnimation),
              child: const Divider(color: Color(0xFFECECEC)),
            ),
          ),

          // Animated FAQ List
          Expanded(
            child: filteredFAQs.isEmpty
                ? FadeTransition(
                    opacity: _listAnimation,
                    child: ScaleTransition(
                      scale: _listAnimation,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TweenAnimationBuilder(
                              duration: const Duration(milliseconds: 1000),
                              tween: Tween<double>(begin: 0, end: 1),
                              builder: (context, double value, child) {
                                return Transform.scale(
                                  scale: value,
                                  child: Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                );
                              },
                            ),
                            16.verticalSpace,
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.3),
                                end: Offset.zero,
                              ).animate(_listAnimation),
                              child: Text(
                                'No FAQs found',
                                style: context.textTheme.titleMedium?.copyWith(
                                  color: AppColors.grey80,
                                ),
                              ),
                            ),
                            8.verticalSpace,
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 0.5),
                                end: Offset.zero,
                              ).animate(_listAnimation),
                              child: Text(
                                'Try adjusting your search terms',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: AppColors.grey33,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : AnimatedList(
                    key: ValueKey(filteredFAQs.length),
                    initialItemCount: filteredFAQs.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index, animation) {
                      if (index >= filteredFAQs.length) return const SizedBox();

                      final faq = filteredFAQs[index];

                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.3, 0),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Interval(
                            index * 0.1,
                            1.0,
                            curve: Curves.easeOutBack,
                          ),
                        )),
                        child: FadeTransition(
                          opacity: animation,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 12.h),
                            child: AnimatedFAQExpansionTile(
                              question: faq.question,
                              answer: faq.answer,
                              index: index,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class AnimatedFAQExpansionTile extends StatefulWidget {
  const AnimatedFAQExpansionTile({
    required this.question,
    required this.answer,
    required this.index,
    super.key,
  });

  final String question;
  final String answer;
  final int index;

  @override
  State<AnimatedFAQExpansionTile> createState() =>
      _AnimatedFAQExpansionTileState();
}

class _AnimatedFAQExpansionTileState extends State<AnimatedFAQExpansionTile>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: AppColors.white,
      end: AppColors.white.withOpacity(0.95),
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
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 300 + (widget.index * 100)),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.elasticOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: AnimatedBuilder(
            animation: _hoverController,
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: _colorAnimation.value,
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                            0.03 + (_hoverController.value * 0.05)),
                        blurRadius: 5 + (_hoverController.value * 10),
                        offset: Offset(0, 2 + (_hoverController.value * 3)),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12.r),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      onHover: (hovering) {
                        if (hovering) {
                          _hoverController.forward();
                        } else {
                          _hoverController.reverse();
                        }
                      },
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          dividerColor: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 16.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: isExpanded
                                    ? LinearGradient(
                                        colors: [
                                          AppColors.white,
                                          AppColors.white.withOpacity(0.98),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      )
                                    : null,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.question,
                                      style: context.textTheme.bodyMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: isExpanded
                                            ? AppColors.black.withOpacity(0.9)
                                            : AppColors.black,
                                      ),
                                    ),
                                  ),
                                  AnimatedRotation(
                                    turns: isExpanded ? 0.5 : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.black.withOpacity(0.7),
                                      size: 24.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Animated Answer Section
                            AnimatedSize(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                              child: isExpanded
                                  ? Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.only(
                                        left: 16.w,
                                        right: 16.w,
                                        bottom: 16.h,
                                      ),
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0, -0.2),
                                          end: Offset.zero,
                                        ).animate(CurvedAnimation(
                                          parent: AlwaysStoppedAnimation(1.0),
                                          curve: Curves.easeOut,
                                        )),
                                        child: FadeTransition(
                                          opacity:
                                              const AlwaysStoppedAnimation(1.0),
                                          child: Text(
                                            widget.answer,
                                            textAlign: TextAlign.justify,
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                              height: 1.6,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),

                            // Animated Divider
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: isExpanded ? 0 : 1,
                              child: const Divider(
                                color: Color(0xFFECECEC),
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

// Alternative Custom ListView with Staggered Animation
class StaggeredFAQList extends StatelessWidget {
  final List<FAQItem> faqs;

  const StaggeredFAQList({required this.faqs, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: faqs.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 400 + (index * 150)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.elasticOut,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(50 * (1 - value), 0),
              child: Opacity(
                opacity: value,
                child: AnimatedFAQExpansionTile(
                  question: faqs[index].question,
                  answer: faqs[index].answer,
                  index: index,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
