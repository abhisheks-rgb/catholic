import 'package:butter/butter.dart';

class PrayModel extends BaseUIModel<PrayModel> {
  Map? isToday;
  bool isLoggedIn;
  late void Function(String route) showPage;
  late void Function() checkIsLoggedIn;

  PrayModel({
    this.isToday,
    this.isLoggedIn = false,
  });

  @override
  String get $key => '/pray';

  @override
  PrayModel clone() => PrayModel(
        isToday: isToday,
        isLoggedIn: isLoggedIn,
      );

  @override
  int get hashCode => Object.hashAll([
        isToday,
        isLoggedIn,
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PrayModel &&
          runtimeType == other.runtimeType &&
          isToday == other.isToday &&
          isLoggedIn == other.isLoggedIn;
}
