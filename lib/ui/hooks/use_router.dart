import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

StackRouter useRouter() {
  final BuildContext context = useContext();
  return AutoRouter.of(context);
}
