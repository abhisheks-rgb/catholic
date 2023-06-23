import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../models/my_event_model.dart';

class MyEventsView extends BaseStatefulPageView {
  final MyEventModel? model;
  final List<Map> _items;
  final List<Map> _bookingItems;

  MyEventsView(this.model, {Key? key})
      : _items = List.generate(model?.events?.length ?? 0,
                (index) => model?.events![index] as Map)
            .where((item) => item['hasLiked'] == true)
            .toList()
          ..sort((a, b) =>
              b['startDate']['_seconds'].compareTo(a['startDate']['_seconds'])),
        _bookingItems = List.generate(model?.bookings?.length ?? 0,
            (index) => model?.bookings![index] as Map)
          ..sort((a, b) => b['startDateTime'].compareTo(a['startDateTime'])),
        super();

  @override
  State<BaseStatefulPageView> createState() => _EventsViewState();
}

class _EventsViewState extends State<MyEventsView>
    with TickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 252, 245, 1),
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(54, 8, 54, 8),
                width: double.infinity,
                child: TabBar(
                  controller: _controller,
                  labelColor: const Color.fromRGBO(12, 72, 224, 1),
                  labelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
                  unselectedLabelColor: const Color.fromRGBO(4, 26, 82, 0.7),
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.1,
                  ),
                  tabs: const [
                    Tab(
                      child: Text(
                        'Interested',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Booked',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                  indicator: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Color.fromRGBO(12, 72, 224, 1),
                        width: 2.0,
                      ),
                    ),
                  ),
                  onTap: (index) async {
                    if (index == 1) {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'app_events_view_booked',
                      );
                    } else {
                      await FirebaseAnalytics.instance.logEvent(
                        name: 'app_evens_view_interested',
                      );
                    }
                  },
                ),
              ),
              Flexible(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    // ignore: unnecessary_null_comparison
                    widget.model?.loading == true && widget._items != null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: const EdgeInsets.only(top: 20),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        :
                        // ignore: unnecessary_null_comparison
                        widget._items == null
                            ? _renderEmptyEvents()
                            : Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 16, 20, 160),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    children: widget._items.map<Widget>((e) {
                                      return _renderEventItem(e, true);
                                    }).toList(),
                                  ),
                                ),
                              ),
                    widget.model?.loading == true &&
                            // ignore: unnecessary_null_comparison
                            widget._bookingItems != null
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            margin: const EdgeInsets.only(top: 20),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        :
                        // ignore: unnecessary_null_comparison
                        widget._bookingItems == null
                            ? _renderEmptyEvents()
                            : Container(
                                margin:
                                    const EdgeInsets.fromLTRB(20, 16, 20, 160),
                                child: SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    children:
                                        widget._bookingItems.map<Widget>((e) {
                                      return _renderEventItem(e, false);
                                    }).toList(),
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderEmptyEvents() => Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.77,
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Sorry, there are currently no available events',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      );

  Widget _renderEventItem(element, isInterested) {
    DateTime eventDate = element['startDate'] != null
        ? DateTime.fromMillisecondsSinceEpoch(
            element['startDate']['_seconds'] * 1000)
        : DateTime.now();

    if (!isInterested) {
      element['eventDate'] != null
          ? element['eventDate']['seconds'] != null
              ? eventDate = DateTime.fromMillisecondsSinceEpoch(
                  element['eventDate']['seconds'] * 1000)
              : eventDate = DateTime.fromMillisecondsSinceEpoch(
                  element['eventDate']['_seconds'] * 1000)
          : eventDate = DateTime.now();
    }
    String formattedDate = DateFormat('d MMM, hh a').format(eventDate);

    return Column(
      children: [
        RawMaterialButton(
          constraints: const BoxConstraints(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () async {
            await widget.model?.viewEventDetails?.call(element);
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
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
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: 125,
                    height: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Color.fromRGBO(219, 228, 251, 1),
                    ),
                    child: element['eventImageUrl'] != null
                        ? Image.network(
                            element['eventImageUrl'],
                            fit: BoxFit.cover,
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 26),
                        Row(
                          children: [
                            Text(
                              formattedDate,
                              style: const TextStyle(
                                color: Color.fromRGBO(236, 74, 70, 1),
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                color: const Color.fromRGBO(252, 223, 222, 1),
                              ),
                              child: const Text(
                                'RSVP',
                                style: TextStyle(
                                    color: Color.fromRGBO(236, 74, 70, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          element['eventName'],
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        isInterested
                            ? Row(
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Icon(
                                      Octicons.star_fill,
                                      color: element['hasLiked'] == true
                                          ? const Color.fromRGBO(12, 72, 224, 1)
                                          : const Color.fromRGBO(
                                              4, 26, 82, 0.7),
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    element['hasLiked'] == true
                                        ? 'Interested'
                                        : '${element['interested']} interested',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                    ),
                                  ),
                                  const Spacer(),
                                  element['hasBooked'] != null &&
                                          element['hasBooked'] == true
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: Icon(
                                            Ionicons.checkmark_circle,
                                            color:
                                                Color.fromRGBO(0, 205, 82, 1),
                                            size: 16,
                                          ),
                                        )
                                      : const SizedBox(),
                                  element['hasBooked'] != null &&
                                          element['hasBooked'] == true
                                      ? const Text(
                                          'Booked',
                                          style: TextStyle(
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                          ),
                                        )
                                      : const Spacer(),
                                ],
                              )
                            : Row(
                                children: [
                                  element['hasBooked'] != null &&
                                          element['hasBooked'] == true
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: Icon(
                                            Ionicons.checkmark_circle,
                                            color:
                                                Color.fromRGBO(0, 205, 82, 1),
                                            size: 16,
                                          ),
                                        )
                                      : const SizedBox(),
                                  element['hasBooked'] != null &&
                                          element['hasBooked'] == true
                                      ? const Text(
                                          'Booked',
                                          style: TextStyle(
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                          ),
                                        )
                                      : const Spacer(),
                                  const Spacer(),
                                  element['hasLiked'] == true
                                      ? SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: Icon(
                                            Octicons.star_fill,
                                            color: element['hasLiked'] == true
                                                ? const Color.fromRGBO(
                                                    12, 72, 224, 1)
                                                : const Color.fromRGBO(
                                                    4, 26, 82, 0.7),
                                            size: 16,
                                          ),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(width: 4),
                                  element['hasLiked'] == true
                                      ? const Text(
                                          'Interested',
                                          style: TextStyle(
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                          ),
                                        )
                                      : const SizedBox()
                                ],
                              ),
                        const SizedBox(height: 26),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
