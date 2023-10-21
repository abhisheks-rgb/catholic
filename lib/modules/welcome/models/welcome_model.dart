import 'package:butter/butter.dart';
// import 'package:new_version_plus/new_version_plus.dart';

class WelcomeModel extends BaseUIModel<WelcomeModel> {
  bool loading;
  Map<String, dynamic>? user;
  Map<dynamic, dynamic>? appVersion;
  Map<dynamic, dynamic>? dbVersion;
  bool canUpdate = false;
  // VersionStatus? versionPlus;
  late void Function(String route) showPage;
  late void Function(Object? notificationObject, bool show) setNotification;
  late void Function() showNotifs;
  late Future<void> Function() initializeQoute;
  late Future<void> Function() initializeUser;
  bool hasNotif = false;
  String notifId = '';
  Object? notificationObject;

  WelcomeModel({
    this.loading = false,
    this.user,
    this.appVersion,
    this.dbVersion,
    this.hasNotif = false,
    this.notificationObject,
    this.notifId = '',
    this.canUpdate = false,
    // this.versionPlus
  });

  @override
  String get $key => '/welcome';

  @override
  WelcomeModel clone() => WelcomeModel(
        loading: loading,
        user: user,
        appVersion: appVersion,
        dbVersion: dbVersion,
        hasNotif: hasNotif,
        notificationObject: notificationObject,
        notifId: notifId,
        canUpdate: canUpdate,
        // versionPlus: versionPlus
      );

  @override
  int get hashCode => Object.hashAll([
        loading, user, appVersion, dbVersion, hasNotif,
        notificationObject,
        notifId,
        canUpdate,
        //  versionPlus
      ]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WelcomeModel &&
          runtimeType == other.runtimeType &&
          loading == other.loading &&
          user == other.user &&
          appVersion == other.appVersion &&
          dbVersion == other.dbVersion &&
          hasNotif == other.hasNotif &&
          notificationObject == other.notificationObject &&
          notifId == other.notifId &&
          canUpdate == other.canUpdate
      //  &&
      // versionPlus == other.versionPlus
      ;
}
