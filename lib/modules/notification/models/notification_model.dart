import 'package:butter/butter.dart';

class NotificationModel extends BaseUIModel<NotificationModel> {
  late void Function(String route) showPage;
  //
  String? error;
  bool? loading;

  NotificationModel({
    this.error,
    this.loading,
  });

  @override
  String get $key => '/notification';

  @override
  NotificationModel clone() => NotificationModel(
        error: error,
        loading: loading,
      );

  @override
  int get hashCode => Object.hashAll([
        error,
        loading,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NotificationModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading;
}
