import 'package:butter/butter.dart';

import '../models/confession_model.dart';

class ConfessionState extends BasePageState<ConfessionModel> {
  ConfessionState();

  ConfessionModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  ConfessionState.build(this.model, void Function(ConfessionModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ConfessionState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  ConfessionState fromStore() => ConfessionState.build(
          read<ConfessionModel>(
            ConfessionModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.setShowInfo = () {
          dispatchModel<ConfessionModel>(ConfessionModel(), (m) {
            m.showInfo = false;
          });
        };
      });
}
