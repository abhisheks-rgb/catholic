import 'package:butter/butter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../shared/components/login_prompt_view.dart';
import '../models/events_model.dart';
import '../../../utils/asset_path.dart';

class EventsView extends BaseStatefulPageView {
  final EventsModel? model;
  EventsView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> exploreItems = <dynamic>[
      {
        'title': 'All Events',
        'icon': 'All_Events.png',
        'route': 'events/list',
      },
      {
        'title': 'My Events',
        'icon': 'My_Events.png',
        'route': 'events/myEvents',
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
                Container(
                  height: 226,
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
                            height: 226,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              assetPath('pray_banner.png'),
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
                            width: MediaQuery.of(context).size.width,
                            height: 226,
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
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Align(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 226,
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
                      ),
                      Positioned(
                        left: 0,
                        bottom: 79,
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            width: MediaQuery.of(context).size.width - 48,
                            height: 102,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  DateFormat('d MMM y, EEEE')
                                      .format(DateTime.now()),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                  ),
                                ),
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
                            '"How good and pleasant it is when God’s people live together in unity!" ~Psalm 133:1',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff041a51),
                              letterSpacing: 0.1,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                LoginPrompt(
                  onPressed: () {
                    widget.model?.showPage('/_/login');
                  },
                  isLoggedIn: FirebaseAuth.instance.currentUser != null,
                ),
                const SizedBox(height: 10),
                Flexible(
                    child: MasonryGridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: exploreItems.length,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                  crossAxisCount: 1,
                  mainAxisSpacing: 10,
                  itemBuilder: (_, int index) {
                    return InkWell(
                      onTap: () {
                        if (widget.model?.isLoggedIn != true &&
                            exploreItems[index]['route'] == 'events/myEvents') {
                          widget.model?.showPage('/_/login');
                        } else {
                          Navigator.of(context)
                              .pushNamed('/_/${exploreItems[index]['route']}');
                        }
                      },
                      child: Container(
                          height: 88,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                                width: 42,
                                height: 56,
                                child: Image.asset(
                                  assetPath(
                                      'menu_item/${exploreItems[index]['icon']}'),
                                ),
                              ),
                              Text(
                                exploreItems[index]['title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff041a51),
                                ),
                              ),
                            ],
                          )),
                    );
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
