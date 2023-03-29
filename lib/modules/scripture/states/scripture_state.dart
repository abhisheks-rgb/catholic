import 'package:butter/butter.dart';

import '../actions/list_reflection_action.dart';
import '../actions/view_scripture_details_action.dart';
import '../actions/view_scripture_history_action.dart';
import '../models/scripture_model.dart';

class ScriptureState extends BasePageState<ScriptureModel> {
  ScriptureState();

  ScriptureModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  ScriptureState.build(this.model, void Function(ScriptureModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ScriptureState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  ScriptureState fromStore() => ScriptureState.build(
          read<ScriptureModel>(
            ScriptureModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.fetchReflections = ({quantity}) async {
          await dispatchAction(ListReflectionAction(quantity: quantity));
          final model = read<ScriptureModel>(ScriptureModel());
          if (model.error != null) {
            throw model.error!;
          }
          return model.items;
        };
        m.viewHistory = (authorname, data) => dispatchAction(ViewScriptureHistoryAction(authorname, data));
        m.viewScriptureDetails = (scripture) => dispatchAction(ViewScriptureDetailsAction(scripture!));
      });
}
