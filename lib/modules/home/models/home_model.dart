import 'package:butter/butter.dart';
import 'package:flutter/widgets.dart';

class HomeModel extends BaseUIModel<HomeModel> {
  String? error;
  bool initialized;
  bool loading;
  String? title;
  Map<String, dynamic>? user;
  bool isFullScreen;

  late Future<void> Function(BuildContext context) initialize;
  void Function({
    BuildContext? context,
    bool? replaceCurrent,
    String? route,
    String? selectedId,
    bool? allowSameId,
  })? selectMenuItem;

  Future<void> Function(BaseAction action)? dispatch;
  T? Function<T extends BaseUIModel>(T m)? read;

  HomeModel({
    this.error,
    this.initialized = false,
    this.loading = false,
    this.title = '',
    this.user,
    this.isFullScreen = false,
  });

  @override
  String get $key => '/_';

  @override
  HomeModel clone() => HomeModel(
        error: error,
        initialized: initialized,
        loading: loading,
        title: title,
        user: user,
        isFullScreen: isFullScreen,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        initialized,
        loading,
        title,
        user,
        isFullScreen,
      ]);

  //
  // [initialized] and [selectedId] should not affect the model changes
  //
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          initialized == other.initialized &&
          loading == other.loading &&
          title == other.title &&
          user == other.user &&
          isFullScreen == other.isFullScreen;
}
