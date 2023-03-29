import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/info_model.dart';

import '../../../utils/asset_path.dart';

class InfoPage extends BaseStatefulPageView {
  final InfoModel? model;

  InfoPage({Key? key, this.model}) : super();

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      _InfoPage(model!);
}

class _InfoPage extends StatefulWidget {
  final InfoModel model;

  const _InfoPage(this.model);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _InfoPageState(model);
}

class _InfoPageState extends State<_InfoPage> {
  final InfoModel model;
  Map? _qoute;

  _InfoPageState(this.model);

  @override
  void initState() {
    super.initState();

    _getQoute();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> exploreItems = <dynamic>[
      {
        'title': 'Mass Schedules',
        'icon': 'Mass_Schedules.png',
        'route': 'schedules'
      },
      {
        'title': 'Church Bulletin',
        'icon': 'Church_Bulletin.png',
        'route': 'church_bulletin',
      },
      {
        'title': 'Church Info',
        'icon': 'Church_Info.png',
        'route': 'church_info',
      },
      {
        'title': 'Priest Info',
        'icon': 'Church_Info.png',
        'route': 'priest_info',
      },
      {
        'title': 'Offertory & Giving',
        'icon': 'Offertory_Giving.png',
        'route': 'offertory'
      },
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Info',
          style: TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(4, 26, 82, 1),
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(4, 26, 82, 1),
            size: 24,
          ),
          onTap: () {
            Navigator.of(context).popAndPushNamed('/_/welcome');
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 252, 245, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                          child: Image.asset(
                            assetPath('info_banner.png'),
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
                          width: 391,
                          height: 226,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(0.957, -1.211),
                                end: const Alignment(0.515, 1),
                                colors: <Color>[
                                  const Color(0x51ffffff),
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
                          width: 391,
                          height: 226,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1, -1),
                                end: Alignment(-1, 1),
                                colors: <Color>[
                                  Color.fromRGBO(24, 77, 212, 0.5),
                                  Color.fromRGBO(255, 255, 255, 0)
                                ],
                                stops: <double>[0, 1],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // welcomeoscarHYf (127:100)
                      left: 24,
                      top: 71,
                      child: Align(
                        child: SizedBox(
                          height: 34,
                          child: Text(
                            _qoute?['title'] ?? "",
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff041a51),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 24,
                      top: 124,
                      child: Align(
                        child: SizedBox(
                          width: 287,
                          height: 48,
                          child: Text(
                            _qoute?['content'] ?? "",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff041a51),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: MasonryGridView.count(
                itemCount: exploreItems.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                crossAxisCount: 1,
                mainAxisSpacing: 10,
                itemBuilder: (_, int index) {
                  return InkWell(
                    onTap: () {
                      model.showPage('/_/${exploreItems[index]['route']}');
                    },
                    child: Container(
                        height: 88,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x142c0807),
                              offset: Offset(0, 8),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              width: 42,
                              height: 56,
                              child: Image.asset(
                                assetPath(
                                    'menu_item/${exploreItems[index]['icon']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              exploreItems[index]['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff041a51),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }

  void _getQoute() async {
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable("quote")
        .call({});

    final response = result.data;

    List itemList = response['results']['items'];

    var infoQoute = itemList.firstWhere((element) {
      return element['type'] == 'info';
    });

    setState(() {
      _qoute = infoQoute;
    });
  }
}
