import 'package:butter/butter.dart';
// import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/scripture_model.dart';

import '../../../utils/asset_path.dart';

class ScriptureView extends BaseStatefulPageView {
  final ScriptureModel? model;
  final List<Map> _items;

  ScriptureView(this.model, {Key? key})
      : _items = List.generate(model?.items?.length ?? 0, (index) {
          final item = model?.items![index] as Map;

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
              item['authorname'] = 'Rev Msgr ${item['authorname']}';
              item['shortname'] = 'stephen_yim';
              break;
            default:
          }

          return item;
        })
          ..sort((a, b) => a['order'].compareTo(b['order'])),
        super();

  // Future<String?> getImage(String name) async {
  //   try {
  //     final instance = await FirebaseFunctions.instanceFor(region: 'asia-east2')
  //         .httpsCallable('priest')
  //         .call(
  //       {
  //         'type': 'name',
  //         'arg': name,
  //       },
  //     );
  //
  //     String? result = instance.data['results']['items']['photo'];
  //     return Future.value(result);
  //   } catch (e, stacktrace) {
  //     Butter.e(e.toString());
  //     Butter.e(stacktrace.toString());
  //   }
  //
  //   return null;
  // }

  @override
  State<BaseStatefulPageView> createState() => _ScriptureViewState();
}

class _ScriptureViewState extends State<ScriptureView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            widget._items.isEmpty && widget.model?.loading == false
                ? Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.77,
                    margin:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Could not retrieve Scripture Reflections at this time.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Container(
                    height: 226,
                    decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x192c0807),
                          offset: Offset(0, 8),
                          blurRadius: 32,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Align(
                            child: SizedBox(
                              height: 226,
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                assetPath('pray_banner.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Align(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 226,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: const Alignment(0.957, -1.211),
                                    end: const Alignment(0.515, 1),
                                    colors: <Color>[
                                      const Color(0x51ffffff).withOpacity(0.2),
                                      const Color(0xffffffff).withOpacity(0.9)
                                    ],
                                    stops: const <double>[0, 1],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Align(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: 226,
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(1, -1),
                                    end: Alignment(-1, 1),
                                    colors: <Color>[
                                      Color.fromRGBO(24, 77, 212, 0.3),
                                      Color.fromRGBO(255, 255, 255, 0.3)
                                    ],
                                    stops: <double>[0, 1],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 79,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            width: MediaQuery.of(context).size.width - 48,
                            height: 102,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  widget.model?.isToday?['title'] ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            width: MediaQuery.of(context).size.width - 48,
                            height: 38,
                            child: Text(
                              widget.model?.isToday?['content'] ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff041a51),
                                  letterSpacing: 0.1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            const SizedBox(height: 8),
            widget.model?.loading == true
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.only(top: 20),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: widget._items.map<Widget>((element) {
                      final data = element['data'] as List;

                      return Column(
                        children: [
                          const SizedBox(height: 8),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 5.5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(235, 235, 235, 1),
                                  blurRadius: 15,
                                  offset: Offset(0.0, 0.75),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: element['shortname'] == 'arch' ?
                                            Image.asset('assets/cardinal-medium.jpg',
                                              width: 40, height: 40) :
                                            element['shortname'] == 'stephen_yim' ?
                                            Image.asset('assets/stephen-yim-medium.jpg',
                                                width: 40, height: 40) :
                                            Image.asset('assets/priest-placeholder-img.png',
                                              width: 40, height: 40),
                                        ),
                                      ),
                                      Text(
                                        '${element['authorname']} (${data.length})',
                                        style: const TextStyle(
                                          color: Color.fromRGBO(4, 26, 82, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromRGBO(4, 26, 82, 0.1),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () async {
                                          await widget.model?.viewHistory?.call(
                                              element['authorname'],
                                              element['shortname'],
                                              element['data']);
                                          await FirebaseAnalytics.instance
                                              .logEvent(
                                            name:
                                                'app_reflect_view_all_${element['shortname']}',
                                          );
                                        },
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14.5),
                                              child: const Text(
                                                'View All',
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      12, 72, 224, 1),
                                                  fontSize: 16,
                                                  height: 1.2,
                                                ),
                                              )),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () async {
                                          await widget
                                              .model?.viewScriptureDetails
                                              ?.call(element['data'][0]);
                                          await FirebaseAnalytics.instance
                                              .logEvent(
                                            name:
                                                'app_reflect_${element['shortname']}',
                                          );
                                        },
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14.5),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: const [
                                                Spacer(),
                                                Text(
                                                  'Read Latest',
                                                  style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        12, 72, 224, 1),
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
