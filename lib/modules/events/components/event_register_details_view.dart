import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/event_register_model.dart';

class EventRegisterDetailsView extends BaseStatefulPageView {
  final EventRegisterModel? model;

  EventRegisterDetailsView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _EventRegisterDetailsViewState();
}

class _EventRegisterDetailsViewState extends State<EventRegisterDetailsView> {
  @override
  void dispose() {
    widget.model?.resetBookingForm!();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(255, 255, 255, 1),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(235, 235, 235, 1),
                  blurRadius: 15,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.model?.item!['eventName'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        FontAwesome5Solid.calendar,
                        color: Color.fromRGBO(4, 26, 82, 0.5),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Start: ${_dateEventFormat(widget.model?.item!['startDate'])}',
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'End: ${_dateEventFormat(widget.model?.item!['endDate'])}',
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        MaterialCommunityIcons.map_marker,
                        color: Color.fromRGBO(4, 26, 82, 0.5),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${widget.model?.item!['eventVenue']}',
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(255, 255, 255, 1),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color.fromRGBO(235, 235, 235, 1),
                  blurRadius: 15,
                  offset: Offset(0.0, 0.75),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Form Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ...widget.model?.item!['eventFormContent']
                    .map<Widget>((element) {
                  return Column(
                    children: [
                      _renderFormField(element),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderFormField(element) {
    if (element['element'] == 'DatePicker') {
      return Text(
        '${element['label']}: ${DateFormat('d MMM y').format(widget.model?.formObj![element['field_name']])}',
        style: const TextStyle(
          color: Color.fromRGBO(4, 26, 82, 1),
          fontSize: 16,
        ),
      );
    } else if (element['element'] == 'RadioButtons' ||
        element['element'] == 'Dropdown') {
      return Text(
        '${element['label']}: ${_getRadioButtonValue(element['options'], widget.model?.formObj![element['field_name']])}',
        style: const TextStyle(
          color: Color.fromRGBO(4, 26, 82, 1),
          fontSize: 16,
        ),
      );
    } else if (element['element'] == 'Checkboxes') {
      return Text(
        '${element['label']}: ${_getCheckBoxValue(element['options'], widget.model?.formObj![element['field_name']])}',
        style: const TextStyle(
          color: Color.fromRGBO(4, 26, 82, 1),
          fontSize: 16,
        ),
      );
    } else if (element['element'] != 'Header' &&
        element['element'] != 'Paragraph') {
      return Text(
        '${element['label']}: ${widget.model?.formObj![element['field_name']] ?? ''}',
        style: const TextStyle(
          color: Color.fromRGBO(4, 26, 82, 1),
          fontSize: 16,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  String _getRadioButtonValue(options, selectedValue) {
    Map? record = options.firstWhere(
        (option) => option['value'] == selectedValue,
        orElse: () => {'text': ''});

    return record!['text'];
  }

  String _getCheckBoxValue(optionsList, selectedValue) {
    List options = optionsList;
    List itemsToMatch = selectedValue;
    List matchingRecords = options
        .where((option) => itemsToMatch.contains(option['value']))
        .toList();

    return matchingRecords.map((record) => record['text']).toList().join(', ');
  }

  String _dateEventFormat(dateEvent) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(dateEvent['_seconds'] * 1000);
    String formattedDate = DateFormat('E, d MMM yy - h:mma').format(date);

    return formattedDate;
  }
}
