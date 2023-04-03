import 'dart:async';
import 'dart:ui';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import "package:collection/collection.dart";
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/schedules_model.dart';
import '../../../utils/asset_path.dart';

class SchedulesPage extends BaseStatefulPageView {
  final SchedulesModel? model;

  SchedulesPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    model!.loadData();

    return true;
  }

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      _SchedulesPage(model!);
}

class _SchedulesPage extends StatefulWidget {
  final SchedulesModel model;

  const _SchedulesPage(this.model);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _SchedulesPageState(model);
}

class _SchedulesPageState extends State<_SchedulesPage> {
  final SchedulesModel model;
  bool isLoadingSchedules = false;
  String? _selectedParishValue = "";
  String? _selectedSchedType = "";
  Map? _schedules;
  Map? _filteredSchedules;
  List? _schedTypes;
  Timer? myTimer;

  _SchedulesPageState(this.model);

  @override
  void initState() {
    super.initState();

    _selectedParishValue = 'Cathedral of the Good Shepherd';

    if (widget.model.churchName == null || widget.model.churchName == '') {
      _getSchedules('cathedral');
    } else {
      startTimer();
    }
  }

  void startTimer() async {
    int x = 0;

    await Future.delayed(const Duration(seconds: 1), () async {
      myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (widget.model.churchName != null || widget.model.churchName != '') {
          if (widget.model.items!.isNotEmpty) {
            x += 1;

            var parish = widget.model.items?.firstWhere((element) {
              return element['name'] == widget.model.churchName;
            });

            _getSchedules(parish['link']);

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
        title: const Text(
          'Mass Schedule',
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
                      // height: _selectedParishValue == 'all' ? 62 : 114,
                      width: double.infinity,
                      padding: _selectedParishValue == 'all'
                          ? const EdgeInsets.fromLTRB(20, 20, 20, 0)
                          : const EdgeInsets.fromLTRB(20, 20, 20, 20),
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
                              showAlert(context);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedParishValue != null
                                        ? _getChurchName(_selectedParishValue)
                                        : "",
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
                          ),
                          const SizedBox(height: 20),
                          _selectedParishValue == 'all'
                              ? const SizedBox()
                              : const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Color.fromRGBO(4, 26, 82, 0.1),
                                ),
                          _selectedParishValue == 'all'
                              ? const SizedBox()
                              : const SizedBox(height: 10),
                          _selectedParishValue == 'all'
                              ? const SizedBox()
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context)
                                            .popAndPushNamed('/_/church_info');
                                      },
                                      child: const Text('Church Info',
                                          style: TextStyle(
                                              letterSpacing: 0.1,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromRGBO(
                                                  12, 72, 224, 1))),
                                    ),
                                    const Spacer(flex: 1),
                                    RichText(
                                      text: TextSpan(
                                        text: '',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[
                                          TextSpan(
                                              style: TextStyle(
                                                  letterSpacing: 0.1,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      12, 72, 224, 1)),
                                              children: [
                                                TextSpan(
                                                  text: 'Directions ',
                                                ),
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 1.0),
                                                    child: Icon(
                                                        Icons.directions,
                                                        size: 18,
                                                        color: Color.fromRGBO(
                                                            12, 72, 224, 1)),
                                                  ),
                                                ),
                                              ]),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                        ],
                      ),
                    ),
                    _schedules != null &&
                            _schedules!.isNotEmpty &&
                            !isLoadingSchedules
                        ? Container(
                            height: 45,
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _schedTypes?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                bool isSelected =
                                    _schedTypes![index] == _selectedSchedType;
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  decoration: const BoxDecoration(
                                    boxShadow: [
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
                                  child: TextButton(
                                    style: ButtonStyle(
                                        padding: MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.symmetric(
                                                horizontal: 10.5)),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(isSelected
                                                ? const Color.fromRGBO(
                                                    255, 255, 255, 1)
                                                : const Color.fromRGBO(
                                                    4, 26, 82, 0.7)),
                                        backgroundColor: MaterialStateProperty.all(isSelected
                                            ? const Color.fromRGBO(4, 26, 82, 1)
                                            : const Color.fromRGBO(
                                                255, 255, 255, 1)),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ))),
                                    onPressed: () {
                                      final filtered =
                                          _schedules?.map((key, value) {
                                        final filteredSched = value.where((p) {
                                          return p['type'] ==
                                              _schedTypes![index];
                                        }).toList();

                                        return MapEntry(key, filteredSched);
                                      });

                                      filtered?.removeWhere(
                                          (key, value) => value.isEmpty);

                                      setState(() {
                                        _filteredSchedules = filtered;
                                        _selectedSchedType =
                                            _schedTypes![index];
                                      });
                                    },
                                    child: Text(_schedTypes![index]),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                width: 8,
                              ),
                            ))
                        : const SizedBox(),
                    isLoadingSchedules
                        ? Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: const Center(
                                child: CircularProgressIndicator()))
                        : Expanded(
                            child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: _selectedSchedType == 'All Types'
                                    ? (_schedules?.length ?? 0)
                                    : (_filteredSchedules?.length ?? 0),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 24);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  var data = _selectedSchedType == 'All Types'
                                      ? _schedules
                                      : _filteredSchedules;

                                  String key = data?.keys.elementAt(index);

                                  String dateSchedText = DateFormat('EEEE')
                                      .format(DateTime.parse(key))
                                      .toUpperCase();

                                  if (isToday(DateTime.parse(key))) {
                                    dateSchedText = 'TODAY';
                                  } else if (isTomorrow(DateTime.parse(key))) {
                                    dateSchedText = 'TOMORROW';
                                  }

                                  return SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      dateSchedText,
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              4, 26, 82, 1)),
                                                    ),
                                                    Text(
                                                      DateFormat('d MMM yyyy')
                                                          .format(
                                                              DateTime.parse(
                                                                  key)),
                                                      style: const TextStyle(
                                                          color: Color.fromRGBO(
                                                              4, 26, 82, 1)),
                                                    ),
                                                  ]),
                                              const SizedBox(height: 8),
                                            ],
                                          ),
                                          ListView.separated(
                                              reverse:
                                                  _selectedParishValue == 'all'
                                                      ? true
                                                      : false,
                                              itemCount: data?[key].length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const SizedBox(
                                                    height: 8);
                                              },
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                var schedParish = widget
                                                    .model.items
                                                    ?.firstWhere((element) {
                                                  return element['_id'] ==
                                                      data?[key][index]
                                                          ['parish'];
                                                });
                                                return InkWell(
                                                  child: Container(
                                                    width: double.infinity,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color:
                                                          const Color.fromRGBO(
                                                              255, 255, 255, 1),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              208,
                                                              185,
                                                              133,
                                                              0.15),
                                                          offset: Offset(0, 8),
                                                          blurRadius: 16,
                                                        ),
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              208,
                                                              185,
                                                              133,
                                                              0.05),
                                                          offset: Offset(0, 4),
                                                          blurRadius: 8,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                '${data?[key][index]['title']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          4,
                                                                          26,
                                                                          82,
                                                                          1),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 20,
                                                                ),
                                                              ),
                                                              _scheduleChip(
                                                                  data?[key][
                                                                          index]
                                                                      ['type'],
                                                                  data?[key][
                                                                          index]
                                                                      [
                                                                      'abbrev'],
                                                                  data?[key][
                                                                          index]
                                                                      [
                                                                      'colorEvento'],
                                                                  data?[key][
                                                                          index]
                                                                      ['color'],
                                                                  false),
                                                            ]),
                                                        Text(
                                                            '${data?[key][index]['lang'].toUpperCase()} • ${data?[key][index]['location'].toUpperCase()}',
                                                            style: const TextStyle(
                                                                letterSpacing:
                                                                    0.1,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        4,
                                                                        26,
                                                                        82,
                                                                        1),
                                                                fontFeatures: <
                                                                    FontFeature>[
                                                                  FontFeature
                                                                      .enable(
                                                                          'smcp')
                                                                ],
                                                                fontSize: 16)),
                                                        SizedBox(
                                                            height:
                                                                _selectedParishValue ==
                                                                        "all"
                                                                    ? 8
                                                                    : 0),
                                                        _selectedParishValue ==
                                                                "all"
                                                            ? Text(
                                                                schedParish[
                                                                    'name'],
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          12,
                                                                          72,
                                                                          224,
                                                                          1),
                                                                ),
                                                              )
                                                            : const SizedBox(),
                                                        data?[key][index]
                                                                    ['notes'] !=
                                                                ""
                                                            ? Container(
                                                                margin: const EdgeInsets
                                                                        .fromLTRB(
                                                                    0,
                                                                    8,
                                                                    0,
                                                                    12),
                                                                child:
                                                                    const DottedLine(),
                                                              )
                                                            : const SizedBox(),
                                                        Text(
                                                          data?[key][index]
                                                              ['notes'],
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          4,
                                                                          26,
                                                                          82,
                                                                          1)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    _showPopup(context,
                                                        data?[key][index]);
                                                  },
                                                );
                                              }),
                                        ],
                                      ));
                                }))
                  ]),
      ),
    );
  }

  void showAlert(BuildContext context) {
    List<dynamic> churchList = [
      {'name': 'All Churches', 'completename': 'All Churches'},
      ...widget.model.items!
    ];
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
                  const SizedBox(height: 20),
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
                    return const SizedBox(height: 10);
                  },
                  itemBuilder: (context, index) {
                    if (index == churchList.length - 1) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RawMaterialButton(
                              constraints: const BoxConstraints(),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {
                                setState(() {
                                  _selectedParishValue =
                                      churchList[index]['name'].toString();
                                });
                                if (churchList[index]['name'] ==
                                    'All Churches') {
                                  _getSchedules('all');
                                  setState(() {
                                    _selectedParishValue = 'all';
                                  });
                                } else {
                                  var parish =
                                      widget.model.items?.firstWhere((element) {
                                    return element['name'] ==
                                        churchList[index]['name'];
                                  });

                                  _getSchedules(parish['link']);
                                  setState(() {
                                    _selectedParishValue =
                                        churchList[index]['name'];
                                  });
                                }
                                Navigator.pop(context);
                              },
                              child: Text(
                                churchList[index]['completename'] ?? '',
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      );
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 24),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            setState(() {
                              _selectedParishValue =
                                  churchList[index]['name'].toString();
                            });
                            if (churchList[index]['name'] == 'All Churches') {
                              _getSchedules('all');
                              setState(() {
                                _selectedParishValue = 'all';
                              });
                            } else {
                              var parish =
                                  widget.model.items?.firstWhere((element) {
                                return element['name'] ==
                                    churchList[index]['name'];
                              });

                              _getSchedules(parish['link']);
                              setState(() {
                                _selectedParishValue =
                                    churchList[index]['name'];
                              });
                            }

                            Navigator.pop(context);
                          },
                          child: Text(
                            churchList[index]['completename'] ?? '',
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ));
  }

  void _showPopup(BuildContext context, var schedData) {
    var schedParish = widget.model.items?.firstWhere((element) {
      return element['_id'] == schedData['parish'];
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
            content: SingleChildScrollView(
              // ignore: sized_box_for_whitespace
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Schedule Details',
                          style: TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.all(0),
                          alignment: Alignment.centerRight,
                          icon: const Icon(Ionicons.close_circle),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${schedData['title']}',
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                ),
                              ),
                              _scheduleChip(
                                  schedData['type'],
                                  schedData['abbrev'],
                                  schedData['colorEvento'],
                                  schedData['color'],
                                  true),
                            ]),
                        Text(
                            '${schedData['lang'].toUpperCase()} • ${schedData['location'].toUpperCase()}',
                            style: const TextStyle(
                                letterSpacing: 0.1,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(4, 26, 82, 1),
                                fontFeatures: <FontFeature>[
                                  FontFeature.enable('smcp')
                                ],
                                fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(219, 228, 251, 1),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            assetPath('church-alt.png'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            schedParish['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(12, 72, 224, 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            assetPath('map-pin-solid.png'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            schedParish['address'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: Image.asset(
                            assetPath('directions.png'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget _scheduleChip(String type, String abbrev, String colorEvent,
      String colorString, bool isLongName) {
    return Chip(
      backgroundColor: HexColor(colorEvent).withOpacity(1.0),
      label: Text(
        isLongName ? type : abbrev,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: HexColor(colorString).withOpacity(1.0)),
      ),
    );
  }

  String _getChurchName(String? selectedParish) {
    if (selectedParish == 'all') {
      return 'All Churches';
    } else {
      var parish = widget.model.items?.firstWhere((element) {
        return element['name'] == selectedParish;
      });

      return '${parish['completename']}';
    }
  }

  void _getSchedules(String parishlink) async {
    setState(() {
      isLoadingSchedules = true;
      _selectedSchedType = 'All Types';
    });
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('schedule')
        .call(
      {
        "input": parishlink,
      },
    );

    final response = result.data;

    List<dynamic> itemList = response['results']['items'] ?? [];
    List schedTypeList = response['results']['type'] ?? [];
    schedTypeList.sort((a, b) => a.compareTo(b));

    var newMap = groupBy(itemList, (obj) {
      var k = DateFormat('yyyyMMdd').format(
          DateTime.fromMillisecondsSinceEpoch(obj['date'], isUtc: true));

      return k;
    });

    newMap.forEach((key, value) {
      value.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(b["start"],
              isUtc: true)
          .compareTo(
              DateTime.fromMillisecondsSinceEpoch(b["start"], isUtc: true)));
    });

    newMap.removeWhere((key, value) {
      return int.parse(key) <
          int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    });

    setState(() {
      _schedTypes = ['All Types', ...schedTypeList];
      _schedules = Map.fromEntries(
          newMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
      isLoadingSchedules = false;
    });
  }

  bool isToday(DateTime date) {
    final DateTime localDate = date.toLocal();
    final now = DateTime.now();
    final diff = now.difference(localDate).inDays;
    return diff == 0 && now.day == localDate.day;
  }

  bool isTomorrow(DateTime date) {
    final DateTime localDate = date.toLocal();
    final now = DateTime.now().add(const Duration(days: 1));
    final diff = now.difference(localDate).inDays;

    return diff == 0 && now.day == localDate.day;
  }
}
