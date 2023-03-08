import 'dart:async';
import 'dart:ui';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

import '../models/schedules_model.dart';

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

  _SchedulesPageState(this.model);

  @override
  void initState() {
    super.initState();

    _selectedParishValue = "all";
    _getSchedules('all');
  }

  @override
  Widget build(BuildContext context) {
    // final List<String> entries = <String>[
    //   'All',
    //   'Devotion (DV)',
    //   'Holy Hour (HH)',
    //   'Station of the Cross (SC)',
    //   'Mass (M)',
    //   'Ash Wednesday (AW)'
    // ];

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
            Navigator.of(context).popAndPushNamed('/_/welcome');
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 245, 1),
        ),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: widget.model.loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Container(
                      height: 114,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                    borderRadius:
                                        BorderRadius.all(Radius.zero))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                icon: const Icon(Icons.keyboard_arrow_down),
                                elevation: 16,
                                isDense: true,
                                isExpanded: true,
                                value: _selectedParishValue,
                                hint: const Text('Select parish'),
                                items: [
                                  const DropdownMenuItem<String>(
                                    value: "all",
                                    child: Text("All Churches"),
                                  ),
                                  ...?widget.model.items?.map((value) {
                                    return DropdownMenuItem<String>(
                                      value: value['name'].toString(),
                                      child: Text(value['name'],
                                          style: const TextStyle(fontSize: 16)),
                                    );
                                  }).toList(),
                                ],
                                onChanged: (value) async {
                                  if (value == 'all') {
                                    _getSchedules('all');
                                  } else {
                                    var parish = widget.model.items
                                        ?.firstWhere((element) {
                                      return element['name'] == value;
                                    });

                                    _getSchedules(parish['link']);
                                  }

                                  setState(() {
                                    _selectedParishValue = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color.fromRGBO(4, 26, 82, 0.1),
                          ),
                          const SizedBox(height: 10),
                          Row(
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
                                        color: Color.fromRGBO(12, 72, 224, 1))),
                              ),
                              const Spacer(flex: 1),
                              RichText(
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: const <TextSpan>[
                                    TextSpan(
                                        style: TextStyle(
                                            letterSpacing: 0.1,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Color.fromRGBO(12, 72, 224, 1)),
                                        children: [
                                          TextSpan(
                                            text: 'Directions ',
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
                            ],
                          )
                        ],
                      ),
                    ),
                    _schedules != null &&
                            _schedules!.isNotEmpty &&
                            !isLoadingSchedules
                        ? Container(
                            height: 35,
                            width: double.infinity,
                            margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _schedTypes?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                bool isSelected =
                                    _schedTypes![index] == _selectedSchedType;
                                return ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        isSelected
                                            ? const Color.fromRGBO(4, 26, 82, 1)
                                            : const Color.fromRGBO(
                                                255, 255, 255, 1)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(18.0),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    final filtered =
                                        _schedules?.map((key, value) {
                                      final filteredSched = value.where((p) {
                                        return p['type'] == _schedTypes![index];
                                      }).toList();

                                      return MapEntry(key, filteredSched);
                                    });

                                    filtered?.removeWhere(
                                        (key, value) => value.isEmpty);

                                    setState(() {
                                      _filteredSchedules = filtered;
                                      _selectedSchedType = _schedTypes![index];
                                    });
                                  },
                                  child: Text(
                                    _schedTypes![index],
                                    style: TextStyle(
                                        color: isSelected
                                            ? const Color.fromRGBO(
                                                255, 255, 255, 1)
                                            : const Color.fromRGBO(
                                                4, 26, 82, 0.7)),
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
                                itemCount: _selectedSchedType == 'All'
                                    ? (_schedules?.length ?? 0)
                                    : (_filteredSchedules?.length ?? 0),
                                separatorBuilder: (context, index) {
                                  return const SizedBox(height: 24);
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  var data = _selectedSchedType == 'All'
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
                                                    Text(dateSchedText),
                                                    Text(DateFormat(
                                                            'E, d MMM yyyy')
                                                        .format(DateTime.parse(
                                                            key))),
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
                                                return Container(
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color.fromRGBO(
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
                                                                data?[key]
                                                                        [index]
                                                                    ['type']),
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
                                                    ],
                                                  ),
                                                );
                                              }),
                                        ],
                                      ));
                                }))
                  ]),
      ),
    );
  }

  Widget _scheduleChip(String type) {
    Color chipColor;
    String chipText;
    switch (type) {
      case 'Adoration':
        chipColor = const Color.fromRGBO(242, 199, 249, 1);
        chipText = 'A';
        break;
      case 'Devotion':
        chipColor = const Color.fromRGBO(169, 239, 197, 1);
        chipText = 'DV';
        break;
      case 'Penitential':
        chipColor = const Color.fromRGBO(255, 229, 173, 1);
        chipText = 'P';
        break;
      case 'Station of the Cross':
        chipColor = const Color.fromRGBO(255, 229, 173, 1);
        chipText = 'SC';
        break;
      default:
        chipColor = const Color.fromRGBO(219, 228, 251, 1);
        chipText = 'M';
    }
    return Chip(
      backgroundColor: chipColor,
      label: Text(chipText,
          style: const TextStyle(color: Color.fromRGBO(4, 26, 82, 1))),
    );
  }

  void _getSchedules(String parishlink) async {
    setState(() {
      isLoadingSchedules = true;
      _selectedSchedType = 'All';
    });
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('schedule')
        .call(
      {
        "input": parishlink,
      },
    );

    final response = result.data;
    List itemList = response['results']['items'] ?? [];
    var newMap = groupBy(itemList, (obj) {
      var k = DateFormat('yyyyMMdd')
          .format(DateTime.fromMillisecondsSinceEpoch(obj['date']));

      return k;
    });

    newMap.forEach((key, value) {
      value.sort((a, b) => b["start"].compareTo(a["start"]));
    });

    setState(() {
      _schedTypes = ['All', ...response['results']['type']];
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
