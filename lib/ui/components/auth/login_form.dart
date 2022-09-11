import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/gen/colors.gen.dart';
import 'package:mgtv/ui/components/auth/input_decoration.dart';
import 'package:mgtv/ui/components/snack_bar/snack_bar.dart';
import 'package:mgtv/ui/user_view_model.dart';

class LoginFormTemplate extends HookConsumerWidget {
  const LoginFormTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formkey =
        useMemoized(() => GlobalKey<FormState>());
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    ValueNotifier<bool> isLoading = useState(false);
    UserViewModel userViewModel = ref.read(userViewModelProvider);
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
            child: isLoading.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      CircularProgressIndicator(color: Colors.white),
                      SizedBox(width: 24),
                      Text('Bitte warten...'),
                    ],
                  )
                : const Text('Login'),
            onPressed: () async {
              isLoading.value = true;
              if (formkey.currentState!.validate()) {
                await userViewModel.login(
                    email: emailTextController.text,
                    password: passwordTextController.text);
              } else {
                showErrorSnackbar(
                    context: context, message: 'Bitte alle Felder ausfüllen!');
                isLoading.value = false;
              }
            },
          ),
        ],
      ),
    );
  }
}
