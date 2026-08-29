import 'package:bundlegram/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A 6-digit OTP input made of individually focused boxes.
///
/// Calls [onChanged] on every keystroke and [onCompleted] once all 6 digits
/// are filled. Does not manage submission itself — the parent decides when
/// to verify. [enabled] disables all boxes (e.g. while verifying), and
/// [hasError] switches the box borders to the app's error color.
class OtpInputRow extends StatefulWidget {
  const OtpInputRow({
    super.key,
    required this.onChanged,
    this.onCompleted,
    this.enabled = true,
    this.hasError = false,
    this.length = 6,
  });

  final ValueChanged<String> onChanged;
  final ValueChanged<String>? onCompleted;
  final bool enabled;
  final bool hasError;
  final int length;

  @override
  State<OtpInputRow> createState() => OtpInputRowState();
}

class OtpInputRowState extends State<OtpInputRow> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.length, (_) => TextEditingController());
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  /// Clears all boxes and resets focus to the first one. Exposed so the
  /// parent can call it after a failed verification or a resend.
  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    _focusNodes.first.requestFocus();
    widget.onChanged('');
  }

  String get _value => _controllers.map((c) => c.text).join();

  void _handleChange(int index, String value) {
    if (value.isNotEmpty && index < widget.length - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    widget.onChanged(_value);
    if (_value.length == widget.length) {
      widget.onCompleted?.call(_value);
    }
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
      _controllers[index - 1].clear();
      widget.onChanged(_value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.hasError ? AppColors.errorText : AppColors.greyD0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: 40.w,
          height: 48.h,
          child: KeyboardListener(
            focusNode: FocusNode(skipTraversal: true),
            onKeyEvent: (event) {
              if (event is KeyDownEvent &&
                  event.logicalKey == LogicalKeyboardKey.backspace) {
                _handleBackspace(index);
              }
            },
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              enabled: widget.enabled,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              maxLength: 1,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                counterText: '',
                filled: true,
                fillColor: widget.enabled ? AppColors.white : AppColors.greyF5,
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: borderColor, width: 1.5),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.greyEE),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(color: borderColor),
                ),
              ),
              onChanged: (value) => _handleChange(index, value),
            ),
          ),
        );
      }),
    );
  }
}
