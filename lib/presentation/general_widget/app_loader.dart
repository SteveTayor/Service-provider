import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoaderSpinnerKit extends StatefulWidget {
  const AppLoaderSpinnerKit({
    super.key,
    this.color = AppColors.primaryColor,
    this.size = 30,
  });
  final Color color;
  final double size;

  @override
  State<AppLoaderSpinnerKit> createState() => _AppLoaderSpinnerKitState();
}

class _AppLoaderSpinnerKitState extends State<AppLoaderSpinnerKit> {
  @override
  Widget build(BuildContext context) {
    return SpinKitDoubleBounce(
      color: widget.color,
      size: widget.size,
    );
  }
}

class AppLoader extends StatefulWidget {
  const AppLoader({
    super.key,
    this.size = 30,
  });
  final double size;

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Image.asset(
            Assets.images.icLauncherPlaystore.path,
            width: widget.size,
            height: widget.size,
          ),
        );
      },
    );
  }
}
