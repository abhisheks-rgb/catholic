import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:intl/intl.dart';

import '../models/church_bulletin_model.dart';

class ChurchBulletinPage extends BaseStatefulPageView {
  final ChurchBulletinModel? model;

  ChurchBulletinPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    model!.loadData();

    return true;
  }

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      _BulletinPage(model!);
}

class _BulletinPage extends StatefulWidget {
  final ChurchBulletinModel model;

  const _BulletinPage(this.model);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _BulletinPageState(model);
}

class _BulletinPageState extends State<_BulletinPage> {
  final ChurchBulletinModel model;
  String? _selectedParishValue = "";
  List? _bulletinItems;
  final PdfViewerController pdfViewerController = PdfViewerController();
  var controllers = <String, PdfViewerController>{};
  Timer? myTimer;

  _BulletinPageState(this.model);

  @override
  void initState() {
    super.initState();

    _selectedParishValue = 'Cathedral of the Good Shepherd';


    if (widget.model.churchName == null || widget.model.churchName == '') {
      _getBulletin('cathedral');
    } else {
      startTimer();
    }
  }

  void startTimer() async {
    int x = 0;

    await Future.delayed(const Duration(seconds: 3), () async {
      myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (widget.model.churchName != null || widget.model.churchName != '') {
          if (widget.model.items!.isNotEmpty) {
            x += 1;

            var parish =
              widget.model.items?.firstWhere((element) {
                return element['name'] == widget.model.churchName;
              });

            _getBulletin(parish['link']);
            
            setState(() {
              _selectedParishValue = widget.model.churchName;
            });
          }
        } else {
          x += 1;
        }

        if (x > 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    pdfViewerController.dispose(); // Dispose of the controller object
    super.dispose();
    myTimer?.cancel();
    delayedResetChurchName();
  }

  void delayedResetChurchName() async {
    await widget.model.setChurchName(churchName: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Church Bulletin'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 245, 1),
        ),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: widget.model.loading && widget.model.items!.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 64,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(208, 185, 133, 0.15),
                          offset: Offset(0, 8),
                          blurRadius: 16,
                        ),
                        BoxShadow(
                          color: Color.fromRGBO(208, 185, 133, 0.05),
                          offset: Offset(0, 4),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        InputDecorator(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.zero))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              isDense: true,
                              isExpanded: true,
                              value: _selectedParishValue,
                              hint: const Text('Select parish'),
                              items: [
                                ...?widget.model.items?.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['name'].toString(),
                                    child: Text(value['name'],
                                        style: const TextStyle(fontSize: 16)),
                                  );
                                }).toList()
                              ],
                              onChanged: (value) async {
                                var parish =
                                    widget.model.items?.firstWhere((element) {
                                  return element['name'] == value;
                                });

                                _getBulletin(parish['link']);
                                setState(() {
                                  _selectedParishValue = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _bulletinItems?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 16);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(208, 185, 133, 0.15),
                                offset: Offset(0, 8),
                                blurRadius: 16,
                              ),
                              BoxShadow(
                                color: Color.fromRGBO(208, 185, 133, 0.05),
                                offset: Offset(0, 4),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(20),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: 60,
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _selectedParishValue!,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromRGBO(4, 26, 82, 1),
                                            ),
                                          ),
                                        ]),
                                    Text(
                                      DateFormat('E, d MMM yyyy').format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                              _bulletinItems![index]['created'],
                                              isUtc: true)),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color.fromRGBO(4, 26, 82, 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 449,
                                // height: 50,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(204, 204, 204, 1),
                                ),
                                child: SfPdfViewer.network(
                                  _bulletinItems![index]['filelink'],
                                  controller:
                                      controllers[_bulletinItems![index]['id']],
                                  canShowPaginationDialog: false,
                                  canShowScrollHead: false,
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 48,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(0),
                                          child: GestureDetector(
                                            child: const Icon(
                                              Icons.arrow_back_ios,
                                              color: Colors.black,
                                            ),
                                            onTap: () {
                                              controllers[_bulletinItems![index]
                                                      ['id']]
                                                  ?.previousPage();
                                            },
                                          ),
                                        ),
                                        // ignore: avoid_unnecessary_containers
                                        Container(
                                          child: Text(
                                            'Page 1 / ${controllers[_bulletinItems![index]['id']]?.pageCount}',
                                          ),
                                        ),
                                        Container(
                                          width: 48,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(0),
                                          child: GestureDetector(
                                            child: const Icon(
                                              Icons.arrow_forward_ios,
                                              color: Colors.black,
                                            ),
                                            onTap: () {
                                              controllers[_bulletinItems![index]
                                                      ['id']]
                                                  ?.nextPage();
                                            },
                                          ),
                                        ),
                                      ],
                                    )),
                                    SizedBox(
                                      width: 32,
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            alignment: Alignment.center,
                                            child: const Icon(
                                              MaterialIcons.fullscreen,
                                              color: Colors.black,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }

  void _getBulletin(String parishlink) async {
    setState(() {
      // pdfViewerController.dispose();
      controllers = {};
    });
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('bulletin')
        .call(
      {
        "input": parishlink,
      },
    );

    final response = result.data;

    List bulletinList = response['results']['items'] ?? [];
    bulletinList.map((item) {
      controllers[item['id']] = PdfViewerController();
    }).toList();

    setState(() {
      _bulletinItems = response['results']['items'] ?? [];
    });
  }
}
