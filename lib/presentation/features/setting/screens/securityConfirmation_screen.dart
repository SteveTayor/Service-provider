import 'package:bundlegram/core/extensions/snackbar_extension.dart';
import 'package:bundlegram/core/utils/colors.dart';
import 'package:bundlegram/core/utils/validators.dart';
import 'package:bundlegram/data/datasources/local/secure_storage_helper.dart';
import 'package:bundlegram/presentation/general_widget/app_bar.dart';
import 'package:bundlegram/presentation/general_widget/app_form.dart';
import 'package:bundlegram/presentation/general_widget/app_scaffold.dart';
import 'package:bundlegram/presentation/general_widget/app_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SecurityConfirmationScreen extends ConsumerStatefulWidget {
  final VoidCallback onSuccess;
  final VoidCallback? onCancel;
  final String securityType;

  const SecurityConfirmationScreen({
    super.key,
    required this.onSuccess,
    this.onCancel,
    required this.securityType,
  });

  @override
  ConsumerState<SecurityConfirmationScreen> createState() =>
      _SecurityConfirmationScreenState();
}

class _SecurityConfirmationScreenState
    extends ConsumerState<SecurityConfirmationScreen> {
  bool _isFormValid = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  bool showPasswrd = true;

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
      // Verify password against stored password
      final secureStorage = ref.read(secureStorageHelperProvider);
      final storedPassword = await secureStorage.getPassword();
      if (_passwordController.text != storedPassword) {
        context.showErrorSnackBar('Incorrect password');
        return;
      }

      // Call success callback
      widget.onSuccess();

      // Navigate back to previous screen
      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar('Failed to verify password: $e');
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
                    obscureText: showPasswrd,
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () => setState(() => showPasswrd = !showPasswrd),
                      child: Icon(
                        showPasswrd ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.grey33,
                        size: 24,
                      ),
                    ),
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
