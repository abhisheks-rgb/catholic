import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/welcome_model.dart';

import '../../../utils/asset_path.dart';
import '../../../../utils/page_specs.dart';

class WelcomePage extends BaseStatefulPageView {
  final WelcomeModel? model;

  WelcomePage({Key? key, this.model}) : super();

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: false,
      ));

  @override
  State<BaseStatefulPageView> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  ScrollController _scrollController = ScrollController();
  bool shouldDisplay = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        if (_isAppBarExpanded) {
          if (shouldDisplay != true) {
            setState(() {
              shouldDisplay = true;
            });
          }
        } else {
          if (shouldDisplay != false) {
            setState(() {
              shouldDisplay = false;
            });
          }
        }
      });
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> exploreItems = <dynamic>[
      {
        'title': 'Mass Readings',
        'icon': 'Mass_Reading.png',
        'route': 'mass_readings'
      },
      {
        'title': 'Scripture Reflection',
        'icon': 'Scripture_Reflections.png',
        'route': 'scripture'
      },
      {
        'title': 'Mass Schedules',
        'icon': 'Mass_Schedules.png',
        'route': 'schedules'
      },
      {
        'title': 'Church Bulletin',
        'icon': 'Church_Bulletin.png',
        'route': 'church_bulletin',
      },
      {
        'title': 'Church Info',
        'icon': 'Church_Info.png',
        'route': 'church_info',
      },
      {
        'title': 'Offertory & Giving',
        'icon': 'Offertory_Giving.png',
        'route': 'offertory'
      },
    ];

    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 275,
            collapsedHeight: 60,
            pinned: true,
            floating: true,
            snap: true,
            leading: Container(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                shouldDisplay
                    ? SizedBox(
                        width: 54,
                        height: 54,
                        child: Image.asset(
                          assetPath('logo.png'),
                          width: 24,
                          height: 24,
                        ),
                      )
                    : Container(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: 32,
                    //   height: 32,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(10),
                    //       color: Colors.white,
                    //     ),
                    //     child: Image.asset(
                    //       assetPath('notif_icon.png'),
                    //       width: 32,
                    //       height: 32,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(width: 10),
                    RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        widget.model?.showPage('/_/profile');
                      },
                      child: SizedBox(
                        width: 32,
                        height: 32,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                  ],
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
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
                          height: 275,
                          child: Image.asset(
                            assetPath('welcome_bg.png'),
                            fit: BoxFit.contain,
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
                          height: 275,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: const Alignment(0.957, -1.211),
                                end: const Alignment(0.515, 1),
                                colors: <Color>[
                                  const Color(0x51ffffff),
                                  const Color(0xffffffff).withOpacity(0.9)
                                ],
                                stops: const <double>[0, 1],
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
                          height: 275,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(1, -1),
                                end: Alignment(-1, 1),
                                colors: <Color>[
                                  Color.fromRGBO(24, 77, 212, 0.5),
                                  Color.fromRGBO(255, 255, 255, 0)
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
                      bottom: 79,
                      child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 24,
                          ),
                          width: MediaQuery.of(context).size.width - 48,
                          height: 68,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: const [
                              Text(
                                'Peace be with you!',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                ),
                              ),
                              // Text(
                              //   'Oscar Dela Hoya Hatton y...',
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   style: TextStyle(
                              //     fontSize: 28,
                              //     fontWeight: FontWeight.w500,
                              //     color: Color.fromRGBO(4, 26, 82, 1),
                              //   ),
                              // ),
                            ],
                          )),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 20),
                        width: MediaQuery.of(context).size.width - 48,
                        height: 38,
                        child: const Text(
                          '“The steadfast love of the LORD never ceases...” - Lam 3: 22',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff041a51),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30.2822113037,
                      top: 16,
                      child: Align(
                        child: SizedBox(
                          width: 54,
                          height: 54,
                          child: Image.asset(
                            assetPath('logo.png'),
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              delegate: SliverChildBuilderDelegate((_, int index) {
                return InkWell(
                  onTap: () {
                    widget.model
                        ?.showPage('/_/${exploreItems[index]['route']}');
                  },
                  child: Container(
                    height: 185,
                    padding: const EdgeInsets.all(16),
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
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            width: 74,
                            height: 100,
                            child: Image.asset(
                              assetPath(
                                  'menu_item/${exploreItems[index]['icon']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            exploreItems[index]['title'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff041a51),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }, childCount: exploreItems.length),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: MediaQuery.of(context).size.height * 0.26),
          ),
        ],
      ),
    );
  }
}
