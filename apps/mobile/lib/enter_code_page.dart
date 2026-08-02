import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'reset_password_page.dart';

class EnterCodePage extends StatefulWidget {
  final String email;
  const EnterCodePage({super.key, required this.email});

  @override
  State<EnterCodePage> createState() => _EnterCodePageState();
}

class _EnterCodePageState extends State<EnterCodePage> {
  final List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  String get code => controllers.map((c) => c.text).join();

  void verify() {
    if (code.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the full 6-digit code')),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ResetPasswordPage(email: widget.email)),
    );
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Enter Code')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter Code',
                style: TextStyle(
                    color: AppColors.accent, fontSize: 26, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              'Enter the 6-digit code sent to your email',
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 44,
                  child: TextField(
                    controller: controllers[i],
                    focusNode: focusNodes[i],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                    decoration: const InputDecoration(counterText: ''),
                    onChanged: (value) {
                      if (value.isNotEmpty && i < 5) {
                        FocusScope.of(context).requestFocus(focusNodes[i + 1]);
                      } else if (value.isEmpty && i > 0) {
                        FocusScope.of(context).requestFocus(focusNodes[i - 1]);
                      }
                    },
                  ),
                );
              }),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: verify,
                child: const Text('Verify'),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Code resent')),
                  );
                },
                child: const Text('Resend Code', style: TextStyle(color: AppColors.accent)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
