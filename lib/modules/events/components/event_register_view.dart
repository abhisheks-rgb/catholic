import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/event_register_model.dart';

class EventRegisterView extends BaseStatefulPageView {
  final EventRegisterModel? model;

  EventRegisterView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _EventRegisterViewState();
}

class _EventRegisterViewState extends State<EventRegisterView> {
  final formKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> items = [
    {
      'label': 'FULL NAME',
      'hintText': 'Your Name',
      'error': 'Enter your name',
      'regex': RegExp(r''),
    },
    {
      'label': 'AGE',
      'hintText': '0',
      'error': 'Enter your age',
      'regex': RegExp(r''),
    },
    {
      'label': 'DYNAMIC FIELD',
      'hintText': 'Field hint',
      'error': 'Enter',
      'regex': RegExp(r''),
    },
    {
      'label': 'DYNAMIC FIELD',
      'hintText': 'Field Hint',
      'error': 'Enter',
      'regex': RegExp(r''),
    },
  ];
  // String? _error;

  @override
  void dispose() {
    super.dispose();
    delayedReset();
  }

  void delayedReset() async {
    await widget.model!.setIsEventRegister(isEventRegister: false);
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
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: items.map<Widget>((element) {
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                              // onChanged: (_) => setState(() => _error = null),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
