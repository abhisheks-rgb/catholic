import 'package:butter/butter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../actions/list_priest_info_action.dart';
import '../models/priest_info_model.dart';

class PriestInfoState extends BasePageState<PriestInfoModel> {
  PriestInfoState();

  PriestInfoModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  PriestInfoState.build(this.model, void Function(PriestInfoModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is PriestInfoState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  PriestInfoState fromStore() => PriestInfoState.build(
          read<PriestInfoModel>(
            PriestInfoModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.loadData = () async {
          dispatchModel<PriestInfoModel>(PriestInfoModel(), (m) {
            m.loading = true;
          });
          await Future.delayed(const Duration(seconds: 1), () async {
            final String response =
                await rootBundle.loadString('assets/data/parish.json');
            final data = await json.decode(response);

            dispatchModel<PriestInfoModel>(PriestInfoModel(), (m) {
              m.items = data['parishes'];
              m.loading = false;
            });
          });
        };
        m.fetchPriests = ({name}) async {
          await dispatchAction(ListPriestInfoAction(name: name));
          final model = read<PriestInfoModel>(PriestInfoModel());
          if (model.error != null) {
            throw model.error!;
          }
          return model.priests;
        };
        m.setPriestName = ({priestName}) async {
          return dispatchModel<PriestInfoModel>(PriestInfoModel(), (m) {
            m.priestName = priestName;
          });
        };
      });
}
