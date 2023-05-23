import 'package:butter/butter.dart';

import '../models/event_register_model.dart';
import '../../home/models/home_model.dart';

class EventRegisterState extends BasePageState<EventRegisterModel> {
  EventRegisterState();

  EventRegisterModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  EventRegisterState.build(this.model, void Function(EventRegisterModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EventRegisterState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  EventRegisterState fromStore() => EventRegisterState.build(
          read<EventRegisterModel>(
            EventRegisterModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.setIsEventRegister = ({isEventRegister}) async {
          return dispatchModel<HomeModel>(HomeModel(), (m) {
            m.isEventRegister = isEventRegister!;
            m.isEventDetails = true;
          });
        };
      });
}
