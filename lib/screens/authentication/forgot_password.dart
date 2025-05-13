import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pretium_finance/screens/authentication/verify.dart';
import 'package:pretium_finance/utilities/dialogs.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleResetPassword() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network call

      if (mounted) {
        CustomDialogs.showSuccessDialog(
          context: context,
          title: AppLocalizations.of(context)!.success,
          content: AppLocalizations.of(context)!.resetPasswordSent,
        ).then(
          (_) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyAccountScreen(email: ''),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        CustomDialogs.showErrorDialog(
          context: context,
          title: AppLocalizations.of(context)!.error,
          content: e.toString(),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header with icon
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_reset,
                      size: 40,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    translations.forgotPassword,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translations.enterEmailForReset,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              // Email field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: translations.email,
                  helperText: translations.validEmailExample,
                  border: const UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return translations.emailRequired;
                  } else if (!RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  ).hasMatch(value)) {
                    return translations.emailInvalid;
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30.0),

              // Reset button
              ElevatedButton(
                onPressed: _isLoading ? null : _handleResetPassword,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                          translations.sendResetCode,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
