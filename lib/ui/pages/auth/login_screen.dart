import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mgtv/gen/assets.gen.dart';
import 'package:mgtv/ui/components/auth/login_form.dart';
import 'package:sized_context/sized_context.dart';

class LoginScreen extends HookConsumerWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              padding: const EdgeInsets.all(8.0),
              child: LoginFormTemplate(
                key: UniqueKey(),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
