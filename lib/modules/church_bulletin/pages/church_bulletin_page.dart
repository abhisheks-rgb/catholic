import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:intl/intl.dart';

import '../models/church_bulletin_model.dart';
import '../../../utils/asset_path.dart';
import '../../../../utils/page_specs.dart';

class ChurchBulletinPage extends BaseStatefulPageView {
  final ChurchBulletinModel? model;

  ChurchBulletinPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_church_bulletin');

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
  var controllers = <String, PdfViewerController>{};

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
    super.dispose();
    delayedReset();
  }

  void delayedReset() async {
    await widget.model.setChurchName(churchName: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.33,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    assetPath('page-bg.png'),
                  ),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              height: 350.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  colors: [
                    Color.fromRGBO(255, 252, 245, 0),
                    Color.fromRGBO(255, 252, 245, 1),
                  ],
                  stops: [0.0, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Align(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(1, -1),
                        end: Alignment(-1, 1),
                        colors: <Color>[
                          Color.fromRGBO(24, 77, 212, 0.5),
                          Color.fromRGBO(255, 255, 255, 0),
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
              height: MediaQuery.of(context).size.height * 0.5,
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
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                        RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () async {
                            if (widget.model.items!.isNotEmpty &&
                                _bulletinItems != null) {
                              showAlert(context);
                            }
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedParishValue != null
                                          ? _getChurchName(_selectedParishValue)
                                          : '',
                                      style: const TextStyle(
                                        color: Color.fromRGBO(4, 26, 82, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Entypo.chevron_down,
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
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
                                      color: const Color.fromRGBO(
                                          255, 255, 255, 1),
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              208, 185, 133, 0.15),
                                          offset: Offset(0, 8),
                                          blurRadius: 16,
                                        ),
                                        BoxShadow(
                                          color: Color.fromRGBO(
                                              208, 185, 133, 0.05),
                                          offset: Offset(0, 4),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 12),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  color: Color.fromRGBO(
                                                      4, 26, 82, 1),
                                                ),
                                              ),
                                              _bulletinItems![index]
                                                          ['description'] ==
                                                      null
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          _bulletinItems![index]
                                                                      [
                                                                      'description']
                                                                  .isNotEmpty
                                                              ? _bulletinItems![
                                                                          index]
                                                                      [
                                                                      'description']
                                                                  .isNotEmpty
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    4,
                                                                    26,
                                                                    82,
                                                                    0.5),
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
                                                      _bulletinItems![index]
                                                          ['id']],
                                                  canShowPaginationDialog:
                                                      false,
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
                                              index > -1
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
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            child: const Icon(
                                                              Icons
                                                                  .arrow_back_ios,
                                                              color:
                                                                  Colors.black,
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
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(0),
                                                            child: const Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              index > -1
                                                  ? RawMaterialButton(
                                                      constraints:
                                                          const BoxConstraints(),
                                                      materialTapTargetSize:
                                                          MaterialTapTargetSize
                                                              .shrinkWrap,
                                                      onPressed: () {
                                                        _showOverlay(
                                                            context, index);
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 8,
                                                                horizontal: 0),
                                                        child: const Text(
                                                          'View Bulletin',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    12,
                                                                    72,
                                                                    224,
                                                                    1),
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
                                                      onPressed: () {
                                                        _showOverlay(
                                                            context, index);
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
                                                                  Alignment
                                                                      .center,
                                                              child: const Icon(
                                                                MaterialIcons
                                                                    .fullscreen,
                                                                color: Colors
                                                                    .black,
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
                            ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
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
      controllers = {};
    });
    try {
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
    } catch (e, stacktrace) {
      Butter.e(e.toString());
      Butter.e(stacktrace.toString());
    }
  }

  void _showOverlay(BuildContext context, int index) {
    Navigator.of(context).push(Overlay(_bulletinItems![index]));
  }

  void showAlert(BuildContext context) {
    List<dynamic> churchList = [...widget.model.items!];
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: const EdgeInsets.all(0),
              title: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Select Church',
                          style: TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: const CircleBorder(),
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            MaterialCommunityIcons.close_circle,
                            color: Color.fromRGBO(130, 141, 168, 1),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              content: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                  maxHeight: 600,
                ),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: churchList.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              churchList[index]['name'] ?? '',
                              style: const TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedParishValue =
                              churchList[index]['name'].toString();
                        });

                        var parish = widget.model.items?.firstWhere((element) {
                          return element['name'] == churchList[index]['name'];
                        });

                        _getBulletin(parish['link']);
                        setState(() {
                          _selectedParishValue = churchList[index]['name'];
                        });

                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ));
  }

  String _getChurchName(String? selectedParish) {
    if (widget.model.items!.isNotEmpty) {
      var parish = widget.model.items?.firstWhere((element) {
        return element['name'] == selectedParish;
      });

      return '${parish['name']}';
    }

    return _selectedParishValue ?? '';
  }
}

class Overlay extends ModalRoute<void> {
  final dynamic bulletinItem;

  Overlay(this.bulletinItem, {Key? key}) : super();

  final PdfViewerController pdfViewerController = PdfViewerController();
  int fullScreenPageNumber = 0;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
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
                  bulletinItem['filelink'],
                  controller: pdfViewerController,
                  canShowPaginationDialog: false,
                  canShowScrollHead: false,
                  onDocumentLoaded: (PdfDocumentLoadedDetails details) {
                    fullScreenPageNumber = pdfViewerController.pageNumber;
                    changedExternalState();
                  },
                  onPageChanged: (PdfPageChangedDetails details) {
                    fullScreenPageNumber = details.newPageNumber;
                    changedExternalState();
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          bulletinItem['title'],
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
                  bulletinItem['description'] == null
                      ? Container()
                      : Text(
                          bulletinItem['description'].isNotEmpty
                              ? bulletinItem['description']
                              : '',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                  const SizedBox(height: 4),
                  Text(
                    'Posted • ${DateFormat('E, d MMM yyyy').format(DateTime.fromMillisecondsSinceEpoch(bulletinItem['created'], isUtc: true))}',
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
                              fullScreenPageNumber =
                                  pdfViewerController.pageNumber;
                              changedExternalState();
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
                              fullScreenPageNumber =
                                  pdfViewerController.pageNumber;
                              changedExternalState();
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
                            onPressed: () {
                              Navigator.pop(context);
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

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
