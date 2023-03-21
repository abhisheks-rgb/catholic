import 'package:butter/butter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/app.dart';
import 'app/persistor.dart' as p;
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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

  run(store, navigatorKey);
}

void run(Store<AppState> store, GlobalKey<NavigatorState> navigatorKey) =>
    runApp(StoreProvider<AppState>(
      store: store,
      child: App(navigatorKey: navigatorKey),
    ));
