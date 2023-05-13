import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';

import 'package:butter/butter.dart';
import 'package:collection/collection.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/schedules_model.dart';
import '../../../utils/asset_path.dart';
import '../../../../utils/page_specs.dart';

class SchedulesPage extends BaseStatefulPageView {
  final SchedulesModel? model;

  SchedulesPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'app_schedules');

    model!.loadData();

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        title: 'Mass Schedules',
      ));

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
  String? _selectedParishValue = '';
  String? _selectedSchedType = '';
  Map? _schedules;
  Map? _filteredSchedules;
  List? _schedTypes;
  Timer? myTimer;
  DateTime? _selectedDate;

  _SchedulesPageState(this.model);

  @override
  void initState() {
    super.initState();

    _selectedParishValue = 'all';

    if (widget.model.churchName == null || widget.model.churchName == '') {
      _getSchedules('all');
    } else {
      _selectedParishValue = widget.model.churchName;

      startTimer();
    }
  }

  void startTimer() async {
    int x = 0;

    myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (widget.model.churchName != null || widget.model.churchName != '') {
        if (widget.model.items!.isNotEmpty) {
          x += 1;

          var parish = widget.model.items?.firstWhere((element) {
            return element['name'] == widget.model.churchName;
          });

          _getSchedules(parish['link']);
        }
      } else {
        x += 1;
      }

      if (x > 0) {
        timer.cancel();
      }
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: _selectedParishValue == 'all'
                        ? const EdgeInsets.fromLTRB(20, 12, 20, 0)
                        : const EdgeInsets.fromLTRB(20, 12, 20, 20),
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
                                _schedules != null) {
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
                        const SizedBox(height: 12),
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
                                      final index = widget.model.items!
                                          .indexWhere((item) =>
                                              item['name'] ==
                                              _selectedParishValue);

                                      if (index != -1) {
                                        widget.model.showPage('/_/church_info',
                                            index + 1, _selectedParishValue);
                                      }
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
                                  RawMaterialButton(
                                    constraints: const BoxConstraints(),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () {
                                      final query = _getChurchAddress(
                                          _selectedParishValue);
                                      if (query.isNotEmpty) {
                                        _redirectToMaps(query);
                                      }
                                    },
                                    child: RichText(
                                      text: TextSpan(
                                        text: '',
                                        style:
                                            DefaultTextStyle.of(context).style,
                                        children: const <TextSpan>[
                                          TextSpan(children: [
                                            TextSpan(
                                              text: 'Directions ',
                                              style: TextStyle(
                                                  letterSpacing: 0.1,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromRGBO(
                                                      12, 72, 224, 1)),
                                            ),
                                            WidgetSpan(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 1.0),
                                                child: Icon(Icons.directions,
                                                    size: 18,
                                                    color: Color.fromRGBO(
                                                        12, 72, 224, 1)),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                  ),

                  // Schedule Type Filter
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
                              bool isSelected = _schedTypes![index]['type'] ==
                                  _selectedSchedType;
                              bool hasDateSelected =
                                  _schedTypes![index]['type'] == 'Date' &&
                                      _selectedDate != null;

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
                                          MaterialStateProperty.all<Color>(
                                              isSelected || hasDateSelected
                                                  ? const Color.fromRGBO(
                                                      255, 255, 255, 1)
                                                  : const Color.fromRGBO(
                                                      4, 26, 82, 0.7)),
                                      backgroundColor: MaterialStateProperty.all(
                                          isSelected || hasDateSelected
                                              ? const Color.fromRGBO(
                                                  4, 26, 82, 1)
                                              : const Color.fromRGBO(
                                                  255, 255, 255, 1)),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32.0),
                                      ))),
                                  onPressed: () async {
                                    if (_schedTypes![index]['type'] == 'Date') {
                                      final DateTime? picked =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime.now().add(Duration(
                                            days: (_selectedParishValue == 'all'
                                                ? 7
                                                : 30))),
                                      );
                                      if (picked != null) {
                                        var seen = <String>{};
                                        List filteredTypeList = [];
                                        final filtered =
                                            _schedules?.map((key, value) {
                                          final filteredSched =
                                              value.where((p) {
                                            return p['type'] ==
                                                _selectedSchedType;
                                          }).toList();

                                          return MapEntry(
                                              key,
                                              _selectedSchedType != 'All Types'
                                                  ? filteredSched
                                                  : value.toList());
                                        });

                                        filtered?.removeWhere((key, value) {
                                          return int.parse(key) !=
                                              int.parse(DateFormat('yyyyMMdd')
                                                  .format(picked));
                                        });

                                        filtered?.forEach((key, value) {
                                          filteredTypeList = [
                                            ...value
                                                .toList()
                                                .where(
                                                    (d) => seen.add(d['type']))
                                                .map((item) => {
                                                      'type': item['type'],
                                                      'abbrev': item['abbrev']
                                                    })
                                                .toList(),
                                            ...filteredTypeList
                                          ];
                                        });

                                        filteredTypeList.sort((a, b) {
                                          if (a['type'] == 'Mass') {
                                            return -1;
                                          } else if (b['type'] == 'Mass') {
                                            return 1;
                                          } else {
                                            return a['type']
                                                .compareTo(b['type']);
                                          }
                                        });

                                        setState(() {
                                          _selectedDate = picked;
                                          _filteredSchedules = filtered;
                                          _schedTypes = [
                                            {'type': 'Date'},
                                            {'type': 'All Types'},
                                            ...filteredTypeList
                                          ];
                                        });
                                      }
                                    } else {
                                      final filtered =
                                          _schedules?.map((key, value) {
                                        final filteredSched = value.where((p) {
                                          return p['type'] ==
                                              _schedTypes![index]['type'];
                                        }).toList();

                                        return MapEntry(
                                            key,
                                            _schedTypes![index]['type'] !=
                                                    'All Types'
                                                ? filteredSched
                                                : value.toList());
                                      });

                                      filtered?.removeWhere(
                                          (key, value) => value.isEmpty);

                                      if (_selectedDate != null) {
                                        filtered?.removeWhere((key, value) {
                                          return int.parse(key) !=
                                              int.parse(DateFormat('yyyyMMdd')
                                                  .format(_selectedDate!));
                                        });
                                      }

                                      setState(() {
                                        _filteredSchedules = filtered;
                                        _selectedSchedType =
                                            _schedTypes![index]['type'];
                                      });
                                    }
                                  },
                                  child: hasDateSelected
                                      ? Row(children: [
                                          const Icon(
                                              MaterialCommunityIcons
                                                  .calendar_blank_outline,
                                              size: 16),
                                          const SizedBox(width: 5),
                                          Text(
                                            DateFormat('d MMM yy')
                                                .format(_selectedDate!),
                                          ),
                                          const SizedBox(width: 5),
                                          GestureDetector(
                                            onTap: () {
                                              var seen = <String>{};
                                              List filteredTypeList = [];
                                              final filtered =
                                                  _schedules?.map((key, value) {
                                                final filteredSched =
                                                    value.where((p) {
                                                  return p['type'] ==
                                                      _selectedSchedType;
                                                }).toList();

                                                return MapEntry(
                                                    key,
                                                    _selectedSchedType !=
                                                            'All Types'
                                                        ? filteredSched
                                                        : value.toList());
                                              });

                                              filtered?.forEach((key, value) {
                                                filteredTypeList = [
                                                  ...value
                                                      .toList()
                                                      .where((d) =>
                                                          seen.add(d['type']))
                                                      .map((item) => {
                                                            'type':
                                                                item['type'],
                                                            'abbrev':
                                                                item['abbrev']
                                                          })
                                                      .toList(),
                                                  ...filteredTypeList
                                                ];
                                              });

                                              filteredTypeList.sort((a, b) {
                                                if (a['type'] == 'Mass') {
                                                  return -1;
                                                } else if (b['type'] ==
                                                    'Mass') {
                                                  return 1;
                                                } else {
                                                  return a['type']
                                                      .compareTo(b['type']);
                                                }
                                              });

                                              setState(() {
                                                _selectedDate = null;
                                                _filteredSchedules = filtered;
                                                _schedTypes = [
                                                  {'type': 'Date'},
                                                  {'type': 'All Types'},
                                                  ...filteredTypeList
                                                ];
                                              });
                                            },
                                            child: const Icon(
                                                MaterialCommunityIcons.close,
                                                size: 16),
                                          ),
                                        ])
                                      : _schedTypes![index]['type'] ==
                                              'All Types'
                                          ? Text(
                                              '${_schedTypes![index]['type']}')
                                          : _schedTypes![index]['type'] ==
                                                  'Date'
                                              ? Row(children: [
                                                  const Icon(
                                                      MaterialCommunityIcons
                                                          .calendar_blank_outline,
                                                      size: 16,
                                                      color: Color.fromRGBO(
                                                          4, 26, 82, 0.7)),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                      '${_schedTypes![index]['type']}'),
                                                ])
                                              : Text(
                                                  '${_schedTypes![index]['type']} (${_schedTypes![index]['abbrev']})'),
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
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: const EdgeInsets.only(top: 20),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : ((_selectedSchedType == 'All Types' &&
                                          _selectedDate == null)
                                      ? _schedules
                                      : _filteredSchedules) !=
                                  null &&
                              !isLoadingSchedules
                          ? Flexible(
                              child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _selectedSchedType == 'All Types' &&
                                              _selectedDate == null
                                          ? (_schedules?.length ?? 0)
                                          : (_filteredSchedules?.length ?? 0),
                                  separatorBuilder: (context, index) {
                                    return const SizedBox(height: 24);
                                  },
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var data =
                                        _selectedSchedType == 'All Types' &&
                                                _selectedDate == null
                                            ? _schedules
                                            : _filteredSchedules;

                                    String key = data?.keys.elementAt(index);

                                    String dateSchedText = DateFormat('EEEE')
                                        .format(DateTime.parse(key))
                                        .toUpperCase();

                                    if (isToday(DateTime.parse(key))) {
                                      dateSchedText = 'TODAY';
                                    } else if (isTomorrow(
                                        DateTime.parse(key))) {
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
                                                            color:
                                                                Color.fromRGBO(
                                                                    4,
                                                                    26,
                                                                    82,
                                                                    1)),
                                                      ),
                                                      Text(
                                                        DateFormat('d MMM yyyy')
                                                            .format(
                                                                DateTime.parse(
                                                                    key)),
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    4,
                                                                    26,
                                                                    82,
                                                                    1)),
                                                      ),
                                                    ]),
                                                const SizedBox(height: 8),
                                              ],
                                            ),
                                            ListView.separated(
                                                itemCount: data?[key].length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const SizedBox(
                                                      height: 8);
                                                },
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
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
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color
                                                                .fromRGBO(
                                                            255, 255, 255, 1),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color:
                                                                Color.fromRGBO(
                                                                    208,
                                                                    185,
                                                                    133,
                                                                    0.15),
                                                            offset:
                                                                Offset(0, 8),
                                                            blurRadius: 16,
                                                          ),
                                                          BoxShadow(
                                                            color:
                                                                Color.fromRGBO(
                                                                    208,
                                                                    185,
                                                                    133,
                                                                    0.05),
                                                            offset:
                                                                Offset(0, 4),
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
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                                _scheduleChip(
                                                                    data?[key]
                                                                            [
                                                                            index]
                                                                        [
                                                                        'type'],
                                                                    data?[key]
                                                                            [
                                                                            index]
                                                                        [
                                                                        'abbrev'],
                                                                    data?[key][
                                                                            index]
                                                                        [
                                                                        'colorEvento'],
                                                                    data?[key][
                                                                            index]
                                                                        [
                                                                        'color'],
                                                                    false),
                                                              ]),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                              '${data?[key][index]['lang']} • ${data?[key][index]['location']}',
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
                                                                  fontSize:
                                                                      16)),
                                                          _selectedParishValue ==
                                                                  'all'
                                                              ? RawMaterialButton(
                                                                  constraints:
                                                                      const BoxConstraints(),
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                  onPressed:
                                                                      () {
                                                                    final query =
                                                                        schedParish[
                                                                            'address'];
                                                                    if (query
                                                                        .isNotEmpty) {
                                                                      _redirectToMaps(
                                                                          query);
                                                                    }
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding: const EdgeInsets
                                                                            .symmetric(
                                                                        vertical:
                                                                            4),
                                                                    child: Row(
                                                                      children: [
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            schedParish['name'],
                                                                            style:
                                                                                const TextStyle(
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Color.fromRGBO(12, 72, 224, 1),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          width:
                                                                              24,
                                                                          height:
                                                                              24,
                                                                          child:
                                                                              Icon(
                                                                            Icons.directions,
                                                                            color: Color.fromRGBO(
                                                                                12,
                                                                                72,
                                                                                224,
                                                                                1),
                                                                            size:
                                                                                24,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                          data?[key][index][
                                                                      'notes'] !=
                                                                  ''
                                                              ? Container(
                                                                  margin: const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      4,
                                                                      0,
                                                                      12),
                                                                  child:
                                                                      DottedLine(
                                                                    dashColor: HexColor(
                                                                            '#CCCCCC')
                                                                        .withOpacity(
                                                                            1.0),
                                                                  ),
                                                                )
                                                              : const SizedBox(),
                                                          data?[key][index][
                                                                      'notes'] !=
                                                                  ''
                                                              ? Text(
                                                                  data?[key][
                                                                          index]
                                                                      ['notes'],
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          14,
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
                                                              : const SizedBox()
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
                          : _renderEmptyState()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(BuildContext context) {
    List<dynamic> churchList = [
      {'name': 'All Churches'},
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
                        if (churchList[index]['name'] == 'All Churches') {
                          _getSchedules('all');
                          setState(() {
                            _selectedParishValue = 'all';
                          });
                        } else {
                          var parish =
                              widget.model.items?.firstWhere((element) {
                            return element['name'] == churchList[index]['name'];
                          });

                          _getSchedules(parish['link']);
                          setState(() {
                            _selectedParishValue = churchList[index]['name'];
                          });
                        }

                        Navigator.pop(context);
                      },
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
          insetPadding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          content: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              // height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                                false),
                          ]),
                      Text(
                          '${schedData['lang'].toUpperCase()} • ${schedData['location'].toUpperCase()}',
                          style: const TextStyle(
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Container(
                  //   height: 120,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(10),
                  //     color: const Color.fromRGBO(219, 228, 251, 1),
                  //   ),
                  // ),
                  // const SizedBox(height: 8),
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
                  InkWell(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            MaterialCommunityIcons.map_marker,
                            color: Color.fromRGBO(130, 141, 168, 1),
                            size: 20,
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
                        const SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            MaterialCommunityIcons.directions,
                            color: Color.fromRGBO(12, 72, 224, 1),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      final query = _getChurchAddress(_selectedParishValue);
                      if (query.isNotEmpty) {
                        _redirectToMaps(query);
                      }
                    },
                  ),
                  schedData['notes'] != ''
                      ? Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: Image.asset(assetPath('notes.png'),
                                  color: const Color.fromRGBO(4, 26, 82, 0.5)),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 8),
                              child: Text(
                                'Additional Notes:',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(4, 26, 82, 0.3)),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox(),
                  Text(
                    '${schedData['notes']}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(4, 26, 82, 1)),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _scheduleChip(String type, String abbrev, String colorEvent,
      String colorString, bool isLongName) {
    return Container(
      width: 32,
      height: 19,
      decoration: BoxDecoration(
        color: HexColor(colorEvent).withOpacity(1.0),
        borderRadius: BorderRadius.circular(32),
      ),
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Add any child widgets here, separated by the gap distance
          Center(
            child: Text(
              isLongName ? type : abbrev,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: HexColor(colorString).withOpacity(1.0),
                fontSize: 11,
              ),
            ),
          )
          // Another child widget
        ],
      ),
    );
  }

  Widget _renderEmptyState() => Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.45,
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: const Align(
          alignment: Alignment.center,
          child: Text(
            'Sorry, there are no available schedules.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromRGBO(4, 26, 82, 0.5),
              fontSize: 20,
            ),
          ),
        ),
      );

  String _getChurchName(String? selectedParish) {
    if (selectedParish == 'all') {
      return 'All Churches';
    } else {
      var parish = widget.model.items?.firstWhere((element) {
        return element['name'] == selectedParish;
      });

      return '${parish['name']}';
    }
  }

  String _getChurchAddress(String? selectedParish) {
    if (selectedParish == 'all') {
      return '';
    } else {
      var parish = widget.model.items?.firstWhere((element) {
        return element['name'] == selectedParish;
      });

      return '${parish['address']}';
    }
  }

  void urlLauncher(Uri uri, String source) async {
    if (source == 'web') {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $uri';
      }
    } else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }

  void _redirectToMaps(String query) async {
    // final intRegex = RegExp(r'\d+$');
    // final result = intRegex.firstMatch(query)!;
    // final postalCode = result[0];
    // final url = Uri.parse(
    //     'https://developers.onemap.sg/commonapi/search?searchVal=$postalCode&returnGeom=Y&getAddrDetails=Y');
    // final response = await http.get(url);
    // final decodedResponse = json.decode(response.body);
    // final matches = List<dynamic>.from(decodedResponse['results']);
    // final filteredMatches = matches.where((loc) => loc['POSTAL'] == postalCode);
    // final loc = filteredMatches.isNotEmpty ? filteredMatches.first : null;

    // if (loc != null) {
    // final googleMaps =
    //     'https://www.google.com/maps/search/?api=1&query=${loc['LATITUDE']},${loc['LONGITUDE']}';
    final googleMaps = 'https://www.google.com/maps/search/?api=1&query=$query';
    final uri = Uri.parse(googleMaps);
    urlLauncher(uri, 'web');
    // } else if (mounted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Cannot find parish'),
    //     ),
    //   );
    // }
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
        'input': parishlink,
      },
    );

    final response = result.data;

    List<dynamic> itemList = response['results']['items'] ?? [];

    var seen = <String>{};
    List schedTypeList = itemList
        .where((d) => seen.add(d['type']))
        .map((item) => {'type': item['type'], 'abbrev': item['abbrev']})
        .toList();
    schedTypeList.sort((a, b) {
      if (a['type'] == 'Mass') {
        return -1;
      } else if (b['type'] == 'Mass') {
        return 1;
      } else {
        return a['type'].compareTo(b['type']);
      }
    });

    var newMap = groupBy(itemList, (obj) {
      var k = DateFormat('yyyyMMdd').format(
          DateTime.fromMillisecondsSinceEpoch(obj['start'], isUtc: true));

      return k;
    });

    newMap.forEach((key, value) {
      value.sort((a, b) => DateTime.fromMillisecondsSinceEpoch(a['start'],
              isUtc: true)
          .compareTo(
              DateTime.fromMillisecondsSinceEpoch(b['start'], isUtc: true)));
    });

    newMap.removeWhere((key, value) {
      return int.parse(key) <
          int.parse(DateFormat('yyyyMMdd').format(DateTime.now()));
    });

    Map newSchedules = Map.fromEntries(
        newMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));

    setState(() {
      _schedTypes = [
        {'type': 'Date'},
        {'type': 'All Types'},
        ...schedTypeList
      ];
      _schedules = newSchedules;
      isLoadingSchedules = false;
    });

    if (_selectedSchedType != 'All Types' || _selectedDate != null) {
      var seen = <String>{};
      List filteredTypeList = [];

      final filtered = newSchedules.map((key, value) {
        final filteredSched = value.where((p) {
          return p['type'] == _selectedSchedType;
        }).toList();

        return MapEntry(key,
            _selectedSchedType != 'All Types' ? filteredSched : value.toList());
      });

      if (_selectedDate != null) {
        filtered.removeWhere((key, value) {
          return int.parse(key) !=
              int.parse(DateFormat('yyyyMMdd').format(_selectedDate!));
        });
      }

      filtered.removeWhere((key, value) => value.isEmpty);
      filtered.forEach((key, value) {
        filteredTypeList = [
          ...value
              .toList()
              .where((d) => seen.add(d['type']))
              .map((item) => {'type': item['type'], 'abbrev': item['abbrev']})
              .toList(),
          ...filteredTypeList
        ];
      });

      filteredTypeList.sort((a, b) {
        if (a['type'] == 'Mass') {
          return -1;
        } else if (b['type'] == 'Mass') {
          return 1;
        } else {
          return a['type'].compareTo(b['type']);
        }
      });

      setState(() {
        _filteredSchedules = filtered;
        _schedTypes = [
          {'type': 'Date'},
          {'type': 'All Types'},
          ...filteredTypeList
        ];
      });
    }

    await FirebaseAnalytics.instance.logEvent(
      name: 'app_sched_$parishlink',
    );
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
