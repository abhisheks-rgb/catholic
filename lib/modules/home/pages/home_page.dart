import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../../../app/app.dart';
import '../../../app/splash_screen.dart';
import '../../../utils/page_specs.dart';

import '../models/home_model.dart';
import '../components/navbar.dart';

class HomePage extends BaseStatefulPageView {
  final HomeModel? model;

  // ignore: use_key_in_widget_constructors
  HomePage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    if (!model!.initialized) {
      await model!.initialize(context);
    }

    return true;
  }

  /// Called while waiting for the result of [beforeLoad]
  ///
  /// Returns the [Widget] to render on the page
  @override
  Widget buildLoading(BuildContext context) => build(context);

  @override
  Widget build(BuildContext context, {bool loading = false}) {
    if (!model!.initialized) {
      return const SplashScreen();
    }

    var module = App.getChild(context, model!);
    module ??= App.getChild(context, model!, '/');

    PageSpecs? baseSpecs = module?.page?.specs as PageSpecs?;
    var specs = baseSpecs ?? PageSpecs();
    if (baseSpecs?.builder != null) {
      specs = baseSpecs?.builder!(
            context,
            dispatch: model!.dispatch,
            read: model!.read,
          ) ??
          PageSpecs();
    }

    if (model!.title != null) {
      specs.title = model!.title;
    }

    return SafeArea(
      child: Scaffold(
        appBar: specs.hasAppBar! && !model!.isFullScreen
            ? AppBar(
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Color.fromRGBO(4, 26, 82, 1),
                    size: 24,
                  ),
                  onPressed: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).maybePop();
                    } else {
                      Navigator.of(context).popAndPushNamed('/_/welcome');
                    }
                  },
                ),
                title: Text(specs.title!),
              )
            : PreferredSize(
                preferredSize: const Size(0.0, 0.0),
                child: Container(),
              ),
        body: Container(child: module),
        bottomNavigationBar: SizedBox(
          height: model!.isFullScreen ? 0 : 82,
          child: model!.isFullScreen
              ? Container(
                  width: MediaQuery.of(context).size.width,
                )
              : Navbar(
                  model: model,
                  routeName: App.getRouteName(context),
                ),
        ),
      ),
    );
  }
}
