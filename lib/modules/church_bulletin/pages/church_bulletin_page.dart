import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:intl/intl.dart';

import '../models/church_bulletin_model.dart';
import '../../../../utils/page_specs.dart';

class ChurchBulletinPage extends BaseStatefulPageView {
  final ChurchBulletinModel? model;

  ChurchBulletinPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    model!.loadData();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Church Bulletin',
      ));

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
  String? _selectedParishValue = '';
  List? _bulletinItems;
  final PdfViewerController pdfViewerController = PdfViewerController();
  var controllers = <String, PdfViewerController>{};
  bool isFullScreen = false;
  int? fullScreenPdfIndex;
  int fullScreenPageNumber = 0;

  _BulletinPageState(this.model);

  @override
  void initState() {
    super.initState();

    _selectedParishValue = 'Cathedral of the Good Shepherd';

    if (widget.model.churchName == null) {
      _getBulletin('cathedral');
    } else {
      _selectedParishValue = widget.model.churchName;
      _getBulletin(widget.model.churchLink ?? '');
    }
  }

  @override
  void dispose() {
    pdfViewerController.dispose(); // Dispose of the controller object
    super.dispose();
    delayedReset();
  }

  void delayedReset() async {
    await widget.model.setChurchName(churchName: null);
    await widget.model.setIsFullScreen(isFullScreen: false);
  }

  @override
  Widget build(BuildContext context) {
    if (isFullScreen && _bulletinItems!.isNotEmpty) {
      return _renderFullScreen();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 245, 1),
        ),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
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
              _bulletinItems == null
                  ? _renderEmptyState()
                  : _bulletinItems!.isEmpty
                      ? _renderEmptyState()
                      : Flexible(
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
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
                                      color:
                                          Color.fromRGBO(208, 185, 133, 0.15),
                                      offset: Offset(0, 8),
                                      blurRadius: 16,
                                    ),
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(208, 185, 133, 0.05),
                                      offset: Offset(0, 4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 12),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: _bulletinItems![index]
                                                  ['description'] ==
                                              null
                                          ? 60
                                          : 77,
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            // _selectedParishValue!,
                                            _bulletinItems![index]['title'],
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  Color.fromRGBO(4, 26, 82, 1),
                                            ),
                                          ),
                                          _bulletinItems![index]
                                                      ['description'] ==
                                                  null
                                              ? Container()
                                              : Column(
                                                  children: [
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      _bulletinItems![index][
                                                                  'description']
                                                              .isNotEmpty
                                                          ? _bulletinItems![
                                                                      index][
                                                                  'description']
                                                              .isNotEmpty
                                                          : '',
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            4, 26, 82, 0.5),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Posted • ${DateFormat('E, d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(_bulletinItems![index]['created'], isUtc: true))}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.w400,
                                              color: Color.fromRGBO(
                                                  4, 26, 82, 0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    index > 1
                                        ? Container()
                                        : Container(
                                            height: 449,
                                            // height: 50,
                                            decoration: const BoxDecoration(
                                              color: Color.fromRGBO(
                                                  204, 204, 204, 1),
                                            ),
                                            child: SfPdfViewer.network(
                                              _bulletinItems![index]
                                                  ['filelink'],
                                              controller: controllers[
                                                  _bulletinItems![index]['id']],
                                              canShowPaginationDialog: false,
                                              canShowScrollHead: false,
                                            ),
                                          ),
                                    index > 1
                                        ? Container()
                                        : const SizedBox(height: 8),
                                    SizedBox(
                                      height: 48,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          index > 1
                                              ? const SizedBox()
                                              : Expanded(
                                                  child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RawMaterialButton(
                                                      constraints:
                                                          const BoxConstraints(),
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          const CircleBorder(),
                                                      onPressed: () {
                                                        controllers[
                                                                _bulletinItems![
                                                                        index]
                                                                    ['id']]
                                                            ?.previousPage();
                                                      },
                                                      child: Container(
                                                        width: 48,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: const Icon(
                                                          Icons.arrow_back_ios,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    // ignore: avoid_unnecessary_containers
                                                    // Container(
                                                    //   child: Text(
                                                    //     'Page 1 / ${controllers[_bulletinItems![index]['id']]?.pageCount}',
                                                    //   ),
                                                    // ),
                                                    RawMaterialButton(
                                                      constraints:
                                                          const BoxConstraints(),
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      shape:
                                                          const CircleBorder(),
                                                      onPressed: () {
                                                        controllers[
                                                                _bulletinItems![
                                                                        index]
                                                                    ['id']]
                                                            ?.nextPage();
                                                      },
                                                      child: Container(
                                                        width: 48,
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: const Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          index > 1
                                              ? RawMaterialButton(
                                                  constraints:
                                                      const BoxConstraints(),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  onPressed: () async {
                                                    if (!isFullScreen) {
                                                      setState(() {
                                                        fullScreenPdfIndex =
                                                            index;
                                                        isFullScreen = true;
                                                      });

                                                      await widget.model
                                                          .setIsFullScreen(
                                                              isFullScreen:
                                                                  true);
                                                    }
                                                  },
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 8,
                                                        horizontal: 0),
                                                    child: const Text(
                                                      'View Bulletin',
                                                      style: TextStyle(
                                                        color: Color.fromRGBO(
                                                            12, 72, 224, 1),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : RawMaterialButton(
                                                  constraints:
                                                      const BoxConstraints(),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  onPressed: () async {
                                                    if (!isFullScreen) {
                                                      setState(() {
                                                        fullScreenPdfIndex =
                                                            index;
                                                        isFullScreen = true;
                                                      });

                                                      await widget.model
                                                          .setIsFullScreen(
                                                              isFullScreen:
                                                                  true);
                                                    }
                                                  },
                                                  child: SizedBox(
                                                    width: 48,
                                                    height: 48,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          width: 48,
                                                          height: 48,
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Icon(
                                                            MaterialIcons
                                                                .fullscreen,
                                                            color: Colors.black,
                                                            size: 32,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
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
      ),
    );
  }

  Widget _renderEmptyState() => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.64,
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'Sorry, this church doesn\'t have any bulletins posted.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(4, 26, 82, 0.5),
              fontSize: 20,
            ),
          ),
        ),
      );

  void _getBulletin(String parishlink) async {
    setState(() {
      // pdfViewerController.dispose();
      controllers = {};
    });
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('bulletin')
        .call(
      {
        'input': parishlink,
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

    await FirebaseAnalytics.instance.logEvent(
      name: 'app_bulletin_$parishlink',
    );
  }

  Widget _renderFullScreen() {
    // for (var e in _bulletinItems![fullScreenPdfIndex!].keys) {
    //   Butter.d('$e: ${_bulletinItems![fullScreenPdfIndex!][e]}');
    // }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.18,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.67,
                padding: const EdgeInsets.all(0),
                child: SfPdfViewer.network(
                  _bulletinItems![fullScreenPdfIndex!]['filelink'],
                  controller: pdfViewerController,
                  canShowPaginationDialog: false,
                  canShowScrollHead: false,
                  onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    setState(() {
                      fullScreenPageNumber = pdfViewerController.pageNumber;
                    });
                  },
                  onPageChanged: (PdfPageChangedDetails details) {
                    setState(() {
                      fullScreenPageNumber = details.newPageNumber;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0,
                    0.1,
                    1,
                  ],
                  colors: [
                    Colors.black,
                    Colors.black87,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () async {
                          if (isFullScreen) {
                            setState(() {
                              fullScreenPdfIndex = null;
                              isFullScreen = false;
                              fullScreenPageNumber = 0;
                            });

                            await widget.model
                                .setIsFullScreen(isFullScreen: false);
                          }
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _bulletinItems![fullScreenPdfIndex!]['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _bulletinItems![fullScreenPdfIndex!]['description'] == null
                      ? Container()
                      : Text(
                          _bulletinItems![fullScreenPdfIndex!]['description']
                                  .isNotEmpty
                              ? _bulletinItems![fullScreenPdfIndex!]
                                  ['description']
                              : '',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    'Posted • ${DateFormat('E, d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(_bulletinItems![fullScreenPdfIndex!]['created'], isUtc: true))}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.18,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                      0,
                      0.9,
                      1,
                    ],
                    colors: [
                      Colors.transparent,
                      Colors.black87,
                      Colors.black,
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: [
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: const CircleBorder(),
                            onPressed: () {
                              pdfViewerController.previousPage();
                              setState(() {
                                fullScreenPageNumber =
                                    pdfViewerController.pageNumber;
                              });
                            },
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: Row(
                                children: const [
                                  SizedBox(width: 12.5),
                                  Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Page $fullScreenPageNumber / ${pdfViewerController.pageCount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            shape: const CircleBorder(),
                            onPressed: () {
                              pdfViewerController.nextPage();
                              setState(() {
                                fullScreenPageNumber =
                                    pdfViewerController.pageNumber;
                              });
                            },
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () async {
                              if (isFullScreen) {
                                setState(() {
                                  fullScreenPdfIndex = null;
                                  isFullScreen = false;
                                  fullScreenPageNumber = 0;
                                });

                                await widget.model
                                    .setIsFullScreen(isFullScreen: false);
                              }
                            },
                            child: const SizedBox(
                              width: 40,
                              height: 40,
                              child: Icon(
                                MaterialIcons.fullscreen_exit,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
