import 'package:butter/butter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;
import 'package:badges/badges.dart' as badges;
import '../models/welcome_model.dart';
import '../../home/models/home_model.dart';
import '../../../utils/asset_path.dart';
import '../../../../utils/page_specs.dart';

class WelcomePage extends BaseStatefulPageView {
  final WelcomeModel? model;
  final HomeModel? homeModel;

  WelcomePage({Key? key, this.model, this.homeModel}) : super();

  @override
  get specs => PageSpecs.build((context, {dispatch, read}) => PageSpecs(
        hasAppBar: false,
      ));

  @override
  State<BaseStatefulPageView> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final ScrollController _scrollController = ScrollController();

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
        'route': 'scripture/history'
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

    bool isDownloadRequired() {
      if (widget.model!.versionPlus != null) {
        return widget.model!.versionPlus!.canUpdate;
      }
      return false;
    }

    Butter.d('App Version: ${widget.model?.appVersion}');
    Butter.d('DB Version: ${widget.model?.dbVersion}');
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 275,
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
                        width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width,
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
                        width: MediaQuery.of(context).size.width,
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
                          children: [
                            Text(
                              widget.model?.user != null
                                  ? 'Peace,'
                                  : 'Peace be with you!',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(4, 26, 82, 1),
                              ),
                            ),
                            widget.model?.user != null
                                ? Text(
                                    widget.model!.user?['fullname'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                    ),
                                  )
                                : const SizedBox(),
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
                        '“The steadfast love of the LORD never ceases...” ~ Lam 3: 22',
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 36,
                          height: 36,
                          child: Image.asset(
                            assetPath('icon-small.png'),
                            width: 36,
                            height: 36,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              constraints: const BoxConstraints(),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: widget.model!.showNotifs,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: widget.model!.hasNotif
                                          ? badges.Badge(
                                              position:
                                                  badges.BadgePosition.topEnd(
                                                      top: -4, end: -2),
                                              badgeStyle: badges.BadgeStyle(
                                                badgeColor: Colors.red.shade700,
                                                elevation: 0,
                                              ),
                                              child: const Icon(
                                                Octicons.bell_fill,
                                                color: Color.fromRGBO(
                                                    130, 141, 168, 1),
                                                size: 20,
                                              ),
                                            )
                                          : const Icon(
                                              Octicons.bell_fill,
                                              color: Color.fromRGBO(
                                                  130, 141, 168, 1),
                                              size: 20,
                                            )),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            RawMaterialButton(
                              constraints: const BoxConstraints(),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {
                                widget.model?.showPage('/_/profile');
                              },
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      assetPath('user-solid.png'),
                                      width: 20,
                                      height: 20,
                                    ),
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
              ),
            ),
          ),
          !isDownloadRequired()
              ? SliverToBoxAdapter(
                  child: Container(),
                )
              : SliverToBoxAdapter(
                  child: RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () async {
                      if (Platform.isIOS) {
                        //do ios link
                        final Uri url = Uri.parse(
                            'https://apps.apple.com/sg/app/mycatholicsg-app/id1151027240');
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      } else {
                        //do android link
                        final Uri url = Uri.parse(
                            'https://play.google.com/store/apps/details?id=com.CSG.CatholicSG');
                        await launchUrl(url,
                            mode: LaunchMode.externalNonBrowserApplication);
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(204, 229, 255, 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(235, 235, 235, 1),
                            blurRadius: 15,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.system_update,
                            color: Color.fromRGBO(4, 26, 82, 1),
                            size: 18,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Download Latest Version',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
          FirebaseAuth.instance.currentUser == null
              ? SliverToBoxAdapter(
                  child: RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      widget.model?.showPage('/_/login');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(255, 244, 219, 1),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Color.fromRGBO(235, 235, 235, 1),
                            blurRadius: 15,
                            offset: Offset(0.0, 0.75),
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Log in Now',
                            style: TextStyle(
                              color: Color.fromRGBO(99, 69, 4, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'to make full use of the App!',
                            style: TextStyle(
                              color: Color.fromRGBO(99, 69, 4, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(),
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
                            width: 72,
                            height: 100,
                            child: Image.asset(
                              assetPath(
                                  'menu_item/${exploreItems[index]['icon']}'),
                              // fit: BoxFit.cover,
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
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(237, 241, 253, 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(235, 235, 235, 1),
                    blurRadius: 15,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void urlLauncher(Uri uri, String source) async {
    bool canLaunch = false;

    if (await canLaunchUrl(uri)) {
      canLaunch = true;
    } else {
      throw 'Could not launch $uri';
    }

    if (canLaunch) {
      switch (source) {
        case 'web':
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          break;
        default:
          await launchUrl(uri);
      }
    }
  }
}
