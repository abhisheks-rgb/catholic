import 'package:butter/butter.dart';
import 'package:trcas_catholic/modules/welcome/actions/show_notifs_action.dart';

import '../actions/initialize_qoutes.dart';
import '../actions/show_page_action.dart';
import '../models/welcome_model.dart';

class WelcomeState extends BasePageState<WelcomeModel> {
  WelcomeState();

  WelcomeModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  WelcomeState.build(this.model, void Function(WelcomeModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is WelcomeState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  WelcomeState fromStore() => WelcomeState.build(
          read<WelcomeModel>(
            WelcomeModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.initializeQoute = () => dispatchAction(InitializeQoutes());
        m.showPage = (route) => dispatchAction(ShowPageAction(route));
        m.showNotifs = () => dispatchAction(ShowNotifsAction());
      });
}
