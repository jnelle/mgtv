import 'package:flutter/material.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/auth/input_decoration.dart';

class LoginFormTemplate extends StatelessWidget {
  const LoginFormTemplate({
    Key? key,
    required this.formkey,
    required this.emailTextController,
    required this.passwordTextController,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  final GlobalKey<FormState> formkey;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;
  final bool isLoading;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextFormField(
              validator: (String? value) {
                return value!.isEmpty
                    ? 'Bitte geben Sie eine E-Mail Adresse ein'
                    : null;
              },
              controller: emailTextController,
              decoration: buildInputDecoration(
                label: 'E-Mail',
                hint: 'max@beispiel.de',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: TextFormField(
              validator: (String? value) {
                return value!.isEmpty
                    ? 'Bitte geben Sie ein Passwort ein'
                    : null;
              },
              obscureText: true,
              controller: passwordTextController,
              decoration: buildInputDecoration(
                label: 'Passwort',
                hint: '',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: ColorName.submitButtonBackground,
              padding: const EdgeInsets.all(15),
              textStyle: const TextStyle(fontSize: 18),
              minimumSize: const Size.fromHeight(50),
              shape: const StadiumBorder(),
            ),
            onPressed: onPressed,
            child: isLoading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(width: 24),
                      Text('Bitte warten...'),
                    ],
                  )
                : const Text('Login'),
          ),
        ],
      ),
    );
  }
}
