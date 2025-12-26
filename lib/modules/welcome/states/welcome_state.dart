import 'package:butter/butter.dart';
import 'package:trcas_catholic/modules/home/models/home_model.dart';
import 'package:trcas_catholic/modules/welcome/actions/notif_received_action.dart';
import 'package:trcas_catholic/modules/welcome/actions/show_notifs_action.dart';

import '../actions/initialize_qoutes.dart';
import '../actions/show_page_action.dart';
import '../models/welcome_model.dart';

class WelcomeState extends BasePageState<WelcomeModel> {
  WelcomeState();

  WelcomeModel? model;

  WelcomeState.build(this.model, void Function(WelcomeModel m) f)
    : super.build(model!, f);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is WelcomeState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([runtimeType, model]);

  @override
  WelcomeState fromStore() {
    final homeModel = read<HomeModel>(HomeModel());

    final welcomeModel = WelcomeModel()
      ..continueWatchingVideos = homeModel.continueWatchingVideos
      ..user = homeModel.user
      ..appVersion = homeModel.appVersion
      ..dbVersion = homeModel.dbVersion
      ..dbOjects = homeModel.dbOjects;

    return WelcomeState.build(welcomeModel, (m) {
      m.initializeQoute = () => dispatchAction(InitializeQoutes());

      m.showPage = (route) => dispatchAction(ShowPageAction(route));

      m.setNotification = (obj, show) =>
          dispatchAction(NotifReceivedAction(obj, show));
      m.showNotifs = () => dispatchAction(ShowNotifsAction());
    });
  }
}
