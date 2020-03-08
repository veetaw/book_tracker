import 'dart:async';

import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'builder.dart';

class CustomStreamBuilder<T> extends StatelessWidget implements BuilderBase<T> {
  final Stream<T> stream;
  final T initialData;
  final LoadingCallback onLoading;
  final ErrorCallback onError;
  final BuildCallback<T> builder;

  const CustomStreamBuilder({
    @required this.stream,
    @required this.builder,
    this.initialData,
    this.onLoading,
    this.onError,
    Key key,
  })  : assert(builder != null),
        assert(stream != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      key: key,
      stream: stream,
      initialData: initialData,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return onError != null ? onError(snapshot.error) : Container();
        if (!snapshot.hasData)
          return onLoading != null
              ? onLoading()
              : Center(child: CircularProgressIndicator());
        return builder(context, snapshot.data);
      },
    );
  }
}
