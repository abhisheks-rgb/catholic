import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter/services.dart';

import '../models/event_register_model.dart';
import '../../../../utils/date_picker.dart';

class EventRegisterFormView extends BaseStatefulPageView {
  final EventRegisterModel? model;

  EventRegisterFormView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _EventRegisterFormViewState();
}

class _EventRegisterFormViewState extends State<EventRegisterFormView> {
  Map<String, dynamic> fieldValues = {};
  Map<String, TextEditingController> textEditingControllerMap = {};

  @override
  void initState() {
    super.initState();

    initializeFieldValues();

    initializeTextEditingControllers();
  }

  void initializeFieldValues() {
    for (var field in widget.model?.item!['eventFormContent']) {
      if (field['element'] == 'RadioButtons') {
        fieldValues[field['field_name']] = '';
      } else if (field['element'] == 'Checkboxes') {
        fieldValues[field['field_name']] = [];
      } else if (field['element'] == 'Dropdown') {
        fieldValues[field['field_name']] = field['options'][0]['value'];
      } else if (field['element'] == 'DatePicker') {
        fieldValues[field['field_name']] = DateTime.now();
      }
    }
  }

  void initializeTextEditingControllers() {
    for (var field in widget.model?.item!['eventFormContent']) {
      if (field['element'] == 'DatePicker') {
        textEditingControllerMap[field['field_name']] = TextEditingController();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children:
            widget.model?.item!['eventFormContent'].map<Widget>((element) {
          return Column(
            children: [
              _renderFormField(element),
              const SizedBox(height: 8),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _renderFormField(element) {
    switch (element['element']) {
      case 'NumberInput':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element['label'] ?? '',
              style: const TextStyle(
                color: Color.fromRGBO(4, 26, 82, 0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            TextFormField(
              // controller: // TextEditingController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: element['hintText'] ?? '',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                  fontSize: 16,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  // || !element['regex'].hasMatch(value)
                  return element['error'] ?? '';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });
                widget.model?.setFormObj(fieldValues);
              },
            ),
          ],
        );
      case 'Dropdown':
        return Container(
          margin: const EdgeInsets.only(top: 8),
          child: DropdownButtonFormField<String>(
            key: Key(element['id']),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              labelStyle: const TextStyle(
                color: Color.fromRGBO(4, 26, 82, 0.5),
                fontSize: 16,
              ),
              labelText: element['label'],
              // floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
            icon: const Icon(
              SimpleLineIcons.arrow_down,
              size: 10,
              color: Color.fromRGBO(4, 26, 82, 0.5),
            ),
            isExpanded: false,
            onChanged: (value) {
              setState(() {
                fieldValues[element['field_name']] = value;
              });
              widget.model?.setFormObj(fieldValues);
            },
            value: fieldValues[element['field_name']],
            items: element['options']
                .map<DropdownMenuItem<String>>((dynamic optionItem) {
              return DropdownMenuItem<String>(
                value: optionItem['value'],
                key: Key(optionItem['key']),
                child: Text(optionItem['text']),
              );
            }).toList(),
          ),
        );
      case 'TextArea':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element['label'] ?? '',
              style: const TextStyle(
                color: Color.fromRGBO(4, 26, 82, 0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            TextFormField(
              // controller: // TextEditingController,
              obscureText: false,
              minLines: 2,
              maxLines: null,
              decoration: InputDecoration(
                hintText: element['hintText'] ?? '',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                  fontSize: 16,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  // || !element['regex'].hasMatch(value)
                  return element['error'] ?? '';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });
                widget.model?.setFormObj(fieldValues);
              },
            ),
          ],
        );
      case 'TextInput':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element['label'] ?? '',
              style: const TextStyle(
                color: Color.fromRGBO(4, 26, 82, 0.5),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            TextFormField(
              // controller: // TextEditingController,
              obscureText: false,
              decoration: InputDecoration(
                hintText: element['hintText'] ?? '',
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                  fontSize: 16,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  // || !element['regex'].hasMatch(value)
                  return element['error'] ?? '';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });
                widget.model?.setFormObj(fieldValues);
              },
            ),
          ],
        );
      case 'RadioButtons':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element['label'] ?? '',
              style: const TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(4, 26, 82, 1),
                letterSpacing: 0.1,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: element['options'].length,
              itemBuilder: (BuildContext context, int index) {
                String option = element['options'][index]['text'];
                return RadioListTile(
                  activeColor: const Color.fromRGBO(12, 72, 224, 1),
                  contentPadding: const EdgeInsets.all(1),
                  title: Text(option,
                      style: const TextStyle(
                        color: Color.fromRGBO(4, 26, 82, 1),
                      )),
                  visualDensity: VisualDensity.compact,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: element['options'][index]['value'],
                  groupValue: fieldValues[element['field_name']],
                  onChanged: (value) {
                    setState(() {
                      fieldValues[element['field_name']] = value;
                    });
                    widget.model?.setFormObj(fieldValues);
                  },
                );
              },
            ),
          ],
        );
      case 'Checkboxes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              element['label'] ?? '',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: element['options'].length,
              itemBuilder: (BuildContext context, int index) {
                String option = element['options'][index]['text'];
                return CheckboxListTile(
                  // checkColor: const Color.fromRGBO(12, 72, 224, 1),
                  activeColor: const Color.fromRGBO(12, 72, 224, 1),
                  contentPadding: const EdgeInsets.all(1),
                  title: Text(option,
                      style: const TextStyle(
                        color: Color.fromRGBO(4, 26, 82, 1),
                      )),
                  visualDensity: VisualDensity.compact,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: fieldValues[element['field_name']]
                          .contains(element['options'][index]['value']) ??
                      false,
                  onChanged: (bool? value) {
                    setState(() {
                      fieldValues[element['field_name']]
                          .add(element['options'][index]['value']);
                    });
                    widget.model?.setFormObj(fieldValues);
                  },
                );
              },
            ),
          ],
        );
      case 'DatePicker':
        return Container(
          margin: const EdgeInsets.only(top: 8),
          child: DatePicker(
            controller: textEditingControllerMap[element['field_name']],
            label: element['label'] ?? '',
            onSelected: (value) => setState(() {
              setState(() {
                fieldValues[element['field_name']] = value;
              });

              widget.model?.setFormObj(fieldValues);
            }),
            firstDate: DateTime(1900),
            route: ModalRoute.of(context)?.settings.name,
          ),
        );
      default:
        return Text(
          element['content'] ?? '',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20,
            fontStyle: element['italic'] ?? false
                ? FontStyle.italic
                : FontStyle.normal,
            fontWeight:
                element['bold'] ?? false ? FontWeight.bold : FontWeight.normal,
          ),
        );
    }
  }
}
