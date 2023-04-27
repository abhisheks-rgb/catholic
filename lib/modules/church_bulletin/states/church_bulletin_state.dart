import 'package:butter/butter.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../models/church_bulletin_model.dart';
import '../../home/models/home_model.dart';

class ChurchBulletinState extends BasePageState<ChurchBulletinModel> {
  ChurchBulletinState();

  ChurchBulletinModel? model;

  // This constructor form is not properly enforced. Which means, if you do not
  // follow this, no errors will be produced in butter. However, this allows you to
  // properly fillup your models with valid function handlers after being read
  // from the store and before it is being fed to the page.
  ChurchBulletinState.build(this.model, void Function(ChurchBulletinModel m) f)
      : super.build(model!, f);

  // Make sure to properly define this function. Otherwise, your reducers
  // will not trigger view updates... and you will end up pulling all your hair.
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ChurchBulletinState &&
            runtimeType == other.runtimeType &&
            model == other.model;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        model,
      ]);

  @override
  ChurchBulletinState fromStore() => ChurchBulletinState.build(
          read<ChurchBulletinModel>(
            ChurchBulletinModel(
                // Initialize your models here in case it is not available in the store yet
                ),
          ), (m) {
        // Load all your model's handlers here
        m.loadData = () async {
          dispatchModel<ChurchBulletinModel>(ChurchBulletinModel(), (m) {
            m.loading = true;
          });
          await Future.delayed(const Duration(milliseconds: 30), () async {
            final String response =
                await rootBundle.loadString('assets/data/parish.json');
            final data = await json.decode(response);

            dispatchModel<ChurchBulletinModel>(ChurchBulletinModel(), (m) {
              m.items = data['parishes'];
              m.loading = false;
            });
          });
        };
        m.setChurchName = ({churchName}) async {
          return dispatchModel<ChurchBulletinModel>(ChurchBulletinModel(), (m) {
            m.churchName = churchName;
            m.churchLink = null;
          });
        };
        m.setIsFullScreen = ({isFullScreen}) async {
          return dispatchModel<HomeModel>(HomeModel(), (m) {
            m.isFullScreen = isFullScreen!;
          });
        };
      });
}
