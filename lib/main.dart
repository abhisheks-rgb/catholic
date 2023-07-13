import 'package:butter/butter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app/app.dart';
import 'app/persistor.dart' as p;
import 'firebase_options.dart';
// import 'service/firebase_service.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final firebaseOptions = await DefaultFirebaseOptions().init();
  await Firebase.initializeApp(
    options: firebaseOptions.currentPlatform,
  );

  final persistor = p.Persistor('mycatholicsg');
  AppState? initialState = await persistor.readState();
  if (initialState == null) {
    initialState = AppState(data: <String, dynamic>{});
    await persistor.saveInitialState(initialState);
  }

  final store = Store<AppState>(
    initialState: initialState,
    persistor: persistor,
  );
  final navigatorKey = GlobalKey<NavigatorState>();
  NavigateAction.setNavigatorKey(navigatorKey);

  // await FirebaseService.initialize(store);

  // Firebase crashlytics
  // Pass all uncaught "fatal" errors from the framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  run(store, navigatorKey);
}

void run(Store<AppState> store, GlobalKey<NavigatorState> navigatorKey) =>
    runApp(StoreProvider<AppState>(
      store: store,
      child: App(navigatorKey: navigatorKey),
    ));
