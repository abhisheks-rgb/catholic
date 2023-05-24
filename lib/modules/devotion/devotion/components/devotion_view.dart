import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/devotion_model.dart';

class DevotionView extends StatefulWidget {
  final DevotionModel? model;

  const DevotionView({
    super.key,
    this.model,
  });

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _DevotionPageState(model!);
}

class _DevotionPageState extends State<DevotionView> {
  final DevotionModel model;

  _DevotionPageState(this.model);

  @override
  Widget build(BuildContext context) {
    List<dynamic> exploreItems = <dynamic>[
      {
        'title': 'Rosary',
        'subTitle': 'Prayer Guide • What is Rosary?',
        'route': 'rosary'
      },
      {
        'title': 'Angelus',
        'subTitle': 'Prayer Guide • What is Angelus?',
        'route': 'angelus',
      },
      {
        'title': 'Divine Mercy Prayer',
        'subTitle': 'What is Rosary? • Prayer Guide',
        'route': 'prayer',
      },
    ];
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 252, 245, 1),
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: MasonryGridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: exploreItems.length,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    crossAxisCount: 1,
                    mainAxisSpacing: 10,
                    itemBuilder: (_, int index) {
                      return InkWell(
                        onTap: () {
                          if (exploreItems[index]['route'] == 'rosary') {
                            Navigator.of(context).pushNamed(
                                '/_/devotion/${exploreItems[index]['route']}');
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x142c0807),
                                offset: Offset(0, 8),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exploreItems[index]['title'],
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                exploreItems[index]['subTitle'],
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
