import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SecurityConfirmationScreen extends StatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback? onCancel; // Add optional cancel callback
  final String securityType;

  const SecurityConfirmationScreen({
    super.key,
    required this.onSuccess,
    this.onCancel,
    required this.securityType,
  });

  @override
  State<SecurityConfirmationScreen> createState() =>
      _SecurityConfirmationScreenState();
}

class _SecurityConfirmationScreenState
    extends State<SecurityConfirmationScreen> {
  bool _isFormValid = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validateForm);
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (_isFormValid != isValid) {
      setState(() {
        _isFormValid = isValid;
      });
    }
  }

  Future<void> _handleContinue() async {
    if (!_isFormValid || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate password verification
      await Future.delayed(const Duration(seconds: 1));

      // Call success callback
      widget.onSuccess();

      // Navigate back to previous screen
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        context
            .showErrorSnackBar('Failed to verify password. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        // Call cancel callback when user goes back
        if (didPop && widget.onCancel != null) {
          widget.onCancel!();
        }
      },
      child: BundlegramScaffold(
        appBar: const BundlegramAppbar(
          titleText: 'Enter your password',
          showBackButton: true,
        ),
        body: Column(
          children: [
            Flexible(
              child: AppForm(
                isExpanded: false,
                isActive: _isFormValid && !_isLoading,
                onPressed: _handleContinue,
                buttonText: _isLoading ? 'Verifying...' : 'Continue',
                formKey: _formKey,
                children: [
                  AppTextField(
                    controller: _passwordController,
                    obscureText: true,
                    hintText: 'Password',
                    validateFunction: Validators.passcode(),
                    onChange: (_) => _validateForm(),
                    enabled: !_isLoading,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
