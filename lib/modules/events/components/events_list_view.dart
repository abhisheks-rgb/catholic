import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/events_list_model.dart';
import '../../../utils/asset_path.dart';

class EventsListView extends BaseStatefulPageView {
  final EventsListModel? model;
  final List<Map> _items;
  final List<Map> _interestedItems;

  EventsListView(this.model, {Key? key})
      : _items = List.generate(model?.events?.length ?? 0,
            (index) => model?.events![index] as Map),
        _interestedItems = List.generate(model?.interestedEvents?.length ?? 0,
            (index) => model?.interestedEvents![index] as Map)
          ..sort((a, b) =>
              b['startDate']['_seconds'].compareTo(a['startDate']['_seconds'])),
        super();

  @override
  State<BaseStatefulPageView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsListView> {
  String? _selectedEventType;
  String? _searchEvent = '';
  List? _eventTypes;

  @override
  @override
  void initState() {
    super.initState();
    _selectedEventType = 'All Types';
    _eventTypes = [
      'All Types',
      'Favorites',
      'Walk-In Only',
      'RSVP',
    ];
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
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    assetPath('events-bg.jpg'),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
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
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 252, 245, 0.5),
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search Event',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(4, 26, 82, 0.5),
                        fontSize: 16,
                      ),
                      suffixIcon: SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          FontAwesome.search,
                          color: Color.fromRGBO(4, 26, 82, 1),
                          size: 20,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchEvent = value;
                      });
                    },
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _eventTypes?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        width: (index == 1 && widget.model?.isLoggedIn == false)
                            ? 0
                            : 8,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == 1 && widget.model?.isLoggedIn == false) {
                          return const SizedBox.shrink();
                        } else {
                          return _renderEventTypes(context, index);
                        }
                      },
                    ),
                  ),
                  widget.model?.isLoggedIn == true
                      ? Container()
                      : RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: const CircleBorder(),
                          onPressed: () {
                            widget.model?.showPage('/_/login');
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(255, 244, 219, 1),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Color.fromRGBO(235, 235, 235, 1),
                                  blurRadius: 15,
                                  offset: Offset(0.0, 0.75),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Log in Now',
                                  style: TextStyle(
                                    color: Color.fromRGBO(99, 69, 4, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'to make full use of the App!',
                                  style: TextStyle(
                                    color: Color.fromRGBO(99, 69, 4, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  widget.model?.isLoggedIn == true
                      ? Container()
                      : const SizedBox(height: 16),
                  // ignore: unnecessary_null_comparison
                  widget.model?.loading == true
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: const EdgeInsets.only(top: 20),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      : _selectedEventType == 'Favorites'
                          ?
                          // ignore: unnecessary_null_comparison
                          widget._interestedItems.isEmpty
                              ? _renderEmptyEvents()
                              : Column(
                                  children:
                                      widget._interestedItems.where((element) {
                                    bool containsSearchText = true;
                                    if (_searchEvent != null) {
                                      containsSearchText =
                                          (element['eventName'].toString())
                                              .toLowerCase()
                                              .contains(_searchEvent!
                                                  .toLowerCase()
                                                  .trim());
                                    }

                                    return true && containsSearchText;
                                  }).map<Widget>((e) {
                                    return _renderEventItem(e);
                                  }).toList(),
                                )
                          :
                          // ignore: unnecessary_null_comparison
                          widget._items.where((element) {
                              if (_selectedEventType == 'Walk-In Only') {
                                return element['isWalkIn'] == true;
                              } else if (_selectedEventType == 'RSVP') {
                                return element['isWalkIn'] == false;
                              }

                              return true;
                            }).isEmpty
                              ? _renderEmptyEvents()
                              : Column(
                                  children: widget._items.where((element) {
                                    bool containsSearchText = true;
                                    if (_searchEvent != null) {
                                      containsSearchText =
                                          (element['eventName'].toString())
                                              .toLowerCase()
                                              .contains(_searchEvent!
                                                  .toLowerCase()
                                                  .trim());
                                    }

                                    if (_selectedEventType == 'Walk-In Only') {
                                      return element['isWalkIn'] == true &&
                                          containsSearchText;
                                    } else if (_selectedEventType == 'RSVP') {
                                      return element['isWalkIn'] == false &&
                                          containsSearchText;
                                    }

                                    return true && containsSearchText;
                                  }).map<Widget>((e) {
                                    return _renderEventItem(e);
                                  }).toList(),
                                ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderEmptyEvents() => Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
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

  _renderEventTypes(BuildContext context, int index) {
    bool isSelected = _eventTypes?[index] == _selectedEventType;

    return RawMaterialButton(
      constraints: const BoxConstraints(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      onPressed: () async {
        if (_eventTypes?[index] != _selectedEventType) {
          setState(() {
            _selectedEventType = _eventTypes?[index];
          });

          if (_eventTypes?[index] == 'Favorites') {
            widget.model!.loadInterestedEvents();
          }
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: isSelected ? const Color.fromRGBO(4, 26, 82, 1) : Colors.white,
        ),
        child: Align(
          alignment: Alignment.center,
          child: _eventTypes?[index] == 'Favorites'
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: Icon(
                    Octicons.star_fill,
                    color: isSelected
                        ? Colors.white
                        : const Color.fromRGBO(4, 26, 82, 0.7),
                    size: 20,
                  ),
                )
              : Text(
                  _eventTypes?[index],
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : const Color.fromRGBO(4, 26, 82, 0.7),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _renderEventItem(element) {
    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(
        element['startDate']['_seconds'] * 1000);
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
                    height: 125,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      color: Color.fromRGBO(219, 228, 251, 1),
                    ),
                    child: Image.network(
                      element['eventImageUrl'],
                      fit: BoxFit.cover,
                      width: 125,
                      height: 125,
                    ),
                  ),
                  const SizedBox(width: 14),
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
                            element['isWalkIn'] == false
                                ? Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(32),
                                      color: const Color.fromRGBO(
                                          252, 223, 222, 1),
                                    ),
                                    child: const Text(
                                      'RSVP',
                                      style: TextStyle(
                                          color: Color.fromRGBO(236, 74, 70, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12),
                                    ),
                                  )
                                : const SizedBox(),
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
                        Row(
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: Icon(
                                Octicons.star_fill,
                                color: element['hasLiked'] == true
                                    ? const Color.fromRGBO(12, 72, 224, 1)
                                    : const Color.fromRGBO(4, 26, 82, 0.7),
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
                                      color: Color.fromRGBO(0, 205, 82, 1),
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
