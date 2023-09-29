import 'package:butter/butter.dart';

class NotificationModel extends BaseUIModel<NotificationModel> {
  late void Function({String? route, Map? element}) showPage;
  //
  String? error;
  bool? loading;
  bool? showNotification;
  List<Object>? items;

  late Future<List<Object>?> Function({int? orgId}) fetchChurchInfo;

  NotificationModel(
      {this.error, this.loading, this.items, this.showNotification});

  @override
  String get $key => '/notification';

  @override
  NotificationModel clone() => NotificationModel(
        error: error,
        loading: loading,
        items: items,
        showNotification: showNotification,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        items,
        showNotification,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          items == other.items &&
          showNotification == other.showNotification;
}
