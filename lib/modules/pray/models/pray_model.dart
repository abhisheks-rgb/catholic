import 'package:butter/butter.dart';

class PrayModel extends BaseUIModel<PrayModel> {
  Map? isToday;
  late void Function(String route) showPage;

  PrayModel({
    this.isToday,
  });

  @override
  String get $key => '/pray';

  @override
  PrayModel clone() => PrayModel(isToday: isToday);

  @override
  int get hashCode => Object.hashAll([
        isToday,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayModel &&
          runtimeType == other.runtimeType &&
          isToday == other.isToday;
}
