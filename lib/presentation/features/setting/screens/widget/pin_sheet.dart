import 'package:bundlegram/core/utils/enums.dart';
import 'package:bundlegram/presentation/features/setting/provider/create_pin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'pin_content.dart';

class PinSheet extends ConsumerStatefulWidget {
  final VoidCallback? onPinCreated;

  const PinSheet({
    Key? key,
    this.onPinCreated,
  }) : super(key: key);

  @override
  ConsumerState<PinSheet> createState() => _PinSheetState();
}

class _PinSheetState extends ConsumerState<PinSheet> {
  @override
  void initState() {
    super.initState();
    // Initialize the controller with CREATE mode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pinControllerProvider.notifier).start(
            PinScreenMode.create,
            onComplete: _handleModeTransition,
          );
    });
  }

  void _handleModeTransition() {
    // This is called when user completes the CREATE mode
    // The provider will have already set mode to CONFIRM
    // Just rebuild to show the confirm state
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // height: 55-70% of screen depending on keyboard; adjust if needed
    final controller = ref.watch(pinControllerProvider);
    final height = MediaQuery.of(context).size.height * 0.62;
    return SizedBox(
      height: height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // PinContent(
          //   compact: true,
          //   useResponsive: true,
          // ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Text(
              controller.mode == PinScreenMode.create
                  ? 'Create Your PIN'
                  : 'Confirm Your PIN',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: PinContent(
              compact: true,
              useResponsive: true,
              onComplete: () {
                // Called when PIN is successfully created on server
                if (widget.onPinCreated != null) {
                  widget.onPinCreated!();
                }
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
