import 'package:butter/butter.dart';

import '../models/notification_details_model.dart';

class NotificationDetailsState extends BasePageState<NotificationDetailsModel> {
  NotificationDetailsState();

  NotificationDetailsModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  NotificationDetailsState.build(
      this.model, void Function(NotificationDetailsModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is NotificationDetailsState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  NotificationDetailsState fromStore() => NotificationDetailsState.build(
          read<NotificationDetailsModel>(
            NotificationDetailsModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
      });
}
