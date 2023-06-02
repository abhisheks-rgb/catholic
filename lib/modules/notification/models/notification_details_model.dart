import 'package:butter/butter.dart';

class NotificationDetailsModel extends BaseUIModel<NotificationDetailsModel> {
  // late void Function(String route) showPage;
  //
  String? error;
  bool? loading;
  Map? item;

  NotificationDetailsModel({
    this.error,
    this.loading,
    this.item,
  });

  @override
  String get $key => '/notification_details';

  @override
  NotificationDetailsModel clone() => NotificationDetailsModel(
        error: error,
        loading: loading,
        item: item,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
        item,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationDetailsModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading &&
          item == other.item;
}
