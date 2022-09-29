import 'package:flutter/material.dart';
import 'package:mgtv/ui/components/shimmer/shimmer.dart';

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
                const ShimmerWidget(
                  height: 300,
                ));
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

  List<Widget> presents({
    required BuildContext context,
    Widget Function(BuildContext context)? onNone,
    List<Widget> Function(BuildContext context, E data)? onData,
    Widget Function(BuildContext, Object error, StackTrace stackTrace)? onError,
    Widget Function(BuildContext context)? onDoneWitNeitherDataNorError,
    Widget Function(BuildContext context)? onWaiting,
  }) {
    switch (connectionState) {
      case ConnectionState.none:
        return <Widget>[onNone?.call(context) ?? const SizedBox.shrink()];
      case ConnectionState.active:
      case ConnectionState.waiting:
        return <Widget>[
          Center(
            child: onWaiting?.call(context) ??
                const ShimmerWidget(
                  height: 300,
                ),
          )
        ];
      case ConnectionState.done:
        if (hasError) {
          return <Widget>[
            onError?.call(context, error!, stackTrace!) ??
                const SizedBox.shrink()
          ];
        } else if (hasData) {
          return onData?.call(context, data as E) ??
              <Widget>[const SizedBox.shrink()];
        } else {
          return <Widget>[
            onDoneWitNeitherDataNorError?.call(context) ??
                const SizedBox.shrink()
          ];
        }
    }
  }
}
