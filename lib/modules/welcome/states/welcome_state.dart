import 'package:butter/butter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/welcome_model.dart';
import '../../home/models/home_model.dart';

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
        other is WelcomeState && runtimeType == other.runtimeType;
  }

  @override
  // ignore: recursive_getters
  int get hashCode => hashCode;

  @override
  WelcomeState fromStore() => WelcomeState.build(
          read<WelcomeModel>(
            WelcomeModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route) async {
          String newRoute = route;

          if (route == '/_/profile') {
            User? currentUser = FirebaseAuth.instance.currentUser;
            if (currentUser != null) {
              Map<String, dynamic>? user;
              await FirebaseFirestore.instance
                  .doc('users/${currentUser.uid}')
                  .get()
                  .then((value) async {
                user = value.data();

                await dispatchModel<HomeModel>(HomeModel(), (m) {
                  user = m.user;
                });
                pushNamed(newRoute);
              }).onError((error, stackTrace) {
                Butter.e(error.toString());
                Butter.e(stackTrace.toString());
                error = error.toString();

                if (user == null) {
                  pushNamed('/_/login');
                }
              });
            } else {
              pushNamed('/_/login');
            }
          } else {
            pushNamed(newRoute);
          }
        };
      });
}
