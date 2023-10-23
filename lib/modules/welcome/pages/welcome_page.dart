import 'package:butter/butter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:trcas_catholic/modules/home/pages/home_page.dart';
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
  bool showAll = false;

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
      // if (widget.model!.versionPlus != null) {
      //   Butter.d(widget.model!.versionPlus?.appStoreLink ?? '');
      //   Butter.d(widget.model!.versionPlus?.localVersion ?? '');
      //   Butter.d(widget.model!.versionPlus?.originalStoreVersion ?? '');
      //   Butter.d(widget.model!.versionPlus?.storeVersion ?? '');
      //   Butter.d(widget.model!.versionPlus?.canUpdate ?? '');
      //   return widget.model!.versionPlus!.canUpdate;
      // }
      return false;
    }

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
          ValueListenableBuilder(
            valueListenable: objectNotifier,
            builder: (context, value, child) {
              final header =
                  (value as Map<dynamic, dynamic>)['header'].toString();
              final content = value['content'].toString();

              return SliverToBoxAdapter(
                  child: header != 'null'
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              showAll = !showAll;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 253, 244, 244),
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius for rounded corners
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x142c0807),
                                  offset: Offset(0, 2),
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  dense: true,
                                  minLeadingWidth: 10,
                                  leading: Column(
                                    children: [
                                      const SizedBox(height: 14),
                                      badges.Badge(
                                        badgeStyle: badges.BadgeStyle(
                                          badgeColor: Colors.red.shade800,
                                        ),
                                        position: badges.BadgePosition.topEnd(
                                            top: -5, end: -5),
                                        showBadge: true,
                                        ignorePointer: false,
                                        badgeAnimation:
                                            const badges.BadgeAnimation.scale(
                                          animationDuration:
                                              Duration(milliseconds: 200),
                                          loopAnimation:
                                              false, // Keep the animation looping
                                          curve: Curves
                                              .linear, // Linear curve for a continuous rotation
                                        ),
                                        badgeContent: const Icon(
                                          Octicons.bell_fill,
                                          color: Colors.white,
                                          size: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  title: RichText(
                                    text: TextSpan(
                                      style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.4,
                                          color: Color.fromRGBO(4, 26, 82, 1)),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: header,
                                          style: const TextStyle(
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                showAll == true
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      15, 0, 15, 0),
                                              child: Text(
                                                content,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      4, 26, 82, 1),
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                RawMaterialButton(
                                                  enableFeedback: true,
                                                  elevation: 0,
                                                  constraints:
                                                      const BoxConstraints(),
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  onPressed: () {
                                                    objectNotifier.value = {
                                                      'header': 'null',
                                                      'content': 'null'
                                                    };
                                                    setState(() {
                                                      showAll = false;
                                                    });
                                                  },
                                                  shape: const CircleBorder(),
                                                  child: const SizedBox(
                                                    width: 24,
                                                    height: 24,
                                                    child: Icon(
                                                      MaterialCommunityIcons
                                                          .close,
                                                      color: Color.fromARGB(
                                                          255, 135, 135, 135),
                                                      weight: .1,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 15)
                                              ],
                                            ),
                                            const SizedBox(height: 15)
                                          ])
                                    : Container(),
                              ],
                            ),
                          ),
                        )
                      : Container());
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.78,
              ),
              delegate: SliverChildBuilderDelegate((_, int index) {
                return InkWell(
                  onTap: () {
                    widget.model
                        ?.showPage('/_/${exploreItems[index]['route']}');
                  },
                  child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: Image.asset(
                            assetPath(
                                'menu_item/${exploreItems[index]['icon']}'),
                            excludeFromSemantics: true,
                            cacheWidth: 72,
                            cacheHeight: 100,
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
