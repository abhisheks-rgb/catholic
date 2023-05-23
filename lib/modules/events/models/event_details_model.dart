import 'package:butter/butter.dart';

class EventDetailsModel extends BaseUIModel<EventDetailsModel> {
  Map<Object?, Object?>? item;
  //
  String? error;
  bool? loading;

  EventDetailsModel({
    this.item,
    this.error,
    this.loading,
  });

  late Function({bool? isEventDetails}) setIsEventDetails;

  @override
  String get $key => '/event_details';

  @override
  EventDetailsModel clone() => EventDetailsModel(
        item: item ?? {},
        error: error,
        loading: loading,
      );

  @override
  int get hashCode => Object.hashAll([
        item,
        error,
        loading,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventDetailsModel &&
          runtimeType == other.runtimeType &&
          item == other.item &&
          error == other.error &&
          loading == other.loading;
}
