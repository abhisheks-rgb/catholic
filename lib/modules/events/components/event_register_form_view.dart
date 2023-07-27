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
        fieldValues[field['field_name']] = field['options'][0]['text'];
      } else if (field['element'] == 'DatePicker') {
        fieldValues[field['field_name']] = DateTime.now();
      } else if (field['element'] == 'NumberInput' ||
          field['element'] == 'TextArea' ||
          field['element'] == 'TextInput') {
        fieldValues[field['field_name']] = '';
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
                element['required'] == true
                    ? const Text(
                        '*',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 40, 35, 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
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
              onChanged: (value) async {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });
                await widget.model?.setFormObj(fieldValues);
                Map? newErrorObj = widget.model?.formErrorObj;

                if (newErrorObj != null &&
                    newErrorObj[element['field_name']] != null) {
                  newErrorObj.remove(element['field_name']);

                  await widget.model?.setFormErrorObj!(newErrorObj);
                }
              },
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${element['label']}',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                element['required'] == true
                    ? const Text(
                        '*',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 40, 35, 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            const SizedBox(height: 4),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color.fromRGBO(4, 26, 82, 0.5)),
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
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      showAlert(context, element);
                    },
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                fieldValues[element['field_name']],
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: Icon(
                                Entypo.chevron_down,
                                color: Color.fromRGBO(4, 26, 82, 1),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 'TextArea':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${element['label']}',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                element['required'] == true
                    ? const Text(
                        '*',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 40, 35, 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
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
              onChanged: (value) async {
                setState(() {
                  fieldValues[element['field_name']] = value;
                });
                await widget.model?.setFormObj(fieldValues);
                Map? newErrorObj = widget.model?.formErrorObj;

                if (newErrorObj != null &&
                    newErrorObj[element['field_name']] != null) {
                  newErrorObj.remove(element['field_name']);

                  await widget.model?.setFormErrorObj!(newErrorObj);
                }
              },
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
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
                Expanded(
                  child: Text(
                    '${element['label']}',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 0.5),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                element['required'] == true
                    ? const Text(
                        '*',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 40, 35, 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
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

                  await widget.model?.setFormErrorObj!(newErrorObj);
                }
              },
              onTapOutside: (_) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
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
                Expanded(
                  child: Text(
                    '${element['label']}',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                element['required'] == true
                    ? const Text(
                        '*',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 40, 35, 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
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
                  value: element['options'][index]['text'],
                  groupValue: fieldValues[element['field_name']],
                  onChanged: (value) async {
                    Map? newErrorObj = widget.model?.formErrorObj;

                    setState(() {
                      fieldValues[element['field_name']] = value;
                    });

                    await widget.model?.setFormObj(fieldValues);

                    if (newErrorObj != null &&
                        newErrorObj[element['field_name']] != null) {
                      newErrorObj.remove(element['field_name']);

                      await widget.model?.setFormErrorObj!(newErrorObj);
                    }
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
                Expanded(
                  child: Text(
                    '${element['label']}',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                element['required'] == true
                    ? const Text(
                        '*',
                        style: TextStyle(
                          color: Color.fromRGBO(233, 40, 35, 0.4),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    : const SizedBox(),
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
                              .contains(element['options'][index]['text']) ??
                          false
                      : false,
                  onChanged: (bool? value) async {
                    setState(() {
                      if (value!) {
                        fieldValues[element['field_name']]
                            .add(element['options'][index]['text']);
                      } else {
                        fieldValues[element['field_name']]
                            .remove(element['options'][index]['text']);
                      }
                    });

                    await widget.model?.setFormObj(fieldValues);

                    Map? newErrorObj = widget.model?.formErrorObj;

                    if (newErrorObj != null &&
                        newErrorObj[element['field_name']] != null) {
                      newErrorObj.remove(element['field_name']);

                      await widget.model?.setFormErrorObj!(newErrorObj);
                    }
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

  void showAlert(BuildContext context, element) {
    showDialog(
        context: context,
        routeSettings:
            RouteSettings(name: ModalRoute.of(context)?.settings.name),
        builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              contentPadding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              title: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          element['label'],
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        shape: const CircleBorder(),
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: Icon(
                            MaterialCommunityIcons.close_circle,
                            color: Color.fromRGBO(130, 141, 168, 1),
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              content: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                  maxHeight: 600,
                ),
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: element['options'].length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 36),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              element['options'][index]['text'],
                              style: const TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
                                fontSize: 16,
                              ),
                            ),
                            index == element['options'].length - 1
                                ? Container()
                                : Column(
                                    children: const [
                                      SizedBox(height: 20),
                                      Divider(
                                        height: 1,
                                        thickness: 1,
                                        indent: 0,
                                        endIndent: 0,
                                        color: Color.fromRGBO(4, 26, 82, 0.1),
                                      ),
                                    ],
                                  ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      onTap: () async {
                        setState(() {
                          fieldValues[element['field_name']] =
                              element['options'][index]['text'];
                        });
                        await widget.model?.setFormObj(fieldValues);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ));
  }
}
