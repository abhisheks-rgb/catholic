import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/devotion_model.dart';
import '../../../../utils/asset_path.dart';

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
        'title': 'The Rosary',
        'subTitle': 'Prayer Guide • What is the Rosary?',
        'route': 'rosary'
      },
      // {
      //   'title': 'Angelus',
      //   'subTitle': 'Prayer Guide • What is Angelus?',
      //   'route': 'angelus',
      // },
      {
        'title': 'Divine Mercy Prayer',
        'subTitle': 'Prayer Guide • What is the Divine Mercy Prayer? ',
        'route': 'divine_mercy_prayer',
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
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    height: 150,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      assetPath('pray_banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: const Alignment(0.957, -1.211),
                          end: const Alignment(0.515, 1),
                          colors: <Color>[
                            const Color(0x51ffffff).withOpacity(0.2),
                            const Color(0xffffffff).withOpacity(0.9)
                          ],
                          stops: const <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(1, -1),
                          end: Alignment(-1, 1),
                          colors: <Color>[
                            Color.fromRGBO(24, 77, 212, 0.3),
                            Color.fromRGBO(255, 255, 255, 0.3)
                          ],
                          stops: <double>[0, 1],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 155,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(255, 252, 245, 0),
                        Color.fromRGBO(255, 252, 245, 1),
                      ],
                    ),
                  ),
                ),
                Column(
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
                              widget.model?.showPage(
                                  '/_/devotion/${exploreItems[index]['route']}');
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
                    const SizedBox(height: 100),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
