import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompleteProfilePage extends ConsumerStatefulWidget {
  const CompleteProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends ConsumerState<CompleteProfilePage> {
  int _currentStep = 0;

  void _nextStep() {
    if (_currentStep < 2) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Stepper Form')),
      body: Stepper(
        currentStep: _currentStep,
        onStepContinue: _nextStep,
        onStepCancel: _previousStep,
        steps: <Step>[
          Step(
            title: const Text('Step 1'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Name'),
                  // Replace with bond_form field management
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Email'),
                  // Replace with bond_form field management
                ),
              ],
            ),
            isActive: _currentStep >= 0,
            state: _currentStep == 0
                ? StepState.editing
                : StepState.complete,
          ),
          Step(
            title: const Text('Step 2'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  // Replace with bond_form field management
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Confirm Password'),
                  // Replace with bond_form field management
                ),
              ],
            ),
            isActive: _currentStep >= 1,
            state: _currentStep == 1
                ? StepState.editing
                : (_currentStep > 1 ? StepState.complete : StepState.disabled),
          ),
          Step(
            title: const Text('Step 3'),
            content: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  // Replace with bond_form field management
                ),
              ],
            ),
            isActive: _currentStep >= 2,
            state: _currentStep == 2
                ? StepState.editing
                : (_currentStep > 2 ? StepState.complete : StepState.disabled),
          ),
        ],
      ),
    );
  }
}