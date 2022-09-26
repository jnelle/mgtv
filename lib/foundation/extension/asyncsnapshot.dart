import 'package:flutter/material.dart';
import 'package:mgtv/gen/colors.gen.dart';

extension PresentAsyncSnapshot<E> on AsyncSnapshot<E> {
  Widget present({
    required BuildContext context,
    Widget Function(BuildContext context)? onNone,
    Widget Function(BuildContext context, E data)? onData,
    Widget Function(BuildContext, Object error, StackTrace stackTrace)? onError,
    Widget Function(BuildContext context)? onDoneWitNeitherDataNorError,
    Widget Function(BuildContext context)? onWaiting,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
        return onNone?.call(context) ?? const SizedBox.shrink();
      case ConnectionState.active:
      case ConnectionState.waiting:
        return Center(
          child: onWaiting?.call(context) ??
              const CircularProgressIndicator(color: ColorName.primaryColor),
        );
      case ConnectionState.done:
        if (hasError) {
          return onError?.call(context, error!, stackTrace!) ??
              const SizedBox.shrink();
        } else if (hasData) {
          return onData?.call(context, data as E) ?? const SizedBox.shrink();
        } else {
          return onDoneWitNeitherDataNorError?.call(context) ??
              const SizedBox.shrink();
        }
    }
  }
}
