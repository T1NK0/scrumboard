import 'package:flutter/material.dart';
import 'package:scrumboard/widgets/textfield_general.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[400],
          title: const Text('Login'),
        ),
        body: const Center(
          child: TextFieldWidget(),
        ),
      );
}