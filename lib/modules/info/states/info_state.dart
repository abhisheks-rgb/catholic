import 'package:butter/butter.dart';

import '../models/info_model.dart';

class InfoState extends BasePageState<InfoModel> {
  InfoState();

  InfoModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  InfoState.build(this.model, void Function(InfoModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is InfoState && runtimeType == other.runtimeType;
  }

  @override
  // ignore: recursive_getters
  int get hashCode => hashCode;

  @override
  InfoState fromStore() => InfoState.build(
          read<InfoModel>(
            InfoModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route) async {
          pushNamed(route);
        };
      });
}
