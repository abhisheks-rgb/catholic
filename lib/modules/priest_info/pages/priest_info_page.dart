import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

import '../models/priest_info_model.dart';

class PriestInfoPage extends BaseStatefulPageView {
  final PriestInfoModel? model;

  PriestInfoPage({Key? key, this.model}) : super();

  @override
  FutureOr<bool> beforeLoad(BuildContext context) async {
    super.beforeLoad(context);

    model!.loadData();

    return true;
  }

  @override
  Widget build(BuildContext context, {bool loading = false}) =>
      _PriestInfoPage(model!);
}

class _PriestInfoPage extends StatefulWidget {
  final PriestInfoModel model;

  const _PriestInfoPage(this.model);

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _PriestInfoPageState(model);
}

class _PriestInfoPageState extends State<_PriestInfoPage> {
  final PriestInfoModel model;

  bool isLoadingPriest = false;
  String? _selectedPriestValue = "";
  List? _priestsItems;

  _PriestInfoPageState(this.model);

  @override
  void initState() {
    super.initState();

    _selectedPriestValue = "all";
    _getPriests('all');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Priest Info'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(255, 252, 245, 1),
        ),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: widget.model.loading && widget.model.items!.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 64,
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        InputDecorator(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.zero))),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              icon: const Icon(Icons.keyboard_arrow_down),
                              elevation: 16,
                              isDense: true,
                              isExpanded: true,
                              value: _selectedPriestValue,
                              hint: const Text('Select priest'),
                              items: const [
                                DropdownMenuItem<String>(
                                  value: "all",
                                  child: Text("All Priests"),
                                ),
                              ],
                              onChanged: (value) async {
                                if (value == 'all') {
                                  _getPriests('all');
                                }
                                setState(() {
                                  _selectedPriestValue = value.toString();
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  isLoadingPriest
                      ? Container(
                          margin: const EdgeInsets.only(top: 16),
                          child:
                              const Center(child: CircularProgressIndicator()))
                      : Expanded(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: _priestsItems?.length ?? 0,
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 16);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              print(
                                  'dsafadsf ${_priestsItems?[index]} ${_priestsItems?[index]['churchid']}');
                              var priestParish =
                                  widget.model.items?.firstWhere((element) {
                                return element['_id'].toString() ==
                                    _priestsItems?[index]['churchid']
                                        .toString();
                              });

                              return Container(
                                height: 91,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(208, 185, 133, 0.15),
                                      offset: Offset(0, 8),
                                      blurRadius: 16,
                                    ),
                                    BoxShadow(
                                      color:
                                          Color.fromRGBO(208, 185, 133, 0.05),
                                      offset: Offset(0, 4),
                                      blurRadius: 8,
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(20),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      width: 48,
                                      height: 48,
                                      decoration: const BoxDecoration(
                                        color: Color.fromRGBO(219, 228, 251, 1),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          _priestsItems?[index]['name'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          priestParish['name'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xff041a51),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
      ),
    );
  }

  void _getPriests(String selectedType) async {
    setState(() {
      isLoadingPriest = true;
    });
    final result = await FirebaseFunctions.instanceFor(region: 'asia-east2')
        .httpsCallable('priest')
        .call(
      {
        "type": selectedType,
      },
    );

    final response = result.data;

    setState(() {
      isLoadingPriest = false;
      _priestsItems = response['results']['items'] ?? [];
    });
  }
}
