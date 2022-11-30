import 'package:flutter/material.dart';
import 'package:scrumboard/widgets/textfield_general.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: const Center(
          child: TextFieldWidget(),
        ),
      );
}
