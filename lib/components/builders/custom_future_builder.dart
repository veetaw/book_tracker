import 'dart:async';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'builder.dart';

class CustomFutureBuilder<T> extends StatelessWidget implements BuilderBase<T> {
  final Future<T> future;
  final T initialData;
  final LoadingCallback onLoading;
  final ErrorCallback onError;
  final BuildCallback<T> builder;

  const CustomFutureBuilder({
    @required this.future,
    @required this.builder,
    this.initialData,
    this.onLoading,
    this.onError,
    Key key,
  })  : assert(builder != null),
        assert(future != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      key: key,
      future: future,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return onError != null ? onError(snapshot.error) : Container();
        if (!snapshot.hasData)
          return onLoading != null
              ? onLoading()
              : const CircularProgressIndicator();
        return builder(context, snapshot.data);
      },
    );
  }
}
