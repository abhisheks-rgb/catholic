import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/welcome_model.dart';

import '../../../utils/asset_path.dart';

class WelcomePage extends BaseStatelessPageView {
  final WelcomeModel? model;

  WelcomePage({Key? key, this.model}) : super();

  @override
  Widget build(BuildContext context) {
    List<dynamic> exploreItems = <dynamic>[
      {
        'title': 'Mass Readings',
        'icon': 'mass_readings_icon.png',
        'route': 'schedules'
      },
      {
        'title': 'Scripture Reflection',
        'icon': '002-pray.png',
        'route': 'schedules'
      },
      {
        'title': 'Mass Schedules',
        'icon': '004-greeting-card.png',
        'route': 'schedules'
      },
      {
        'title': 'Church Bulletin',
        'icon': '001-dove.png',
        'route': 'schedules'
      },
      {'title': 'Parish Info', 'icon': '001-dove.png', 'route': 'schedules'},
      {
        'title': 'Offertory & Giving',
        'icon': '004-greeting-card.png',
        'route': 'schedules'
      },
    ];

    return Scaffold(
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(
              // color: Color(0x00fffcf5),
              color: Color.fromRGBO(255, 252, 245, 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 280,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x192c0807),
                        offset: Offset(0, 8),
                        blurRadius: 32,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            height: 280,
                            child: Image.asset(
                              assetPath('welcome_bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: 391,
                            height: 280,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(0.957, -1.211),
                                  end: Alignment(0.515, 1),
                                  colors: <Color>[
                                    Color(0x51ffffff),
                                    Color(0xffffffff)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: 391,
                            height: 280,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment(1, -1),
                                  end: Alignment(-1, 1),
                                  colors: <Color>[
                                    Color(0xff174dd4),
                                    Color(0x00ffffff)
                                  ],
                                  stops: <double>[0, 1],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 79,
                        top: 59,
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              assetPath('notif_icon.png'),
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 27,
                        top: 59,
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.white,
                            ),
                            child: Image.asset(
                              assetPath('user_icon.png'),
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 76,
                        top: 55,
                        child: Align(
                          child: SizedBox(
                            width: 13,
                            height: 13,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.5),
                                color: const Color(0xfff70916),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        // welcomeoscarHYf (127:100)
                        left: 24,
                        top: 132,
                        child: Align(
                          child: SizedBox(
                            width: 206,
                            height: 34,
                            child: Text(
                              'Welcome Oscar, ',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: Color(0xff041a51),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 24,
                        top: 193,
                        child: Align(
                          child: SizedBox(
                            width: 287,
                            height: 48,
                            child: Text(
                              '"THE STEADFAST LOVE OF THE LORD NEVER CEASES...” - LAM 3: 22',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff041a51),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 30.2822113037,
                        top: 54.6252441406,
                        child: Align(
                          child: SizedBox(
                            width: 54,
                            height: 54,
                            child: Image.asset(
                              assetPath('logo.png'),
                              width: 54,
                              height: 54,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  margin:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 18),
                  child: const Text('Explore',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff041a51),
                      )),
                ),
                Expanded(
                    child: MasonryGridView.count(
                  itemCount: exploreItems.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 20,
                  itemBuilder: (_, int index) {
                    return InkWell(
                        onTap: () {
                          model?.showPage('/_/${exploreItems[index]['route']}');
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
                          child: Align(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
                                width: 40,
                                height: 40,
                                child: Image.asset(
                                  assetPath(exploreItems[index]['icon']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                exploreItems[index]['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff041a51),
                                ),
                              ),
                            ],
                          )),
                        ));
                  },
                )),
              ],
            )),
      ),
    );
  }
}
