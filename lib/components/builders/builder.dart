import 'package:flutter/material.dart';


typedef LoadingCallback = Widget Function();
typedef ErrorCallback = Widget Function(Object error);
typedef BuildCallback<T> = Widget Function(BuildContext context, T data);


abstract class BuilderBase<T> {
  final LoadingCallback onLoading;

  final ErrorCallback onError;

  final BuildCallback<T> builder;

  BuilderBase(this.onLoading, this.onError, this.builder);

  Widget build(BuildContext context);
}
