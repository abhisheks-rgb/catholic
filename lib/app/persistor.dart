import 'package:butter/butter.dart';

class Persistor extends AppPersistor {
  static const int modelCount = 2;

  Persistor(String file) : super(file);

  @override
  Future<void> deleteState() => persist!.delete();

  @override
  Future<void> persistDifference(
      {AppState? lastPersistedState, AppState? newState}) async {
    try {
      // var data = {};

      // var deviceModel = readModel(DeviceModel(), newState);
      // if (deviceModel != readModel(deviceModel, lastPersistedState)) {
      //   data[0] = jsonEncode(deviceModel);
      // }

      // if (data.isNotEmpty) {
      //   var objs = await persist.load();
      //   if (objs == null || objs.length != MODEL_COUNT) {
      //     objs = List.filled(MODEL_COUNT, '{}');
      //   }

      //   data.keys.forEach((key) {
      //     objs[key] = data[key];
      //   });

      //   await persist.save(objs);
      // }
    } catch (e) {
      Butter.e(e.toString());
    }
  }

  @override
  Future<AppState?> readState() async {
    try {
      var objs = await persist!.load();

      if (objs != null && objs.isNotEmpty) {
        return AppState(
          data: {
            // DeviceModel().$key: DeviceModel.fromJson(jsonDecode(objs[0])),
          },
        );
      }
    } catch (e) {
      Butter.e(e.toString());
    }

    return AppState(data: <String, dynamic>{});
  }

  T? readModel<T extends BaseUIModel>(T defModel, AppState? store) =>
      store == null ? defModel : store.read(defModel.$key, defModel);
}
