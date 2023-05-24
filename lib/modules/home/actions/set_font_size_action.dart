import 'dart:async';

import 'package:butter/butter.dart';

import '../../mass_readings/models/mass_readings_model.dart';
import '../../scripture/models/scripture_details_model.dart';
import '../../devotion/rosary/models/rosary_model.dart';

class SetFontSizeAction extends BaseAction {
  SetFontSizeAction();

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    Butter.d('SetFontSizeAction::reduce');

    final m = read<MassReadingsModel>(MassReadingsModel());

    double defaultTitleFontSize = 20.0;
    double defaultContentFontSize = 17;
    double titlefontsize;
    double contentfontsize;

    if (m.titleFontSize == defaultTitleFontSize) {
      titlefontsize = defaultTitleFontSize * 1.2;
      contentfontsize = defaultContentFontSize * 1.2;
    } else if (m.titleFontSize == defaultTitleFontSize * 1.2) {
      titlefontsize = defaultTitleFontSize * 1.4;
      contentfontsize = defaultContentFontSize * 1.4;
    } else if (m.titleFontSize == defaultTitleFontSize * 1.4) {
      titlefontsize = defaultTitleFontSize * 1.6;
      contentfontsize = defaultContentFontSize * 1.6;
    } else {
      titlefontsize = defaultTitleFontSize;
      contentfontsize = defaultContentFontSize;
    }

    dispatchModel<MassReadingsModel>(MassReadingsModel(), (m) {
      m.titleFontSize = titlefontsize;
      m.contentFontSize = contentfontsize;
    });

    dispatchModel<ScriptureDetailsModel>(ScriptureDetailsModel(), (m) {
      m.titleFontSize = titlefontsize;
      m.contentFontSize = contentfontsize;
    });

    dispatchModel<RosaryModel>(RosaryModel(), (m) {
      m.titleFontSize = titlefontsize;
      m.contentFontSize = contentfontsize;
    });
    return null;
  }
}
