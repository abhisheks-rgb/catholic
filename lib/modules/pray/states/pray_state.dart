import 'package:butter/butter.dart';

import '../models/pray_model.dart';
import '../../home/models/home_model.dart';

class PrayState extends BasePageState<PrayModel> {
  PrayState();

  PrayModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  PrayState.build(this.model, void Function(PrayModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PrayState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  PrayState fromStore() => PrayState.build(
          read<PrayModel>(
            PrayModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route) async {
          pushNamed(route);
        };
        m.checkIsLoggedIn = () async {
          Map<String, dynamic>? user;

          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });

          await dispatchModel<PrayModel>(PrayModel(), (m) {
            m.isLoggedIn = user == null ? false : true;
          });
        };
      });
}
