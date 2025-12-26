import 'package:butter/butter.dart';
import 'package:flutter/widgets.dart';

class PageSpecs extends BasePageSpecs {
  bool? centerTitle;
  bool? inSafeArea;
  bool? hasAppBar;
  bool? showProfile;
  bool? showNotification;
  bool? showFontSetting;
  bool? showInfo;
  bool? leadingLogo;
  String? title;
  String? shortTitle;
  Widget? leading;
  List<Widget>? actions;

  PageSpecs Function(
    BuildContext context, {
    Future<void> Function(BaseAction action)? dispatch,
    T? Function<T extends BaseUIModel>(T m)? read,
  })?
  builder;

  PageSpecs({
    this.centerTitle = true,
    this.inSafeArea = true,
    this.hasAppBar = true,
    this.showProfile = false,
    this.showNotification = false,
    this.showFontSetting = false,
    this.showInfo = false,
    this.leadingLogo = false,
    this.shortTitle,
    this.title,
    this.leading,
    this.actions,
  });

  PageSpecs.build(this.builder);

  PageSpecs copyWith({
    bool? centerTitle,
    bool? inSafeArea,
    bool? hasAppBar,
    bool? showProfile,
    bool? showNotification,
    bool? showFontSetting,
    bool? showInfo,
    bool? leadingLogo,
    String? title,
    String? shortTitle,
    Widget? leading,
    List<Widget>? actions,
  }) {
    return PageSpecs(
      centerTitle: centerTitle ?? this.centerTitle,
      inSafeArea: inSafeArea ?? this.inSafeArea,
      hasAppBar: hasAppBar ?? this.hasAppBar,
      showProfile: showProfile ?? this.showProfile,
      showNotification: showNotification ?? this.showNotification,
      showFontSetting: showFontSetting ?? this.showFontSetting,
      showInfo: showInfo ?? this.showInfo,
      leadingLogo: leadingLogo ?? this.leadingLogo,
      title: title ?? this.title,
      shortTitle: shortTitle ?? this.shortTitle,
      leading: leading ?? this.leading,
      actions: actions ?? this.actions,
    );
  }
}
