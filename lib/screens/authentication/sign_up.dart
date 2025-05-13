// ignore_for_file: use_build_context_synchronously

import 'package:pretium_finance/providers/navigation_service_provider.dart';
import 'package:pretium_finance/providers/auth.dart';
import 'package:pretium_finance/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final translations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(translations.register)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed:
                () => NavigationService.navigatorKey.currentState
                    ?.pushReplacementNamed(NavigationService.dashboard),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.05),
              Text(
                AppLocalizations.of(context)!.createAccount,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.primaryColor,
                ),
                textAlign: TextAlign.start,
              ),
              Text(
                AppLocalizations.of(context)!.simplifyCryptoPayment,
                style: theme.textTheme.labelLarge?.copyWith(),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 20.0),

              // First Name Field
              TextFormField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: translations.firstName,
                  helperText: translations.enterFirstName,
                ),
                validator:
                    (value) =>
                        value?.isEmpty ?? true
                            ? translations.firstNameRequired
                            : null,
              ),
              const SizedBox(height: 20.0),

              // Last Name Field
              TextFormField(
                controller: _lastnameController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: translations.lastName,
                  helperText: translations.enterLastName,
                ),
                validator:
                    (value) =>
                        value?.isEmpty ?? true
                            ? translations.lastNameRequired
                            : null,
              ),
              const SizedBox(height: 20.0),

              // Email Field
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: translations.email,
                  helperText: translations.validEmailExample,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return translations.emailRequired;
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value!)) {
                    return translations.emailInvalid;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Password Field
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  helperText: translations.passwordRequirements,
                  labelText: translations.password,
                ),
                obscureText: _obscurePassword,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return translations.passwordRequired;
                  }
                  if (value!.length < 8) return translations.passwordLength;
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Confirm Password Field
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                  labelText: translations.confirmPassword,
                ),
                obscureText: _obscureConfirmPassword,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return translations.confirmPasswordRequired;
                  }
                  if (value != _passwordController.text) {
                    return translations.passwordsDontMatch;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0),

              // Terms and Conditions Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _acceptTerms,
                    onChanged: (value) {
                      setState(() {
                        _acceptTerms = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: translations.termsAndConditions,
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),

              // Sign Up Button
              ElevatedButton(
                onPressed: _handleSignUp,
                child: Text(translations.signUp),
              ),
              const SizedBox(height: 40.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translations.alreadyHaveAccount),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      translations.login,
                      style: theme.textTheme.labelLarge?.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignUp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    try {
      await ref
          .read(userProvider.notifier)
          .signUp(
            _firstnameController.text.trim(),
            _lastnameController.text.trim(),
            _emailController.text.trim(),
            '',
            _passwordController.text.trim(),
          );

      CustomDialogs.showSuccessDialog(
        // ignore: duplicate_ignore
        // ignore: use_build_context_synchronously
        context: context,
        title: AppLocalizations.of(context)!.success,
        content: AppLocalizations.of(context)!.signUpSuccess,
      ).then((_) => Navigator.pushReplacementNamed(context, '/'));
    } catch (e) {
      CustomDialogs.showErrorDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        content: e.toString(),
      );
    }
  }
}
