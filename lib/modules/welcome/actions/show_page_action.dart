import 'package:butter/butter.dart';

import '../../../service/package_info_service.dart';
import '../../church_bulletin/models/church_bulletin_model.dart';
import '../../church_info/models/church_info_model.dart';
import '../../home/models/home_model.dart';
import '../../offertory/models/offertory_model.dart';
import '../../profile/models/profile_model.dart';
import '../../schedules/models/schedules_model.dart';
import '../../scripture/actions/list_reflection_action.dart';
import '../../scripture/models/scripture_model.dart';

class ShowPageAction extends BaseAction {
  final String route;

  ShowPageAction(this.route);

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('ShowNotifsAction::reduce');

    String newRoute = route;
    Map<String, dynamic>? user;

    bool canRedirect = true;

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
          final packageDetails = await PackageInfoService.getPackageDetails();
          await dispatchModel<ProfileModel>(ProfileModel(), (m) {
            m.user = user;
            m.packageDetails = packageDetails;
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
        await dispatchModel<ChurchBulletinModel>(ChurchBulletinModel(), (m) {
          m.churchName = churchName;
          m.churchLink = churchLink;
        });
        break;
      case '/_/scripture':
        pushNamed(newRoute);
        canRedirect = false;

        await dispatchModel<ScriptureModel>(ScriptureModel(),
            (m) {
          m.loading = true;
        });

        await dispatchAction(ListReflectionAction());
        break;
      default:
    }

    if (canRedirect) {
      pushNamed(newRoute);
    }

    return null;
  }
}
