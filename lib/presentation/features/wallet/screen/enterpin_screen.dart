import 'dart:math';

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/gen/assets.gen.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({
    super.key,
    this.onVerified,
    this.isChangedAccountPin = false,
  });

  final Function(String)? onVerified;
  final bool isChangedAccountPin;

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen>
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
    return Container(
      width: 24.w,
      height: 24.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
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
    return TextButton(
      onPressed: () {
        setState(() => _errorMessage = null);
        _updatePin(number);
      },
      style: TextButton.styleFrom(padding: EdgeInsets.all(20.w)),
      child: Text(
        number,
        style: context.textTheme.titleMedium?.copyWith(
          // fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BundlegramScaffold(
      appBar: const BundlegramAppbar(
        titleText: 'Enter current pin',
      ),
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
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
                40.verticalSpace,
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
                  16.verticalSpace,
                  Text(
                    _errorMessage!,
                    style: TextStyle(
                      color: AppColors.errorText,
                      fontSize: 14,
                    ),
                  ),
                  24.verticalSpace,
                ],
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
                children: [
                  ...List.generate(
                    9,
                    (index) => _buildNumberButton('${index + 1}'),
                  ),
                  if (!widget.isChangedAccountPin) ...[
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: AppSvgIcon(
                        path: Assets.svgs.fingerCricle1,
                        fit: BoxFit.scaleDown,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ] else ...[
                    24.verticalSpace
                  ],
                  _buildNumberButton('0'),
                  IconButton(
                    onPressed: _deletePin,
                    icon: Icon(
                      Icons.backspace_outlined,
                      size: 24,
                      color: AppColors.grey83,
                    ),
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.push(RouteConstants.forgetPassword),
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
