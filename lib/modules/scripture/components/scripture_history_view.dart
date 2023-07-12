import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/scripture_history_model.dart';
import '../../../utils/asset_path.dart';

class ScriptureHistoryView extends BaseStatelessPageView {
  final ScriptureHistoryModel? model;
  final List<Map> _items;

  ScriptureHistoryView(this.model, {Key? key})
      : _items = List.generate(
            model?.items?.length ?? 0, (index) => model?.items![index] as Map),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: model?.loading == true
          ? Container(
              height: MediaQuery.of(context).size.height * 0.74,
              margin: const EdgeInsets.only(top: 16),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        height: 85,
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
                        height: 85,
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
                        height: 85,
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
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 252, 245, 0),
                          Color.fromRGBO(255, 252, 245, 1),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child:
                                    Image.asset('assets/cardinal-medium.jpg'),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(model?.authorName ?? '---',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    )),
                                const SizedBox(height: 4),
                                Text('Reflection & Homilies - ${_items.length}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 0.5),
                                      fontSize: 14,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: _items.map<Widget>((element) {
                            final published =
                                DateFormat('E, d MMM yyyy').format(
                              DateTime.parse(
                                element['published'],
                              ),
                            );
                            return Column(
                              children: [
                                RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () async {
                                    await model?.viewScriptureDetails
                                        ?.call(element);

                                    await FirebaseAnalytics.instance.logEvent(
                                      name: 'app_reflect_${model?.shortName}',
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                235, 235, 235, 1),
                                            blurRadius: 15,
                                            offset: Offset(0.0, 0.75),
                                          ),
                                        ],
                                        color: Color.fromRGBO(255, 255, 255, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${element['contentTitle']}',
                                          style: const TextStyle(
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          'English',
                                          style: TextStyle(
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Posted • $published',
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(4, 26, 82, 0.7),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
