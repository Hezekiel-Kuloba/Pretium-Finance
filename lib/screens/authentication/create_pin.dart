import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pretium_finance/screens/authentication/confirm_pin.dart';
import 'package:pretium_finance/utilities/dialogs.dart';

class CreatePinScreen extends ConsumerStatefulWidget {
  const CreatePinScreen({super.key});

  @override
  _CreatePinScreenState createState() => _CreatePinScreenState();
}

class _CreatePinScreenState extends ConsumerState<CreatePinScreen> {
  final List<TextEditingController> _pinControllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _handleCreatePin() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final pin = _pinControllers.map((c) => c.text).join();
    if (pin.length != 4) {
      CustomDialogs.showErrorDialog(
        context: context,
        title: AppLocalizations.of(context)!.error,
        content: AppLocalizations.of(context)!.pinLengthError,
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await Future.delayed(const Duration(seconds: 2)); // Simulate network call
      if (mounted) {
        CustomDialogs.showSuccessDialog(
          context: context,
          title: AppLocalizations.of(context)!.success,
          content: AppLocalizations.of(context)!.pinCreated,
        ).then(
          (_) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ConfirmPinScreen(createdPin: pin),
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

  void _addDigit(String digit) {
    for (int i = 0; i < _pinControllers.length; i++) {
      if (_pinControllers[i].text.isEmpty) {
        setState(() {
          _pinControllers[i].text = digit;
        });
        break;
      }
    }
    if (_pinControllers.every((c) => c.text.isNotEmpty)) {
      _handleCreatePin();
    }
  }

  void _deleteDigit() {
    for (int i = _pinControllers.length - 1; i >= 0; i--) {
      if (_pinControllers[i].text.isNotEmpty) {
        setState(() {
          _pinControllers[i].clear();
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: const Color(0xFF2E7D7D),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 36.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.lock,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    translations.createADigitPin,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              _pinControllers[index].text.isNotEmpty
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.3),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    translations.pinWillBeRequired,
                    style: const TextStyle(fontSize: 14, color: Colors.white70),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity, // Constrain the width
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildNumberButton('1'),
                            _buildNumberButton('2'),
                            _buildNumberButton('3'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildNumberButton('4'),
                            _buildNumberButton('5'),
                            _buildNumberButton('6'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildNumberButton('7'),
                            _buildNumberButton('8'),
                            _buildNumberButton('9'),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 32),
                            _buildNumberButton('0'),
                            _buildDeleteButton(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberButton(String number) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 60, // Fixed width to prevent infinite constraints
        height: 60, // Fixed height for consistency
        child: ElevatedButton(
          onPressed: () => _addDigit(number),
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.white.withOpacity(0.1),
          ),
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 60, // Fixed width to prevent infinite constraints
        height: 60, // Fixed height for consistency
        child: ElevatedButton(
          onPressed: _deleteDigit,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: Colors.white.withOpacity(0.1),
            padding: EdgeInsets.zero, // Remove default padding
            minimumSize: const Size(60, 60), // Match the SizedBox dimensions
          ),
          child: const Center(
            child: Icon(Icons.backspace, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}
