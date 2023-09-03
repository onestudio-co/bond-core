import 'package:bond_form/bond_form.dart';
import 'package:example/features/auth/presentations/providers/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(loginProvider);
    ref.listen(
      loginProvider,
      (previous, next) => _formStateListener(context, previous, next),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) =>
                  ref.read(loginProvider.notifier).update('email', value),
              decoration: InputDecoration(
                labelText: formState.label('email'),
                errorText: formState.error('email'),
                prefixIcon: const Icon(Icons.email),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              onChanged: (value) =>
                  ref.read(loginProvider.notifier).update('password', value),
              decoration: InputDecoration(
                labelText: formState.label('password'),
                errorText: formState.error('password'),
                prefixIcon: const Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 16),
            if (formState.status == BondFormStateStatus.submitting)
              const CircularProgressIndicator()
            else
              MaterialButton(
                onPressed: ref.read(loginProvider.notifier).submit,
                height: 48,
                color: formState.status == BondFormStateStatus.invalid
                    ? Colors.red
                    : Colors.blueAccent,
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  void _formStateListener(
    BuildContext context,
    BondFormState<String, Error>? previous,
    BondFormState<String, Error> next,
  ) {
    if (previous == null || next.status != previous.status) {
      if (next.status == BondFormStateStatus.failed) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.failure.toString()),
            backgroundColor: Colors.red,
          ),
        );
      } else if (next.status == BondFormStateStatus.submitted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Submitted'),
            backgroundColor: Colors.green,
          ),
        );
      }
    }
  }
}
