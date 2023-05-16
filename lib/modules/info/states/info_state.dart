import 'package:butter/butter.dart';

import '../models/info_model.dart';
import '../../church_info/models/church_info_model.dart';
import '../../church_bulletin/models/church_bulletin_model.dart';
import '../../profile/models/profile_model.dart';
import '../../home/models/home_model.dart';
import '../../offertory/models/offertory_model.dart';
import '../../schedules/models/schedules_model.dart';

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
        other is InfoState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  InfoState fromStore() => InfoState.build(
          read<InfoModel>(
            InfoModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route) async {
          String newRoute = route;
          Map<String, dynamic>? user;

          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });

          int? churchId;
          String? churchName;
          String? churchLink;

          if (user != null) {
            churchId = user!['churchId'];
            churchName = user!['churchName'];
            churchLink = user!['churchLink'];
          }

          switch (route) {
            case '/_/profile':
              if (user == null) {
                newRoute = '/_/login';
              } else {
                await dispatchModel<ProfileModel>(ProfileModel(), (m) {
                  m.user = user;
                });
              }
              break;
            case '/_/church_info':
              await dispatchModel<ChurchInfoModel>(ChurchInfoModel(), (m) {
                m.churchId = churchId;
                m.churchName = churchName;
              });
              break;
            case '/_/offertory':
              await dispatchModel<OffertoryModel>(OffertoryModel(), (m) {
                m.churchId = churchId;
                m.churchName = churchName;
              });
              break;
            case '/_/schedules':
              await dispatchModel<SchedulesModel>(SchedulesModel(), (m) {
                m.churchName = churchName;
              });
              break;
            case '/_/church_bulletin':
              await dispatchModel<ChurchBulletinModel>(ChurchBulletinModel(),
                  (m) {
                m.churchName = churchName;
                m.churchLink = churchLink;
              });
              break;
            default:
          }

          pushNamed(newRoute);
        };
        m.checkIsLoggedIn = () async {
          Map<String, dynamic>? user;

          dispatchModel<HomeModel>(HomeModel(), (m) {
            user = m.user;
          });

          await dispatchModel<InfoModel>(InfoModel(), (m) {
            m.isLoggedIn = user == null ? false : true;
          });
        };
      });
}
