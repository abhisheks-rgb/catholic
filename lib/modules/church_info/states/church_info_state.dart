import 'package:butter/butter.dart';

import '../models/church_info_model.dart';

class ChurchInfoState extends BasePageState<ChurchInfoModel> {
  ChurchInfoState();

  ChurchInfoModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  ChurchInfoState.build(this.model, void Function(ChurchInfoModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ChurchInfoState && runtimeType == other.runtimeType;
  }

  @override
  // ignore: recursive_getters
  int get hashCode => hashCode;

  @override
  ChurchInfoState fromStore() => ChurchInfoState.build(
          read<ChurchInfoModel>(
            ChurchInfoModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route) async {
          pushNamed(route);
        };
      });
}
