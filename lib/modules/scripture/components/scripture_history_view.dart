import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/scripture_history_model.dart';

class ScriptureHistoryView extends BaseStatelessPageView {
  final ScriptureHistoryModel? model;
  final List<Map> _items;

  ScriptureHistoryView(this.model, {Key? key})
      : _items = List.generate(
            model?.items?.length ?? 0, (index) => model?.items![index] as Map),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'View History',
          style: TextStyle(
            color: Color.fromRGBO(4, 26, 82, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        elevation: 0,
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
      body: model?.loading == true
        ? Container(
            height: MediaQuery.of(context).size.height * 0.74,
            margin: const EdgeInsets.only(top: 16),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        :
      SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 252, 245, 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                model?.authorName ?? '---',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                )
              ),
              const SizedBox(height: 4),
              Text(
                'Reflection & Homilies - ${_items.length}',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                  fontSize: 14,
                )
              ),
              const SizedBox(height: 16),
              Column(
                children: _items.map<Widget>((element) {
                  final published = DateFormat('E, d MMM yyyy').format(
                    DateTime.parse(
                      element['published'],
                    ),
                  );
                  return Column(
                    children: [
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () async {
                          await model?.viewScriptureDetails?.call(element);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color.fromRGBO(235, 235, 235, 1),
                                blurRadius: 15,
                                offset: Offset(0.0, 0.75),
                              ),
                            ],
                            color: Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:  [
                              Text(
                                '${element['contentTitle']}',
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'English',
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Posted • $published',
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}