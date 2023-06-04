import 'dart:async';

import 'package:butter/butter.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../../scripture/models/scripture_history_model.dart';

class ListReflectionAction extends BaseAction {
  final String? quantity;

  ListReflectionAction({
    this.quantity,
  });

  // Make sure to strictly follow the guidelines found here:
  // https://pub.dev/packages/async_redux/#async-reducer
  @override
  Future<AppState?> reduce() async {
    String? error;

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.error = error;
    });

    List<Object> records = [];
    String authorname = '';

    try {
      final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
          .httpsCallable('reflection')
          .call(
        {
          'type': quantity ?? 'all',
        },
      );

      var result = instance.data['results']['items'];

      List<Map> items;

      items = List.generate(result.length ?? 0, (index) {
        final item = result[index] as Map;

        switch (item['authorname']) {
          case 'William SC Goh':
            item['order'] = 0;
            item['authorname'] = 'Cardinal ${item['authorname']}';
            item['shortname'] = 'arch';
            break;
          case 'Adrian Danker':
            item['order'] = 1;
            item['authorname'] = 'Rev Fr ${item['authorname']}';
            item['shortname'] = 'adrian_danker';
            break;
          case 'Luke Fong':
            item['order'] = 2;
            item['authorname'] = 'Rev Fr ${item['authorname']}';
            item['shortname'] = 'luke_fong';
            break;
          case 'Stephen Yim':
            item['order'] = 3;
            item['authorname'] = 'Rev Fr ${item['authorname']}';
            item['shortname'] = 'stephen_yim';
            break;
          default:
        }

        return item;
      })
        ..sort((a, b) => a['order'].compareTo(b['order']));

      records = items[0]['data'].map<Object>((e) {
        return e as Object;
      }).toList();

      authorname = items[0]['authorname'];
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
      error = 'Unexpected error';
    }

    await dispatchModel<ScriptureHistoryModel>(ScriptureHistoryModel(), (m) {
      m.error = error;
      m.items = records;
      m.authorName = authorname;
    });

    pushNamed('/_/scripture/history');

    return null;
  }
}
