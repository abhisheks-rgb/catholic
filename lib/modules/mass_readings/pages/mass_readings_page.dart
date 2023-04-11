import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_html/flutter_html.dart';

import '../models/mass_readings_model.dart';
import '../../../../utils/page_specs.dart';

class MassReadingsPage extends BaseStatefulPageView {
  final MassReadingsModel? model;

  MassReadingsPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    model!.loadMassReading(DateFormat('yyyyMMdd').format(DateTime.now()));

    return true;
  }

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: true,
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

class _MassReadingsPageState extends State<_MassReadingsPage>
    with SingleTickerProviderStateMixin {
  final MassReadingsModel? model;
  final ScrollController _scrollController = ScrollController();
  late TabController _tabController;
  late final List<GlobalKey> _itemKeys;
  late List<Widget> tabWidgets;
  String selectedDate = 'today';

  _MassReadingsPageState(this.model);

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final visibleIndex = _calculateVisibleItemIndex();
      _tabController.animateTo(visibleIndex);
    });
  }

  @override
  void didUpdateWidget(covariant _MassReadingsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // ignore: prefer_is_empty
    if (oldWidget.model?.massReadingList?.length == 0 &&
        // ignore: prefer_is_empty
        widget.model!.massReadingList!.length > 0) {
      _tabController = TabController(
          length: widget.model?.massReadingList?.length ?? 0, vsync: this);
      _itemKeys = List.generate(
          widget.model?.massReadingList?.length ?? 0, (index) => GlobalKey());
      tabWidgets = widget.model!.massReadingTypeList!
          .map((item) {
            String title;

            switch (item) {
              case 'Mass_Ps':
                title = 'Responsorial Psalm';
                break;
              case 'Mass_R2':
                title = 'Second Reading';
                break;
              case 'Mass_GA':
                title = 'Gospel Acclaimation';
                break;
              case 'Mass_G':
                title = 'Gospel';
                break;
              default:
                title = 'First Reading';
            }
            return Tab(text: title);
          })
          .toList()
          .cast<Widget>();
    }
  }

  int _calculateVisibleItemIndex() {
    RenderBox? renderBox;
    Offset offset;
    double maxVisibleFraction = 0;
    int visibleIndex = 0;

    for (int i = 0; i < _itemKeys.length; i++) {
      if (_itemKeys[i].currentContext != null) {
        renderBox =
            _itemKeys[i].currentContext!.findRenderObject() as RenderBox?;
        offset = renderBox!.localToGlobal(Offset.zero);

        final itemHeight = renderBox.size.height;
        final visibleFraction = itemHeight - offset.dy;

        if (visibleFraction > maxVisibleFraction) {
          maxVisibleFraction = visibleFraction;
          visibleIndex = i;
        }
      }
    }

    return visibleIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 245, 1),
        ),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
        child: widget.model?.loading == true &&
                widget.model?.massReadingList != null
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                                    model!.loadMassReading(
                                        DateFormat('yyyyMMdd').format(
                                            DateTime.now().subtract(
                                                const Duration(days: 1))));
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
                                              color: Color.fromRGBO(
                                                  237, 241, 253, 1),
                                            )
                                          : const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.1,
                                              color: Color.fromRGBO(
                                                  79, 95, 135, 1),
                                            ),
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    model!.loadMassReading(
                                        DateFormat('yyyyMMdd')
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
                                              color: Color.fromRGBO(
                                                  237, 241, 253, 1),
                                            )
                                          : const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.1,
                                              color: Color.fromRGBO(
                                                  79, 95, 135, 1),
                                            ),
                                    ),
                                  ),
                                )),
                            Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  onTap: () {
                                    model!.loadMassReading(
                                        DateFormat('yyyyMMdd').format(
                                            DateTime.now()
                                                .add(const Duration(days: 1))));
                                    setState(() {
                                      selectedDate = 'tommorow';
                                    });
                                  },
                                  child: Container(
                                    height: 42,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: selectedDate == 'tommorow'
                                          ? const Color.fromRGBO(12, 72, 224, 1)
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      'Tommorow',
                                      style: selectedDate == 'tommorow'
                                          ? const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.1,
                                              color: Color.fromRGBO(
                                                  237, 241, 253, 1),
                                            )
                                          : const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.1,
                                              color: Color.fromRGBO(
                                                  79, 95, 135, 1),
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
                                    model!.loadMassReading(
                                        DateFormat('yyyyMMdd').format(
                                            DateTime.now().subtract(
                                                const Duration(days: 1))));
                                    setState(() {
                                      selectedDate = 'yesterday';
                                    });
                                  },
                                  child: Text(
                                    DateFormat('d MMM').format(DateTime.now()
                                        .subtract(const Duration(days: 1))),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selectedDate == 'yesterday'
                                          ? const Color.fromRGBO(12, 72, 224, 1)
                                          : const Color.fromRGBO(
                                              4, 26, 82, 0.5),
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
                                    model!.loadMassReading(
                                        DateFormat('yyyyMMdd').format(
                                            DateTime.now()
                                                .add(const Duration(days: 1))));
                                    setState(() {
                                      selectedDate = 'tommorow';
                                    });
                                  },
                                  child: Text(
                                    DateFormat('d MMM').format(DateTime.now()
                                        .add(const Duration(days: 1))),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: selectedDate == 'tommorow'
                                          ? const Color.fromRGBO(12, 72, 224, 1)
                                          : const Color.fromRGBO(
                                              4, 26, 82, 0.5),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.5),
                  Html(
                    data: widget.model?.massReadingItem!['day'],
                    style: {
                      'b': Style(
                        color: const Color.fromRGBO(4, 26, 82, 1),
                        fontSize: FontSize(18),
                      ),
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DefaultTabController(
                          length: widget.model?.massReadingList?.length ?? 0,
                          child: TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            indicatorColor:
                                const Color.fromRGBO(12, 72, 224, 1),
                            labelColor: const Color.fromRGBO(12, 72, 224, 1),
                            unselectedLabelColor:
                                const Color.fromRGBO(4, 26, 82, 1),
                            tabs: tabWidgets,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                      child: ListView.builder(
                    controller: _scrollController,
                    itemCount: widget.model?.massReadingList?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map? data = widget.model?.massReadingList![index] as Map?;
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
                          title = 'Gospel Acclaimation';
                          break;
                        case 'Mass_G':
                          title = 'Gospel';
                          break;
                        default:
                          title = 'First Reading';
                      }

                      return Container(
                          key: _itemKeys[index],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromRGBO(8, 51, 158, 1),
                                  )),
                              data![key]['heading'] != null
                                  ? Text(
                                      '${data[key]['heading']} - ${data[key]['source']}',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromRGBO(4, 26, 82, 1),
                                      ),
                                    )
                                  : Text('${data[key]['source']}'),
                              Html(data: data[key]['text'], style: {
                                'body': Style(
                                  color: const Color.fromRGBO(4, 26, 82, 1),
                                  fontSize: FontSize(16),
                                ),
                              }),
                            ],
                          ));
                    },
                  )),
                ],
              ),
      ),
    );
  }
}
