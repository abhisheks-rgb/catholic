// import 'dart:convert';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../models/church_info_model.dart';
import '../../../utils/asset_path.dart';

class ChurchInfoView extends BaseStatefulPageView {
  final ChurchInfoModel? model;
  final List<Map> _infos;

  ChurchInfoView(this.model, {Key? key})
      : _infos = List.generate(model?.churchInfos?.length ?? 0,
            (index) => model?.churchInfos![index] as Map),
        super();

  @override
  State<BaseStatefulPageView> createState() => _ChurchInfoViewState();
}

class _ChurchInfoViewState extends State<ChurchInfoView> {
  String? _selectedParishValue = '';

  @override
  void initState() {
    super.initState();

    _selectedParishValue = 'Cathedral of the Good Shepherd';

    if (widget.model!.churchId != null) {
      _selectedParishValue = widget.model!.churchName;
    }
  }

  @override
  void dispose() {
    super.dispose();

    delayedResetChurchId();
  }

  void delayedResetChurchId() async {
    await widget.model!.setChurchId(churchId: null);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> otherItems = <dynamic>[
      {
        'title': 'Church Bulletin',
        'icon': 'Church_Bulletin.png',
        'route': 'church_bulletin',
      },
      {
        'title': 'Schedules',
        'icon': 'Mass_Schedules.png',
        'route': 'schedules'
      },
      {
        'title': 'Offertory & Giving',
        'icon': 'Offertory_Giving.png',
        'route': 'offertory'
      },
    ];
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Color.fromRGBO(235, 235, 235, 1),
                        blurRadius: 15,
                        offset: Offset(0.0, 0.75),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () async {
                          if (widget.model!.items != null) {
                            showAlert(context);
                          }
                        },
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    _selectedParishValue ?? '',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    Entypo.chevron_down,
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      widget._infos.isEmpty
                          ? Container()
                          : Column(
                              children: [
                                const SizedBox(height: 8),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  indent: 0,
                                  endIndent: 0,
                                  color: Color.fromRGBO(4, 26, 82, 0.1),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(219, 228, 251, 1),
                                    shape: BoxShape.circle,
                                    image: widget
                                            ._infos[0]['orgPhotoUrl'].isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(widget._infos[0]
                                                ['orgPhotoUrl']),
                                            fit: BoxFit.cover,
                                          )
                                        : DecorationImage(
                                            image: AssetImage(
                                              assetPath(
                                                  'church-placeholder-img.png'),
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                widget._infos[0]['address'].isEmpty
                                    ? Container()
                                    : RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () async {
                                          if (widget._infos.isNotEmpty) {
                                            final query = widget._infos[0]
                                                    ['address']
                                                .trim();

                                            _redirectToMaps(query);
                                          }
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Icon(
                                                    MaterialCommunityIcons
                                                        .map_marker,
                                                    color: Color.fromRGBO(
                                                        130, 141, 168, 1),
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    widget._infos.isNotEmpty
                                                        ? widget._infos[0]
                                                            ['address']
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          4, 26, 82, 1),
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                const SizedBox(
                                                  width: 24,
                                                  height: 24,
                                                  child: Icon(
                                                    MaterialCommunityIcons
                                                        .directions,
                                                    color: Color.fromRGBO(
                                                        12, 72, 224, 1),
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                widget._infos[0]['orgTel1'].isEmpty
                                    ? Container()
                                    : RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          final orgTel =
                                              widget._infos.isNotEmpty
                                                  ? widget._infos[0]['orgTel1']
                                                  : '';
                                          final uri = Uri.parse('tel:$orgTel');
                                          urlLauncher(uri, 'tel');
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Icon(
                                                    FontAwesome.phone,
                                                    color: Color.fromRGBO(
                                                        130, 141, 168, 1),
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    widget._infos.isNotEmpty
                                                        ? widget._infos[0]
                                                            ['orgTel1']
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          12, 72, 224, 1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                widget._infos[0]['priestname'].isEmpty
                                    ? Container()
                                    : Column(
                                        children: [
                                          const SizedBox(height: 4),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 24,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child: Image.asset(
                                                      assetPath('priest.png'),
                                                      color:
                                                          const Color.fromRGBO(
                                                              4, 26, 82, 0.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    onPressed: () {
                                                      widget.model?.showPage(
                                                          '/_/priest_info',
                                                          widget._infos[0]
                                                              ['priestname'],
                                                          null,
                                                          null);
                                                    },
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          widget._infos
                                                                  .isNotEmpty
                                                              ? '${widget._infos[0]['priestsalutation']} ${widget._infos[0]['priestname']}'
                                                              : '',
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    12,
                                                                    72,
                                                                    224,
                                                                    1),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                      ],
                                                    ),
                                                  ),
                                                  RawMaterialButton(
                                                    constraints:
                                                        const BoxConstraints(),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    onPressed: () {
                                                      widget.model?.showPage(
                                                          '/_/priest_info',
                                                          null,
                                                          null,
                                                          null);
                                                    },
                                                    child: Column(
                                                      children: const [
                                                        SizedBox(height: 4),
                                                        Text(
                                                          'See all priests',
                                                          style: TextStyle(
                                                            color:
                                                                Color.fromRGBO(
                                                                    12,
                                                                    72,
                                                                    224,
                                                                    1),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                        ],
                                      ),
                                widget._infos[0]['orgEmail'].isEmpty
                                    ? Container()
                                    : RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          final orgEmail =
                                              widget._infos.isNotEmpty
                                                  ? widget._infos[0]['orgEmail']
                                                  : '';
                                          final uri =
                                              Uri.parse('mailTo:$orgEmail');
                                          urlLauncher(uri, 'email');
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Icon(
                                                    FontAwesome.envelope,
                                                    color: Color.fromRGBO(
                                                        130, 141, 168, 1),
                                                    size: 20,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    widget._infos.isNotEmpty
                                                        ? widget._infos[0]
                                                            ['orgEmail']
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          12, 72, 224, 1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                widget._infos[0]['orgWebsite'].isEmpty
                                    ? Container()
                                    : RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          final orgWebsite = widget
                                                  ._infos.isNotEmpty
                                              ? widget._infos[0]['orgWebsite']
                                              : '';
                                          final uri = Uri.parse('$orgWebsite');
                                          urlLauncher(uri, 'web');
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                    assetPath('globe.png'),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    widget._infos.isNotEmpty
                                                        ? widget._infos[0]
                                                            ['orgWebsite']
                                                        : '',
                                                    style: const TextStyle(
                                                      color: Color.fromRGBO(
                                                          12, 72, 224, 1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                widget._infos.isEmpty
                                    ? Container()
                                    : Column(
                                        children: const [
                                          SizedBox(height: 8),
                                          Divider(
                                            height: 1,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                            color:
                                                Color.fromRGBO(4, 26, 82, 0.1),
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                _renderLinks(),
                                const SizedBox(height: 8),
                              ],
                            ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                widget._infos.isEmpty
                    ? Container()
                    : Column(
                        children: otherItems.map<Widget>((e) {
                          return Column(
                            children: [
                              RawMaterialButton(
                                constraints: const BoxConstraints(),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                onPressed: () {
                                  var parish = widget.model!.items
                                      ?.firstWhere((element) {
                                    return element['name'] ==
                                        _selectedParishValue;
                                  });

                                  widget.model?.showPage(
                                      '/_/${e['route']}',
                                      _selectedParishValue,
                                      parish['link'],
                                      parish['_id'] - 1);
                                },
                                child: Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 24),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: const <BoxShadow>[
                                      BoxShadow(
                                        color: Color.fromRGBO(235, 235, 235, 1),
                                        blurRadius: 15,
                                        offset: Offset(0.0, 0.75),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 42,
                                        height: 56,
                                        child: Image.asset(
                                          assetPath('menu_item/${e['icon']}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          e['title'],
                                          style: const TextStyle(
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                            fontSize: 16,
                                          ),
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
                const SizedBox(height: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _redirectToMaps(String query) async {
    // final intRegex = RegExp(r'\d+$');
    // final result = intRegex.firstMatch(query)!;
    // final postalCode = result[0];
    // final url = Uri.parse(
    //     'https://developers.onemap.sg/commonapi/search?searchVal=$postalCode&returnGeom=Y&getAddrDetails=Y');
    // final response = await http.get(url);
    // final decodedResponse = json.decode(response.body);
    // final matches = List<dynamic>.from(decodedResponse['results']);
    // final filteredMatches = matches.where((loc) => loc['POSTAL'] == postalCode);
    // final loc = filteredMatches.isNotEmpty ? filteredMatches.first : null;

    // if (loc != null) {
    // final googleMaps =
    //     'https://www.google.com/maps/search/?api=1&query=${loc['LATITUDE']},${loc['LONGITUDE']}';
    final googleMaps = 'https://www.google.com/maps/search/?api=1&query=$query';
    final uri = Uri.parse(googleMaps);
    urlLauncher(uri, 'web');
    // } else if (mounted) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('Cannot find parish'),
    //     ),
    //   );
    // }

    _logChurchInfoEvent(widget._infos[0]['orgLink'], true);
  }

  Widget _renderLinks() {
    int inFlex = 0;
    int outFlex = 0;
    int hasLink = 0;
    List<dynamic> links = <dynamic>[];

    if (widget._infos[0]['orgFacebook'] != '' &&
        widget._infos[0]['orgFacebook'] != null) {
      hasLink += 1;
      links.add({
        'title': 'Facebook',
        'name': 'orgFacebook',
        'icon': const SizedBox(
          width: 24,
          height: 24,
          child: Icon(
            MaterialCommunityIcons.facebook,
            color: Color.fromRGBO(24, 119, 242, 1),
            size: 24,
          ),
        ),
      });
    }

    if (widget._infos[0]['orgInstagram'] != '' &&
        widget._infos[0]['orgInstagram'] != null) {
      hasLink += 1;
      links.add({
        'title': 'Instagram',
        'name': 'orgInstagram',
        'icon': SizedBox(
          width: 24,
          height: 24,
          child: Image.asset(
            assetPath('images/instagram-alt.png'),
          ),
        ),
      });
    }

    if (widget._infos[0]['orgTwitter'] != '' &&
        widget._infos[0]['orgTwitter'] != null) {
      hasLink += 1;
      links.add({
        'title': 'Twitter',
        'name': 'orgTwitter',
        'icon': const SizedBox(
          width: 24,
          height: 24,
          child: Icon(
            Entypo.twitter,
            color: Color.fromRGBO(29, 161, 242, 1),
            size: 24,
          ),
        ),
      });
    }

    if (widget._infos[0]['orgTelegram'] != '' &&
        widget._infos[0]['orgTelegram'] != null) {
      hasLink += 1;
      links.add({
        'title': 'Telegram',
        'name': 'orgTelegram',
        'icon': const SizedBox(
          width: 24,
          height: 24,
          child: Icon(
            FontAwesome.telegram,
            color: Color.fromRGBO(38, 166, 230, 1),
            size: 24,
          ),
        ),
      });
    }

    if (widget._infos[0]['orgYoutube'] != '' &&
        widget._infos[0]['orgYoutube'] != null) {
      hasLink += 1;
      links.add({
        'title': 'Youtube',
        'name': 'orgYoutube',
        'icon': const SizedBox(
          width: 24,
          height: 24,
          child: Icon(
            FontAwesome.youtube_play,
            color: Color.fromRGBO(255, 0, 0, 1),
            size: 24,
          ),
        ),
      });
    }

    switch (hasLink) {
      case 1:
        setState(() {
          inFlex = 2;
          outFlex = 3;
        });
        break;
      case 2:
        setState(() {
          inFlex = 1;
          outFlex = 1;
        });
        break;
      case 3:
        setState(() {
          inFlex = 2;
          outFlex = 1;
        });
        break;
      case 4:
      case 5:
        setState(() {
          inFlex = 1;
        });
        break;
      default:
    }

    return widget._infos.isEmpty
        ? Container()
        : Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  hasLink > 0
                      ? Expanded(
                          flex: outFlex,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                  hasLink < 1
                      ? Container()
                      : Expanded(
                          flex: inFlex,
                          child: _renderLinkButton(links[0]),
                        ),
                  hasLink < 2
                      ? Container()
                      : Expanded(
                          flex: inFlex,
                          child: _renderLinkButton(links[1]),
                        ),
                  hasLink < 3
                      ? Container()
                      : Expanded(
                          flex: inFlex,
                          child: _renderLinkButton(links[2]),
                        ),
                  hasLink < 4
                      ? Container()
                      : Expanded(
                          flex: inFlex,
                          child: _renderLinkButton(links[3]),
                        ),
                  hasLink > 0
                      ? Expanded(
                          flex: outFlex,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              hasLink < 5 ? Container() : const SizedBox(height: 8),
              hasLink < 5
                  ? Container()
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: _renderLinkButton(links[4]),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
            ],
          );
    // : GridView.builder(
    //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 4,
    //       childAspectRatio: 1.47,
    //     ),
    //     physics: const NeverScrollableScrollPhysics(),
    //     shrinkWrap: true,
    //     itemCount: links.length,
    //     itemBuilder: (context, index) => RawMaterialButton(
    //       constraints: const BoxConstraints(),
    //       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    //       onPressed: () {
    //         // final link = widget._infos.isNotEmpty
    //         //     ? widget._infos[0][links[index]['name']]
    //         //     : '';
    //         // final uri = Uri.parse('$link');
    //         // urlLauncher(uri, 'web');
    //       },
    //       child: Column(
    //         children: [
    //           const Spacer(),
    //           links[index]['icon'],
    //           const SizedBox(height: 8),
    //           Text(
    //             links[index]['title'],
    //             style: const TextStyle(
    //               color: Color.fromRGBO(4, 26, 82, 0.5),
    //               fontSize: 12,
    //             ),
    //           ),
    //           const Spacer(),
    //         ],
    //       ),
    //     ),
    //   );
  }

  Widget _renderLinkButton(item) => RawMaterialButton(
        constraints: const BoxConstraints(),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () {
          final link =
              widget._infos.isNotEmpty ? widget._infos[0][item['name']] : '';
          final uri = Uri.parse('$link');
          urlLauncher(uri, 'web');
        },
        child: Center(
          child: Column(
            children: [
              item['icon'],
              const SizedBox(height: 8),
              Text(
                item['title'],
                style: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );

  void showAlert(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          contentPadding: const EdgeInsets.all(0),
          title: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select Church',
                      style: TextStyle(
                        color: Color.fromRGBO(4, 26, 82, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: const CircleBorder(),
                    child: const SizedBox(
                      width: 24,
                      height: 24,
                      child: Icon(
                        MaterialCommunityIcons.close_circle,
                        color: Color.fromRGBO(130, 141, 168, 1),
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
          content: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
              maxHeight: 600,
            ),
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.model!.items!.length,
              separatorBuilder: (BuildContext context, int index) {
                return Container();
              },
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          widget.model!.items![index]['name'] ?? '',
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                  onTap: () {
                    widget.model!.fetchChurchInfo(orgId: index + 1);
                    setState(() {
                      _selectedParishValue =
                          widget.model!.items![index]['name'].toString();
                    });

                    Navigator.pop(context);

                    _logChurchInfoEvent(
                        widget.model!.items![index]['link'], false);
                  },
                );
              },
            ),
          ),
        ),
      );

  void _logChurchInfoEvent(String parishlink, bool isDirection) async {
    await FirebaseAnalytics.instance.logEvent(
      name: isDirection
          ? 'app_church_info_dir_$parishlink'
          : 'app_church_info_$parishlink',
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
