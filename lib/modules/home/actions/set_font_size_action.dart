import 'dart:async';

import 'package:butter/butter.dart';
import 'package:trcas_catholic/modules/home/models/home_model.dart';

import '../../mass_readings/models/mass_readings_model.dart';
import '../../scripture/models/scripture_details_model.dart';
import '../../confession/models/confession_model.dart';
import '../../devotion/divine_mercy_prayer/models/divine_mercy_prayer_model.dart';
import '../../devotion/rosary/models/rosary_model.dart';
import '../../shared/font_size_manager.dart';

class SetFontSizeAction extends BaseAction {
  SetFontSizeAction();

  @override
  Future<AppState?> reduce() async {
    Butter.d('SetFontSizeAction::reduce');

    try {
      FontSizeManager.cycleToNextSize();

      final titlefontsize = FontSizeManager.currentTitleSize;
      final contentfontsize = FontSizeManager.currentContentSize;

      dispatchModel<HomeModel>(HomeModel(), (m) {
        m.titleFontSize = titlefontsize;
        m.contentFontSize = contentfontsize;
      });

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

      dispatchModel<ConfessionModel>(ConfessionModel(), (m) {
        m.titleFontSize = titlefontsize;
        m.contentFontSize = contentfontsize;
      });

      dispatchModel<DivineMercyPrayerModel>(DivineMercyPrayerModel(), (m) {
        m.titleFontSize = titlefontsize;
        m.contentFontSize = contentfontsize;
      });

    } catch (e, stackTrace) {
      print('========== SetFontSizeAction ERROR ==========');
      print('Error: $e');
      print('Stack trace:');
      print(stackTrace);
      print('========== ERROR END ==========');
      rethrow;
    }

    return null;
  }
}