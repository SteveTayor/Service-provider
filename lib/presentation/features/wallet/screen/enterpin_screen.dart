import 'dart:math';

import 'package:bundlegram/core/extensions/responsive_extensions.dart';
import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/features/setting/provider/security_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EnterPinScreen extends ConsumerStatefulWidget {
  const EnterPinScreen({
    super.key,
    this.onVerified,
    this.isChangedAccountPin = false,
  });

  final Function(String)? onVerified;
  final bool isChangedAccountPin;

  @override
  ConsumerState<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends ConsumerState<EnterPinScreen>
    with SingleTickerProviderStateMixin {
  final List<String> _pin = ['', '', '', ''];
  int _currentIndex = 0;
  String? _errorMessage;

  late AnimationController _shakeController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _offsetAnimation = Tween(begin: 0.0, end: 24.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void _updatePin(String value) {
    if (_currentIndex < 4) {
      setState(() {
        _pin[_currentIndex] = value;
        _currentIndex++;
      });
      if (_currentIndex == 4) {
        final entered = _pin.join();
        widget.onVerified?.call(entered);
      }
    }
  }

  void _deletePin() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _pin[_currentIndex] = '';
      });
    }
  }

  Widget _buildPinDot(int index) {
    final r = context.responsive;

    return Container(
      width: r.spacing(24),
      height: r.spacing(24),
      margin: EdgeInsets.symmetric(horizontal: r.spacing(8)),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _pin[index].isNotEmpty
            ? AppColors.primaryColor
            : Colors.transparent,
        border: Border.all(color: AppColors.primaryColor, width: 1.5),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    final r = context.responsive;

    return TextButton(
      onPressed: () {
        setState(() => _errorMessage = null);
        _updatePin(number);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(r.spacing(20)),
      ),
      child: Text(
        number,
        style: TextStyle(
          fontSize: r.textSize(22),
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final security = ref.watch(securityProvider);
    final showBiometric = security.useFingerprint || security.useFaceId;

    return BundlegramScaffold(
      useResponsive: true,
      appBar: const BundlegramAppbar(
        titleText: 'Enter current pin',
        useResponsive: true,
      ),
      sidePadding: r.padding(
        left: 20,
        right: 20,
        bottom: 40,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "We need to confirm it's you.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: AppColors.grey33,
                        // fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: r.spacing(40)),
                AnimatedBuilder(
                  animation: _shakeController,
                  builder: (context, child) {
                    final offset = sin(_offsetAnimation.value) * 12;
                    return Transform.translate(
                      offset: Offset(offset, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, _buildPinDot),
                      ),
                    );
                  },
                ),
                if (_errorMessage != null) ...[
                  SizedBox(height: r.spacing(16)),
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: AppColors.errorText,
                      fontSize: r.textSize(14),
                    ),
                  ),
                  SizedBox(height: r.spacing(24)),
                ],
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: r.when(
                  phone: 1.5,
                  tablet: 1.8, // Better ratio for tablets
                  desktop: 2.0,
                ),
                children: [
                  ...List.generate(
                    9,
                    (index) => _buildNumberButton('${index + 1}'),
                  ),
                  if (!widget.isChangedAccountPin && showBiometric) ...[
                    SizedBox(
                      width: r.spacing(24),
                      height: r.spacing(24),
                      child: AppSvgIcon(
                        path: Assets.svgs.fingerCricle1,
                        fit: BoxFit.scaleDown,
                        width: r.iconSize(base: 24),
                        height: r.iconSize(base: 24),
                      ),
                    ),
                  ] else ...[
                    const SizedBox.shrink()
                    // SizedBox(height: r.spacing(24))
                  ],
                  _buildNumberButton('0'),
                  IconButton(
                    onPressed: _deletePin,
                    icon: Icon(
                      Icons.backspace_outlined,
                      size: r.iconSize(base: 24),
                      color: AppColors.grey83,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.push(RouteConstants.resetAccountPin),
            child: Text(
              'Forgot PIN?',
              style: context.textTheme.bodyMedium!.copyWith(
                // fontSize: 16,
                color: AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
