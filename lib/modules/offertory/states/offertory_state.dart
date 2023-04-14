import 'dart:convert';
import 'package:butter/butter.dart';
import 'package:flutter/services.dart';

import '../actions/list_offertory_action.dart';
import '../actions/navigate_to_action.dart';
import '../models/offertory_model.dart';

class OffertoryState extends BasePageState<OffertoryModel> {
  OffertoryState();

  OffertoryModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  OffertoryState.build(this.model, void Function(OffertoryModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is OffertoryState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  OffertoryState fromStore() => OffertoryState.build(
          read<OffertoryModel>(
            OffertoryModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.loadData = () async {
          dispatchModel<OffertoryModel>(OffertoryModel(), (m) {
            m.loading = true;
          });
          await Future.delayed(const Duration(seconds: 1), () async {
            final String response =
                await rootBundle.loadString('assets/data/parish.json');
            final data = await json.decode(response);

            dispatchModel<OffertoryModel>(OffertoryModel(), (m) {
              m.items = data['parishes'];
              m.loading = false;
            });
          });
        };
        m.fetchOffertory = ({charityId}) async {
          await dispatchAction(ListOffertoryAction(charityId: charityId));
          final model = read<OffertoryModel>(OffertoryModel());
          if (model.error != null) {
            throw model.error!;
          }
          return model.offertories;
        };
        m.navigateTo = (churchId, route, churchName) => dispatchAction(
            NavigateToAction(
                churchId: churchId, route: route, churchName: churchName));
        m.setChurchName = ({churchName}) async {
          return dispatchModel<OffertoryModel>(OffertoryModel(), (m) {
            m.churchName = churchName;
          });
        };
      });
}
