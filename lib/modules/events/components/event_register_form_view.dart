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
  Map<dynamic, dynamic> fieldValues = {};
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

    widget.model?.setFormObj(fieldValues);
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
            Row(
              children: [
                Text(
                  '${element['label']}',
                  style: const TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color.fromRGBO(233, 40, 35, 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                  borderSide: BorderSide(
                    color: widget.model?.formErrorObj != null &&
                            widget.model
                                    ?.formErrorObj![element['field_name']] !=
                                null
                        ? const Color.fromRGBO(241, 119, 116, 1)
                        : const Color.fromRGBO(4, 26, 82, 0.5),
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
              onChanged: (value) async {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });
                widget.model?.setFormObj(fieldValues);
                Map? newErrorObj = widget.model?.formErrorObj;

                if (newErrorObj != null &&
                    newErrorObj[element['field_name']] != null) {
                  newErrorObj.remove(element['field_name']);
                }

                await widget.model?.setFormErrorObj!(newErrorObj);
              },
            ),
            const SizedBox(height: 4),
            widget.model?.formErrorObj != null &&
                    widget.model?.formErrorObj![element['field_name']] != null
                ? Text(
                    widget.model?.formErrorObj![element['field_name']] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(233, 40, 35, 1),
                    ),
                  )
                : const SizedBox(),
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
            Row(
              children: [
                Text(
                  '${element['label']}',
                  style: const TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color.fromRGBO(233, 40, 35, 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                  borderSide: BorderSide(
                    color: widget.model?.formErrorObj != null &&
                            widget.model
                                    ?.formErrorObj![element['field_name']] !=
                                null
                        ? const Color.fromRGBO(241, 119, 116, 1)
                        : const Color.fromRGBO(4, 26, 82, 0.5),
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
                Map? newErrorObj = widget.model?.formErrorObj;

                if (newErrorObj != null &&
                    newErrorObj[element['field_name']] != null) {
                  newErrorObj.remove(element['field_name']);
                }

                widget.model?.setFormErrorObj!(newErrorObj);
              },
            ),
            const SizedBox(height: 4),
            widget.model?.formErrorObj != null &&
                    widget.model?.formErrorObj![element['field_name']] != null
                ? Text(
                    widget.model?.formErrorObj![element['field_name']] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(233, 40, 35, 1),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      case 'TextInput':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${element['label']}',
                  style: const TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color.fromRGBO(233, 40, 35, 0.4),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                  borderSide: BorderSide(
                    color: widget.model?.formErrorObj != null &&
                            widget.model
                                    ?.formErrorObj![element['field_name']] !=
                                null
                        ? const Color.fromRGBO(241, 119, 116, 1)
                        : const Color.fromRGBO(4, 26, 82, 0.5),
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) async {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });

                await widget.model?.setFormObj(fieldValues);
                Map? newErrorObj = widget.model?.formErrorObj;

                if (newErrorObj != null &&
                    newErrorObj[element['field_name']] != null) {
                  newErrorObj.remove(element['field_name']);
                }

                widget.model?.setFormErrorObj!(newErrorObj);
              },
            ),
            const SizedBox(height: 4),
            widget.model?.formErrorObj != null &&
                    widget.model?.formErrorObj![element['field_name']] != null
                ? Text(
                    widget.model?.formErrorObj![element['field_name']] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(233, 40, 35, 1),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      case 'RadioButtons':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${element['label']}',
                  style: const TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color.fromRGBO(233, 40, 35, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                    Map? newErrorObj = widget.model?.formErrorObj;

                    setState(() {
                      fieldValues[element['field_name']] = value;
                    });

                    if (newErrorObj != null &&
                        newErrorObj[element['field_name']] != null) {
                      newErrorObj.remove(element['field_name']);
                    }

                    widget.model?.setFormObj(fieldValues);
                    widget.model?.setFormErrorObj!(newErrorObj);
                  },
                );
              },
            ),
            const SizedBox(height: 4),
            widget.model?.formErrorObj != null &&
                    widget.model?.formErrorObj![element['field_name']] != null
                ? Text(
                    widget.model?.formErrorObj![element['field_name']] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(233, 40, 35, 1),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      case 'Checkboxes':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '${element['label']}',
                  style: const TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  '*',
                  style: TextStyle(
                    color: Color.fromRGBO(233, 40, 35, 1),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
                  value: fieldValues[element['field_name']] != null
                      ? fieldValues[element['field_name']]
                              .contains(element['options'][index]['value']) ??
                          false
                      : false,
                  onChanged: (bool? value) async {
                    Map? newErrorObj = widget.model?.formErrorObj;

                    if (newErrorObj != null &&
                        newErrorObj[element['field_name']] != null) {
                      newErrorObj.remove(element['field_name']);
                    }

                    setState(() {
                      if (value!) {
                        fieldValues[element['field_name']]
                            .add(element['options'][index]['value']);
                      } else {
                        fieldValues[element['field_name']]
                            .remove(element['options'][index]['value']);
                      }
                    });

                    widget.model?.setFormObj(fieldValues);

                    widget.model?.setFormErrorObj!(newErrorObj);
                  },
                );
              },
            ),
            const SizedBox(height: 4),
            widget.model?.formErrorObj != null &&
                    widget.model?.formErrorObj![element['field_name']] != null
                ? Text(
                    widget.model?.formErrorObj![element['field_name']] ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(233, 40, 35, 1),
                    ),
                  )
                : const SizedBox(),
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
