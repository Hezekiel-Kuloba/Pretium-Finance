import 'package:pretium_finance/providers/auth.dart';
import 'package:pretium_finance/screens/authentication/forgot_password.dart';
import 'package:pretium_finance/screens/authentication/sign_up.dart';
import 'package:pretium_finance/utilities/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(userProvider.notifier)
          .login(_emailController.text, _passwordController.text);

      if (mounted) {
        CustomDialogs.showSuccessDialog(
          context: context,
          title: "",
          content: AppLocalizations.of(context)!.loginSuccess,
        ).then((_) => Navigator.pushReplacementNamed(context, '/'));
      }
    } catch (e) {
      if (mounted) {
        CustomDialogs.showErrorDialog(
          context: context,
          title: AppLocalizations.of(context)!.error,
          content: AppLocalizations.of(context)!.invalidCredentials,
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final translations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(translations.login)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Added wallet icon with welcome back message
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.primaryColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.account_balance_wallet,
                      size: 40,
                      color: theme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.welcomeBack,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.signInToContinue,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.05),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  icon: const Icon(Icons.email),
                  labelText: translations.email,
                  helperText: translations.emailHelper,
                  border: const UnderlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
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
              const SizedBox(height: 20.0),
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
                  helperText: translations.passwordHelper,
                  labelText: translations.password,
                  border: const UnderlineInputBorder(),
                ),
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return translations.passwordRequired;
                  } else if (value.length < 8) {
                    return translations.passwordLength;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10.0),

              // Remember me and Forgot password row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(
                        translations.rememberMe,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPasswordScreen(),
                        ),
                      );
                    },
                    child: Text(
                      translations.forgotPassword,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                          translations.signIn,
                          style: const TextStyle(letterSpacing: 2),
                        ),
              ),

              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(translations.noAccount),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: Text(
                      translations.signUp,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
}
