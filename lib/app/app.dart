import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../app/routes.dart';

import 'theme.dart';

class App extends StatelessWidget {
  static Routes routes = Routes();
  final GlobalKey<NavigatorState> navigatorKey;

  const App({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.title,
      navigatorKey: navigatorKey,
      onGenerateRoute: routes.onGenerateRoute,
      initialRoute: routes.defaultModule?.routeName,
      theme: BrandColors.theme,
    );
  }

  /// Shorthand for retrieving the current child route
  static BasePageConnector<BasePageState<BaseUIModel>, BasePageView>? getChild(
      BuildContext context, BaseUIModel model,
      [String? routeName]) {
    try {
      return App.routes.routes![model.$key]!.getChild(context, routeName);
    } catch (e) {
      Butter.d(App.routes.routes![model.$key]!.routes.entries.first);
      Butter.d(e.toString());
      return null;
    }
  }

  /// Shorthand for retrieving the current route
  static String? getRouteName(BuildContext context) =>
      BaseNavigator.getRouteName(context);

  /// Shorthand for extracting page arguments
  static T getPageArgs<T>(BuildContext context) =>
      (ModalRoute.of(context)?.settings.arguments as PageArguments).arg;
}
