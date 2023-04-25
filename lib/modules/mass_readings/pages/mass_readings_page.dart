import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/mass_readings_model.dart';
import '../../../../utils/page_specs.dart';

class MassReadingsPage extends BaseStatefulPageView {
  final MassReadingsModel? model;

  MassReadingsPage({Key? key, this.model}) : super(animationDelay: 0);

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    model!.loadMassReading(DateFormat('yyyyMMdd').format(DateTime.now()));

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
        showFontSetting: true,
        title: 'Mass Readings',
      ));

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      _MassReadingsPage(model!);
}

class _MassReadingsPage extends StatefulWidget {
  final MassReadingsModel? model;

  const _MassReadingsPage(this.model);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _MassReadingsPageState(model);
}

class _MassReadingsPageState extends State<_MassReadingsPage> {
  final MassReadingsModel? model;
  String selectedDate = 'today';

  _MassReadingsPageState(this.model);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 245, 1),
        ),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 87,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(8, 10, 8, 10),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                model!.loadMassReading(DateFormat('yyyyMMdd')
                                    .format(DateTime.now()
                                        .subtract(const Duration(days: 1))));
                                setState(() {
                                  selectedDate = 'yesterday';
                                });
                              },
                              child: Container(
                                height: 42,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedDate == 'yesterday'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Yesterday',
                                  style: selectedDate == 'yesterday'
                                      ? const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.1,
                                          color:
                                              Color.fromRGBO(237, 241, 253, 1),
                                        )
                                      : const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.1,
                                          color: Color.fromRGBO(79, 95, 135, 1),
                                        ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                model!.loadMassReading(DateFormat('yyyyMMdd')
                                    .format(DateTime.now()));
                                setState(() {
                                  selectedDate = 'today';
                                });
                              },
                              child: Container(
                                height: 42,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedDate == 'today'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Today',
                                  style: selectedDate == 'today'
                                      ? const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.1,
                                          color:
                                              Color.fromRGBO(237, 241, 253, 1),
                                        )
                                      : const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.1,
                                          color: Color.fromRGBO(79, 95, 135, 1),
                                        ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                model!.loadMassReading(DateFormat('yyyyMMdd')
                                    .format(DateTime.now()
                                        .add(const Duration(days: 1))));
                                setState(() {
                                  selectedDate = 'tomorrow';
                                });
                              },
                              child: Container(
                                height: 42,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: selectedDate == 'tomorrow'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Tomorrow',
                                  style: selectedDate == 'tomorrow'
                                      ? const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.1,
                                          color:
                                              Color.fromRGBO(237, 241, 253, 1),
                                        )
                                      : const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.1,
                                          color: Color.fromRGBO(79, 95, 135, 1),
                                        ),
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                              onTap: () {
                                model!.loadMassReading(DateFormat('yyyyMMdd')
                                    .format(DateTime.now()
                                        .subtract(const Duration(days: 1))));
                                setState(() {
                                  selectedDate = 'yesterday';
                                });
                                _logMassReadingEvent('ytd');
                              },
                              child: Text(
                                DateFormat('d MMM').format(DateTime.now()
                                    .subtract(const Duration(days: 1))),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedDate == 'yesterday'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : const Color.fromRGBO(4, 26, 82, 0.5),
                                ),
                              )),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              model!.loadMassReading(DateFormat('yyyyMMdd')
                                  .format(DateTime.now()));
                              setState(() {
                                selectedDate = 'today';
                              });
                              _logMassReadingEvent('tdy');
                            },
                            child: Text(
                              DateFormat('d MMM').format(DateTime.now()),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: selectedDate == 'today'
                                    ? const Color.fromRGBO(12, 72, 224, 1)
                                    : const Color.fromRGBO(4, 26, 82, 0.5),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                model!.loadMassReading(DateFormat('yyyyMMdd')
                                    .format(DateTime.now()
                                        .add(const Duration(days: 1))));
                                setState(() {
                                  selectedDate = 'tomorrow';
                                });
                                _logMassReadingEvent('tmr');
                              },
                              child: Text(
                                DateFormat('d MMM').format(DateTime.now()
                                    .add(const Duration(days: 1))),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: selectedDate == 'tomorrow'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : const Color.fromRGBO(4, 26, 82, 0.5),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.5),
              widget.model?.loading == true &&
                      widget.model?.massReadingList != null
                  ? const Center(child: CircularProgressIndicator())
                  : Html(
                      data: widget.model?.massReadingItem!['day'],
                      style: {
                        'html': Style(
                          textAlign: TextAlign.start,
                          padding: const EdgeInsets.all(0),
                          margin: Margins.all(0),
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: FontSize(widget.model!.titleFontSize ?? 20),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                        'i': Style(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: FontSize(widget.model!.titleFontSize ?? 20),
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.normal,
                        ),
                      },
                    ),
              const SizedBox(height: 8),
              widget.model?.loading == true &&
                      widget.model?.massReadingList != null
                  ? const SizedBox()
                  : Column(
                      children: widget.model?.massReadingList?.map((item) {
                            Map? data = item as Map?;
                            String key = data?.keys.elementAt(0);
                            String title;

                            switch (key) {
                              case 'Mass_Ps':
                                title = 'Responsorial Psalm';
                                break;
                              case 'Mass_R2':
                                title = 'Second Reading';
                                break;
                              case 'Mass_GA':
                                title = 'Gospel Acclamation';
                                break;
                              case 'Mass_G':
                                title = 'Gospel';
                                break;
                              case 'copyright':
                                title = '';
                                break;
                              default:
                                title = 'First Reading';
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: key != 'copyright' ? 16 : 0),
                                Text(title,
                                    style: TextStyle(
                                      fontSize:
                                          widget.model!.contentFontSize ?? 17,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromRGBO(8, 51, 158, 1),
                                    )),
                                SizedBox(height: key != 'copyright' ? 8 : 0),
                                key != 'copyright'
                                    ? data![key]['heading'] != null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${data[key]['source'] ?? ''}',
                                                style: TextStyle(
                                                  fontSize: widget.model!
                                                          .contentFontSize ??
                                                      17,
                                                  color: const Color.fromRGBO(
                                                      4, 26, 82, 1),
                                                ),
                                              ),
                                              Text(
                                                '${data[key]['heading'] ?? ''}',
                                                style: TextStyle(
                                                  fontSize: widget.model!
                                                          .contentFontSize ??
                                                      17,
                                                  color: const Color.fromRGBO(
                                                      4, 26, 82, 1),
                                                ),
                                              ),
                                            ],
                                          )
                                        : data[key]['source'] != null
                                            ? Text(
                                                '${data[key]['source']}',
                                                style: TextStyle(
                                                  fontSize: widget.model!
                                                          .contentFontSize ??
                                                      17,
                                                  color: const Color.fromRGBO(
                                                      4, 26, 82, 1),
                                                ),
                                              )
                                            : const SizedBox()
                                    : const SizedBox(),
                                Html(
                                  data: data![key]['text'],
                                  style: {
                                    'div': Style(
                                      textAlign: TextAlign.left,
                                      color: const Color.fromRGBO(4, 26, 82, 1),
                                      fontSize: FontSize(
                                        widget.model!.contentFontSize ?? 17,
                                      ),
                                    ),
                                  },
                                ),
                              ],
                            );
                          }).toList() ??
                          []),
            ],
          ),
        ),
      ),
    );
  }

  void _logMassReadingEvent(String type) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'app_reading_$type',
    );
  }
}
