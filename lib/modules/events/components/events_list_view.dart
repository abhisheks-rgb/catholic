import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/events_list_model.dart';
import '../../../utils/asset_path.dart';

class EventsListView extends BaseStatefulPageView {
  final EventsListModel? model;
  final List<Map> _items;

  EventsListView(this.model, {Key? key})
      : _items = List.generate(model?.events?.length ?? 0,
            (index) => model?.events![index] as Map),
        super();

  @override
  State<BaseStatefulPageView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsListView> {
  String? _selectedEventType;
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
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
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
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _eventTypes?.length ?? 0,
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 8,
                      ),
                      itemBuilder: (BuildContext context, int index) =>
                          _renderEventTypes(context, index),
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
                                  'Login Now',
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
                  widget.model?.loading == true && widget._items != null
                      ? Container(
                          height: MediaQuery.of(context).size.height * 0.3,
                          margin: const EdgeInsets.only(top: 20),
                          child:
                              const Center(child: CircularProgressIndicator()),
                        )
                      :
                      // ignore: unnecessary_null_comparison
                      widget._items == null
                          ? _renderEmptyEvents()
                          : Column(
                              children: widget._items.map<Widget>((e) {
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
        element['bookingStartDate']['_seconds'] * 1000);
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
                    child: Image.network(
                      element['eventImageUrl'],
                      fit: BoxFit.cover,
                    ),
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
                        Row(
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Octicons.star_fill,
                                color: Color.fromRGBO(4, 26, 82, 0.7),
                                // color: isSelected
                                //     ? Colors.white
                                //     : const Color.fromRGBO(4, 26, 82, 0.7),
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${element['interested']} interested',
                              style: const TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
                              ),
                            ),
                            const Spacer(),
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
