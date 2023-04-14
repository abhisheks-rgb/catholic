import 'package:butter/butter.dart';
import 'package:flutter/widgets.dart';

class PageSpecs extends BasePageSpecs {
  bool? centerTitle;
  bool? inSafeArea;
  bool? hasAppBar;
  bool? showProfile;
  bool? leadingLogo;
  String? title;
  String? shortTitle;
  Widget? leading;
  List<Widget>? actions;

  PageSpecs Function(
    BuildContext context, {
    Future<void> Function(BaseAction action)? dispatch,
    T? Function<T extends BaseUIModel>(T m)? read,
  })? builder;

  PageSpecs({
    this.centerTitle = true,
    this.inSafeArea = true,
    this.hasAppBar = true,
    this.showProfile = false,
    this.leadingLogo = false,
    this.shortTitle,
    this.title,
    this.leading,
    this.actions,
  });

  PageSpecs.build(this.builder);
}
