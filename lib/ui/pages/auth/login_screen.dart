import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/ui/components/auth/login_form.dart';
import 'package:mgtv/ui/components/snack_bar/snack_bar.dart';
import 'package:mgtv/ui/hook/use_router.dart';
import 'package:mgtv/ui/route/app_route.dart';
import 'package:mgtv/ui/user_view_model.dart';
import 'package:sized_context/sized_context.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<FormState> formkey =
        useMemoized(() => GlobalKey<FormState>());
    final TextEditingController emailTextController =
        useTextEditingController();
    final TextEditingController passwordTextController =
        useTextEditingController();
    ValueNotifier<bool> isLoading = useState(false);
    StackRouter router = useRouter();
    UserViewModel userViewModel = ref.read(userViewModelProvider);

    Future<void> checkLogin() async {
      bool result = await userViewModel.isLoggedIn();

      if (result) {
        await userViewModel.refreshCookie();
        String? cookie = await userViewModel.getCookie();
        if (cookie != null) {
          userViewModel.setCookie = cookie;
        }
        router.replace(const Home());
      }
    }

    useEffect(() {
      Future<void>.microtask(() => checkLogin());
      return () {};
    }, <Object>[]);

    return Scaffold(
        body: SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Assets.images.logo.svg(
              width: context.widthPct(0.25),
              height: context.widthPct(0.25),
              color: Colors.orange,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(35.0),
              child: LoginFormTemplate(
                isLoading: isLoading.value,
                formkey: formkey,
                emailTextController: emailTextController,
                passwordTextController: passwordTextController,
                key: UniqueKey(),
                onPressed: () async {
                  isLoading.value = true;
                  if (formkey.currentState!.validate()) {
                    try {
                      isLoading.value = true;

                      await userViewModel.login(
                          email: emailTextController.text,
                          password: passwordTextController.text);

                      router.replace(const Home());
                    } catch (e) {
                      isLoading.value = false;
                      showErrorSnackbar(
                          context: context,
                          message: 'Ein Fehler ist beim Login unterlaufen!');
                    }
                  } else {
                    isLoading.value = false;

                    showErrorSnackbar(
                        context: context,
                        message: 'Bitte alle Felder ausfüllen!');
                  }
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
