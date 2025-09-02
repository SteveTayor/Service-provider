import 'dart:math';

import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
import 'package:bundlegram/core/router/route_constants.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/setting/provider/create_pin_provider.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PinScreen extends ConsumerStatefulWidget {
  const PinScreen({super.key});

  @override
  ConsumerState<PinScreen> createState() => _PinScreenState();
}

class _PinScreenState extends ConsumerState<PinScreen>
    with SingleTickerProviderStateMixin {
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

    ref.read(pinControllerProvider.notifier).setShake(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Widget _buildPinDot(int index) {
    final controller = ref.watch(pinControllerProvider);
    final isFilled = controller.pin[index].isNotEmpty;

    return Container(
      width: 24.w,
      height: 24.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? AppColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: AppColors.primaryColor,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return TextButton(
      onPressed: () {
        ref.read(pinControllerProvider.notifier).updatePin(number, context);
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(20.w),
        shape: const CircleBorder(),
      ),
      child: Text(
        number,
        style: context.textTheme.titleMedium!.copyWith(
          // fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(pinControllerProvider);

    return BundlegramScaffold(
      appBar: BundlegramAppbar(
        titleText: controller.mode == PinScreenMode.create
            ? 'Create new pin'
            : 'Confirm pin',
        showBackButton: false,
        onTap: () {
          if (controller.mode == PinScreenMode.create) {
            context.pop();
          } else {
            ref.read(pinControllerProvider.notifier).start(
                  PinScreenMode.create,
                  onComplete: () => context.go(RouteConstants.dashboard),
                );
            context.push(RouteConstants.pinScreen);
          }
        },
      ),
      sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              children: [
                10.verticalSpace,
                Text(
                  'The PIN will be used to authorize transactions.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall!.copyWith(
                    color: AppColors.grey33,
                    // fontSize: 16,
                    height: 1.4,
                  ),
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
                if (controller.errorMessage != null) ...[
                  20.verticalSpace,
                  Text(
                    controller.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.errorText,
                      fontSize: 14,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: [
                  ...List.generate(
                      9, (index) => _buildNumberButton('${index + 1}')),
                  const SizedBox(width: 24, height: 24),
                  _buildNumberButton('0'),
                  IconButton(
                    onPressed: () =>
                        ref.read(pinControllerProvider.notifier).deletePin(),
                    icon: const Icon(
                      Icons.backspace_outlined,
                      size: 24,
                      color: AppColors.grey83,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:bundlegram/core/extensions/texttheme_extensions.dart';
// import 'package:bundlegram/core/router/route_constants.dart';
// import 'package:bundlegram/core/utils/colors.dart';
// import 'package:bundlegram/core/utils/enums.dart';
// import 'package:bundlegram/gen/assets.gen.dart';
// import 'package:bundlegram/presentation/general_widget/app_bar.dart';
// import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
// import 'package:bundlegram/presentation/general_widget/app_svg.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';

// class PinScreen extends StatefulWidget {
//   const PinScreen({
//     required this.mode,
//     super.key,
//     this.onCompleted,
//     this.initialPin,
//   });

//   final PinScreenMode mode;
//   final VoidCallback? onCompleted;
//   final String? initialPin; // Used for confirm mode

//   @override
//   State<PinScreen> createState() => _PinScreenState();
// }

// class _PinScreenState extends State<PinScreen>
//     with SingleTickerProviderStateMixin {
//   final List<String> _pin = ['', '', '', ''];
//   int _currentIndex = 0;
//   String? _errorMessage;
//   String? _createdPin; // Store the first PIN for confirmation

//   late AnimationController _shakeController;
//   late Animation<double> _offsetAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _shakeController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     _offsetAnimation = Tween(begin: 0.0, end: 24.0)
//         .chain(CurveTween(curve: Curves.elasticIn))
//         .animate(_shakeController);
//   }

//   @override
//   void dispose() {
//     _shakeController.dispose();
//     super.dispose();
//   }

//   String get _title {
//     switch (widget.mode) {
//       case PinScreenMode.create:
//         return 'Create new pin';
//       case PinScreenMode.confirm:
//         return 'Create new pin';
//       case PinScreenMode.validate:
//         return 'Confirm account pin';
//     }
//   }

//   String get _subtitle {
//     switch (widget.mode) {
//       case PinScreenMode.create:
//         return 'The PIN will be used to authorize transactions.';
//       case PinScreenMode.confirm:
//         return 'The PIN will be used to authorize transactions.';
//       case PinScreenMode.validate:
//         return 'Input the pin you just created to confirm';
//     }
//   }

//   void _updatePin(String value) {
//     if (_currentIndex < 4) {
//       setState(() {
//         _pin[_currentIndex] = value;
//         _currentIndex++;
//       });
//       if (_currentIndex == 4) _checkPin();
//     }
//   }

//   void _checkPin() {
//     final entered = _pin.join();

//     switch (widget.mode) {
//       case PinScreenMode.create:
//         // Store the created PIN and move to confirmation
//         _createdPin = entered;
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => PinScreen(
//               mode: PinScreenMode.confirm,
//               initialPin: _createdPin,
//               onCompleted: widget.onCompleted,
//             ),
//           ),
//         );
//         break;

//       case PinScreenMode.confirm:
//         // Check if confirmation matches the initial PIN
//         if (entered == widget.initialPin) {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (context) => PinScreen(
//                 mode: PinScreenMode.validate,
//                 initialPin: widget.initialPin,
//                 onCompleted: widget.onCompleted,
//               ),
//             ),
//           );
//         } else {
//           _showError('PIN does not match. Please try again.');
//         }
//         break;

//       case PinScreenMode.validate:
//         // Final validation
//         if (entered == widget.initialPin) {
//           widget.onCompleted?.call();
//         } else {
//           _showError('Incorrect PIN. Please try again.');
//         }
//         break;
//     }
//   }

//   void _showError(String message) {
//     _shakeController.forward(from: 0);
//     setState(() {
//       _errorMessage = message;
//       _pin.setAll(0, ['', '', '', '']);
//       _currentIndex = 0;
//     });
//   }

//   void _deletePin() {
//     if (_currentIndex > 0) {
//       setState(() {
//         _currentIndex--;
//         _pin[_currentIndex] = '';
//         _errorMessage = null; // Clear error when user starts typing
//       });
//     }
//   }

//   Widget _buildPinDot(int index) {
//     bool isFilled = _pin[index].isNotEmpty;

//     return Container(
//       width: 24.w,
//       height: 24.w,
//       margin: EdgeInsets.symmetric(horizontal: 8.w),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: isFilled ? AppColors.primaryColor : Colors.transparent,
//         border: Border.all(
//           color: AppColors.primaryColor,
//           width: 1.5,
//         ),
//       ),
//     );
//   }

//   Widget _buildNumberButton(String number) {
//     return TextButton(
//       onPressed: () {
//         setState(() => _errorMessage = null);
//         _updatePin(number);
//       },
//       style: TextButton.styleFrom(
//         padding: EdgeInsets.all(20.w),
//         shape: const CircleBorder(),
//       ),
//       child: Text(
//         number,
//         style: context.textTheme.titleLarge!.copyWith(
//           fontSize: 24,
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BundlegramScaffold(
//       appBar: BundlegramAppbar(
//         titleText: _title,
//         showBackButton: true,
//         onTap: () {
//           if (widget.mode == PinScreenMode.create) {
//             context.pop();
//           } else {
//             // Go back to create mode if in confirm/validate
//             Navigator.of(context).pushReplacement(
//               MaterialPageRoute(
//                 builder: (context) => PinScreen(
//                   mode: PinScreenMode.create,
//                   onCompleted: widget.onCompleted,
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//       sidePadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Flexible(
//             child: Column(
//               children: [
//                 10.verticalSpace,
//                 Text(
//                   _subtitle,
//                   textAlign: TextAlign.center,
//                   style: context.textTheme.bodySmall!.copyWith(
//                     color: AppColors.grey33,
//                     fontSize: 16,
//                     height: 1.4,
//                   ),
//                 ),
//                 40.verticalSpace,
//                 AnimatedBuilder(
//                   animation: _shakeController,
//                   builder: (context, child) {
//                     final offset = sin(_offsetAnimation.value) * 12;
//                     return Transform.translate(
//                       offset: Offset(offset, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: List.generate(4, _buildPinDot),
//                       ),
//                     );
//                   },
//                 ),
//                 if (_errorMessage != null) ...[
//                   20.verticalSpace,
//                   Text(
//                     _errorMessage!,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       color: AppColors.errorText,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 1,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: GridView.count(
//                 crossAxisCount: 3,
//                 childAspectRatio: 1.2,
//                 mainAxisSpacing: 10.h,
//                 crossAxisSpacing: 10.w,
//                 padding: EdgeInsets.symmetric(horizontal: 20.w),
//                 children: [
//                   // Numbers 1-9
//                   ...List.generate(
//                       9, (index) => _buildNumberButton('${index + 1}')),

//                   // Fingerprint icon (bottom left)
//                   // Container(
//                   //   alignment: Alignment.center,
//                   //   child: AppSvgIcon(
//                   //     path: Assets.svgs.fingerCricle1,
//                   //     width: 24.w,
//                   //     height: 24.w,
//                   //     fit: BoxFit.contain,
//                   //   ),
//                   // ),

//                   SizedBox(
//                     width: 24,
//                     height: 24,
//                   ), // Empty space for layout

//                   // Number 0
//                   _buildNumberButton('0'),

//                   // Delete button (bottom right)
//                   IconButton(
//                     onPressed: _deletePin,
//                     icon: Icon(
//                       Icons.backspace_outlined,
//                       size: 24,
//                       color: AppColors.grey83,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           // Show "Forgot PIN?" only in validate mode
//           if (widget.mode == PinScreenMode.validate) ...[
//             20.verticalSpace,
//             TextButton(
//               onPressed: () => context.push(RouteConstants.forgetPassword),
//               child: Text(
//                 'Forgot PIN?',
//                 style: context.textTheme.bodyMedium!.copyWith(
//                   fontSize: 16,
//                   color: AppColors.black,
//                 ),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }
