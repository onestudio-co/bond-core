import 'package:example/features/form/login_provider/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginFormPage extends ConsumerWidget {
  const LoginFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginNotifier = ref.watch(loginNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {},
              decoration: InputDecoration(
                  labelText: loginNotifier.label('email'),
                  errorText: loginNotifier.error('email'),
                  prefixIcon: const Icon(
                      Icons.email)), // InputDecoration ), // TextFormField
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) {},
              decoration: InputDecoration(
                  labelText: loginNotifier.label('password'),
                  errorText: loginNotifier.error('password'),
                  prefixIcon: const Icon(
                      Icons.lock)), // InputDecoration ), // TextFormField
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {},
                height: 48,
                color: Colors.blueAccent,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
