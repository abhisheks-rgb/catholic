// ignore: depend_on_referenced_packages
import 'package:butter_commons/butter_commons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class DatePicker extends StatefulWidget {
  final bool autofocus;
  final TextEditingController? controller;
  final DateTime? firstDate;
  final DateTime? initialDate;
  final DatePickerMode initialDatePickerMode;
  final DatePickerEntryMode initialEntryMode;
  final String? label;
  final DateTime? lastDate;
  final DatePickerViewType viewType;
  final void Function(DateTime value) onSelected;
  final String? route;

  const DatePicker({
    Key? key,
    this.autofocus = false,
    this.controller,
    this.firstDate,
    this.initialDate,
    this.initialDatePickerMode = DatePickerMode.day,
    this.initialEntryMode = DatePickerEntryMode.calendar,
    this.lastDate,
    this.label,
    this.viewType = DatePickerViewType.date,
    required this.onSelected,
    this.route,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DatePickerState();

  static String formatValue(DatePickerViewType viewType, DateTime value) {
    switch (viewType) {
      case DatePickerViewType.dateTime:
        return Formats.getDateTime(value);
      case DatePickerViewType.time:
        return Formats.getTime(value);
      case DatePickerViewType.date:
      default:
        return Formats.getDate(value);
    }
  }
}

class _DatePickerState extends State<DatePicker> {
  @override
  void initState() {
    super.initState();

    widget.controller?.text = widget.controller!.text.isEmpty
        ? DatePicker.formatValue(widget.viewType, DateTime.now())
        : widget.controller!.text;
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        autofocus: widget.autofocus,
        controller: widget.controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(4, 26, 82, 0.5)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromRGBO(4, 26, 82, 0.5)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          labelStyle: const TextStyle(
            color: Color.fromRGBO(4, 26, 82, 0.5),
            fontSize: 16,
          ),
          labelText: widget.label,
          suffixIcon: const Icon(MaterialIcons.calendar_today),
        ),
        readOnly: true,
        style: const TextStyle(fontSize: 14),
        onTap: _onTap,
      );

  void _onTap() async {
    var value = DateTime.now();

    if (widget.viewType == DatePickerViewType.dateTime ||
        widget.viewType == DatePickerViewType.date) {
      value = await showDatePicker(
            context: context,
            firstDate: widget.firstDate ?? value,
            initialDate: widget.initialDate ?? value,
            initialDatePickerMode: widget.initialDatePickerMode,
            initialEntryMode: widget.initialEntryMode,
            lastDate: widget.lastDate ??
                DateTime.now().add(const Duration(days: 365)),
            useRootNavigator: false,
            routeSettings:
                widget.route == null ? null : RouteSettings(name: widget.route),
          ) ??
          value;
    }

    if (context.mounted &&
        (widget.viewType == DatePickerViewType.dateTime ||
            widget.viewType == DatePickerViewType.time)) {
      final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            useRootNavigator: false,
            routeSettings:
                widget.route == null ? null : RouteSettings(name: widget.route),
          ) ??
          TimeOfDay.fromDateTime(value);

      value =
          DateTime(value.year, value.month, value.day, time.hour, time.minute);
    }

    widget.controller?.text = DatePicker.formatValue(widget.viewType, value);
    widget.onSelected.call(value);
  }
}

enum DatePickerViewType {
  date,
  dateTime,
  time,
}
