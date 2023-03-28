import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/scripture_model.dart';

class ScriptureView extends BaseStatelessPageView {
  final ScriptureModel? model;
  final List<Map> _items;

  ScriptureView(this.model, {Key? key})
      : _items = List.generate(
            model?.items?.length ?? 0, (index) {
              final item = model?.items![index] as Map;

              switch(item['authorname']) {
                case 'William SC Goh':
                  item['order'] = 0;
                  item['authorname'] = 'Archbp William SC Goh';
                  break;
                case 'Adrian Danker':
                  item['order'] = 1;
                  item['authorname'] = 'Fr Adrian Danker';
                  break;
                case 'Luke Fong':
                  item['order'] = 2;
                  item['authorname'] = 'Fr Luke Fong';
                  break;
                case 'Stephen Yim':
                  item['order'] = 3;
                  item['authorname'] = 'Fr Stephen Yim';
                  break;
                default:
              }

              return item;
            })..sort((a, b) => a['order'].compareTo(b['order'])),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Scripture Reflections',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            model?.loading == true
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.74,
                  margin: const EdgeInsets.only(top: 16),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              :
            Container(
              width: double.infinity,
              // height: 210,
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              decoration: const BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(235, 235, 235, 1),
                    blurRadius: 15,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    _items[0]['data'][0]['contentTitle'] ?? '---',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _items[0]['data'][0]['content'] ?? '---',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 0.5),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 16),
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async {
                      await model?.viewScriptureDetails?.call(_items[0]['data'][0]);
                    },
                    child: const Text(
                      'Read More',
                      style: TextStyle(
                        color: Color.fromRGBO(12, 72, 224, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
            model?.loading == true
              ? Container()
              :
            Column(
              children: _items.map<Widget>((element) {
                final data = element['data'] as List;
                final index = _items.indexWhere((item) => item['authorname'] == element['authorname']);
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reflections & Homilies (${data.length})',
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'by ${element['authorname']}',
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 0.5),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Divider(
                            height: 1,
                            thickness: 1,
                            indent: 0,
                            endIndent: 0,
                            color: Color.fromRGBO(4, 26, 82, 0.1),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () async {
                                    await model?.viewHistory?.call(index);
                                  },
                                  child: const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        color: Color.fromRGBO(12, 72, 224, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () async {
                                    await model?.viewScriptureDetails?.call(element['data'][0]);
                                  },
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: const [
                                        Spacer(),
                                        Text(
                                          'Read Latest',
                                          style: TextStyle(
                                            color: Color.fromRGBO(12, 72, 224, 1),
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}