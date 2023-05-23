import 'package:butter/butter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../actions/list_church_info_action.dart';
import '../actions/list_priests_action.dart';
import '../actions/set_church_id_action.dart';
import '../models/church_info_model.dart';
import '../../church_bulletin/models/church_bulletin_model.dart';
import '../../offertory/models/offertory_model.dart';
import '../../schedules/models/schedules_model.dart';
import '../../priest_info/models/priest_info_model.dart';

class ChurchInfoState extends BasePageState<ChurchInfoModel> {
  ChurchInfoState();

  ChurchInfoModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  ChurchInfoState.build(this.model, void Function(ChurchInfoModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ChurchInfoState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  ChurchInfoState fromStore() => ChurchInfoState.build(
          read<ChurchInfoModel>(
            ChurchInfoModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.showPage = (route, name, link, churchId) async {
          switch (route) {
            case '/_/church_bulletin':
              dispatchModel<ChurchBulletinModel>(ChurchBulletinModel(), (m) {
                m.churchName = name;
                m.churchLink = link;
              });
              break;
            case '/_/schedules':
              dispatchModel<SchedulesModel>(SchedulesModel(), (m) {
                m.churchName = name;
              });
              break;
            case '/_/offertory':
              dispatchModel<OffertoryModel>(OffertoryModel(), (m) {
                m.churchId = churchId;
                m.churchName = name;
              });
              break;
            case '/_/priest_info':
              dispatchModel<PriestInfoModel>(PriestInfoModel(), (m) {
                m.priestName = name;
              });
              break;
            default:
          }

          pushNamed(route);
        };
        m.loadData = () async {
          dispatchModel<ChurchInfoModel>(ChurchInfoModel(), (m) {
            m.loading = true;
          });
          await Future.delayed(const Duration(seconds: 1), () async {
            final String response =
                await rootBundle.loadString('assets/data/parish.json');
            final data = await json.decode(response);

            dispatchModel<ChurchInfoModel>(ChurchInfoModel(), (m) {
              m.items = data['parishes'];
              m.loading = false;
            });
          });
        };
        m.fetchChurchInfo = ({orgId}) async {
          await dispatchAction(ListChurchInfoAction(orgId: orgId));
          final model = read<ChurchInfoModel>(ChurchInfoModel());
          if (model.error != null) {
            throw model.error!;
          }
          return model.churchInfos;
        };
        m.fetchPriestList = ({orgId}) async {
          await dispatchAction(ListPriestsAction(orgId: orgId));
          final model = read<ChurchInfoModel>(ChurchInfoModel());
          if (model.error != null) {
            throw model.error!;
          }
          return model.priests;
        };
        m.setChurchId = ({churchId}) async {
          await dispatchAction(SetChurchIdAction(churchId: churchId));
          final model = read<ChurchInfoModel>(ChurchInfoModel());
          if (model.error != null) {
            throw model.error!;
          }
          return model.churchId;
        };
      });
}
