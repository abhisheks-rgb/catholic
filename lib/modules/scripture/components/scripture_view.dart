import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

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
              item['authorname'] = 'Cardinal William SC Goh';
              break;
            case 'Adrian Danker':
              item['order'] = 1;
              item['authorname'] = 'Rev Fr Adrian Danker';
              break;
            case 'Luke Fong':
              item['order'] = 2;
              item['authorname'] = 'Rev Fr Luke Fong';
              break;
            case 'Stephen Yim':
              item['order'] = 3;
              item['authorname'] = 'Rev Fr Stephen Yim';
              break;
            default:
          }

          return item;
        })
          ..sort((a, b) => a['order'].compareTo(b['order'])),
        super();

  @override
  State<BaseStatefulPageView> createState() => _ScriptureViewState();
}

class _ScriptureViewState extends State<ScriptureView> {
  Map? _istoday;

  @override
  void initState() {
    super.initState();

    _getisToday();
  }

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
                          // welcomeoscarHYf (127:100)
                          left: 0,
                          bottom: 79,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 20),
                            width: MediaQuery.of(context).size.width - 48,
                            height: 38,
                            child: SizedBox(
                              height: 34,
                              child: Text(
                                _istoday?['title'] ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(4, 26, 82, 1),
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
                              height: 48,
                              child: Text(
                                _istoday?['content'] ?? '',
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
            const SizedBox(height: 8),
            widget.model?.loading == true
                ? Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
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
                            padding: const EdgeInsets.all(20),
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
                                Text(
                                  'Reflections & Homilies (${data.length})',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'by ${element['authorname']}',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(4, 26, 82, 0.5),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromRGBO(4, 26, 82, 0.1),
                                ),
                                const SizedBox(height: 8),
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
                                              element['data']);
                                        },
                                        child: const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'View All',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  12, 72, 224, 1),
                                              fontSize: 16,
                                            ),
                                          ),
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
                                        },
                                        child: Align(
                                          alignment: Alignment.topLeft,
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

  void _getisToday() async {
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('todayis')
        .call({});

    final response = result.data;

    List itemList = response['results']['items'];

    setState(() {
      _istoday = itemList[0];
    });
  }
}
