import 'package:butter/butter.dart';

class DevotionModel extends BaseUIModel<DevotionModel> {
  //
  String? error;
  bool? loading;

  DevotionModel({
    this.error,
    this.loading,
  });

  @override
  String get $key => '/devotion';

  @override
  DevotionModel clone() => DevotionModel(
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
      other is DevotionModel &&
          runtimeType == other.runtimeType &&
          error == other.error &&
          loading == other.loading;
}
