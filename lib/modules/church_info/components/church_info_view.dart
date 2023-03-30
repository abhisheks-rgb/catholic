import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
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
  int inFlex = 0;
  int outFlex = 0;
  int hasLink = 0;
  Timer? myTimer;
  String? _selectedParishValue = "";

  @override
  void initState() {
    super.initState();

    _selectedParishValue = "Cathedral of the Good Shepherd";

    startTimer();
  }

  void startTimer() {
    int x = 0;

    myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (widget._infos.isNotEmpty) {
        x += 1;

        if (widget._infos[0]['orgFacebook'] != "" && widget._infos[0]['orgFacebook'] != null) {
          hasLink += 1;
        }

        if (widget._infos[0]['orgInstagram'] != "" && widget._infos[0]['orgInstagram'] != null) {
          hasLink += 1;
        }

        if (widget._infos[0]['orgTwitter'] != "" && widget._infos[0]['orgTwitter'] != null) {
          hasLink += 1;
        }

        if (widget._infos[0]['orgTelegram'] != "" && widget._infos[0]['orgTelegram'] != null) {
          hasLink += 1;
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
            setState(() {
              inFlex = 1;
            });
            break;
          default:
        }
      }

      if (x > 0) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    delayedResetChurchId();

    myTimer?.cancel();
  }

  void delayedResetChurchId() async {
    await widget.model!.setChurchId(churchId: 0);
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Church Info',
          style: TextStyle(
            color: Color.fromRGBO(4, 26, 82, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   child: Align(
            //     child: SizedBox(
            //       height: 275,
            //       child: Image.asset(
            //         assetPath('welcome_bg.png'),
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: 0,
            //   top: 0,
            //   child: Align(
            //     child: SizedBox(
            //       width: 391,
            //       height: 275,
            //       child: Container(
            //         decoration: const BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment(0.957, -1.211),
            //             end: Alignment(0.515, 1),
            //             colors: <Color>[
            //               Color(0x51ffffff),
            //               Color(0xffffffff)
            //             ],
            //             stops: <double>[0, 1],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Positioned(
            //   left: 0,
            //   top: 0,
            //   child: Align(
            //     child: SizedBox(
            //       width: 391,
            //       height: 275,
            //       child: Container(
            //         decoration: const BoxDecoration(
            //           gradient: LinearGradient(
            //             begin: Alignment(1, -1),
            //             end: Alignment(-1, 1),
            //             colors: <Color>[
            //               Color(0xff174dd4),
            //               Color(0x00ffffff)
            //             ],
            //             stops: <double>[0, 1],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            widget.model?.loading == true
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.74,
                  margin: const EdgeInsets.only(top: 16),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 24),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () async {
                              showAlert(context);
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget._infos.isNotEmpty
                                        ? widget._infos[0]['orgName']
                                        : '---',
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
                          ),
                          const SizedBox(height: 16),
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
                              borderRadius: BorderRadius.circular(10),
                              color: widget._infos.isEmpty
                                ? const Color.fromRGBO(219, 228, 251, 1)
                                : Colors.transparent,
                              image: widget._infos.isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(
                                        widget._infos[0]['logoUrl']),
                                    fit: BoxFit.contain,
                                  )
                                : null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(
                                  MaterialCommunityIcons.map_marker,
                                  color: Color.fromRGBO(130, 141, 168, 1),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  widget._infos.isNotEmpty
                                      ? widget._infos[0]['address']
                                      : '---',
                                  style: const TextStyle(
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: Icon(
                                  MaterialCommunityIcons.directions,
                                  color: Color.fromRGBO(12, 72, 224, 1),
                                  size: 24,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              final orgTel = widget._infos.isNotEmpty
                                  ? widget._infos[0]['orgTel1']
                                  : '';
                              final uri = Uri.parse('tel:$orgTel');
                              urlLauncher(uri, 'tel');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    FontAwesome.phone,
                                    color: Color.fromRGBO(130, 141, 168, 1),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    widget._infos.isNotEmpty
                                        ? widget._infos[0]['orgTel1']
                                        : '---',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset(
                                  assetPath('priest.png'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget._infos.isNotEmpty
                                        ? '${widget._infos[0]['priestsalutation']} ${widget._infos[0]['priestname']}'
                                        : '---',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'See all priest',
                                    style: TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              final orgEmail = widget._infos.isNotEmpty
                                  ? widget._infos[0]['orgEmail']
                                  : '';
                              final uri = Uri.parse('mailTo:$orgEmail');
                              urlLauncher(uri, 'email');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(
                                    FontAwesome.envelope,
                                    color: Color.fromRGBO(130, 141, 168, 1),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    widget._infos.isNotEmpty
                                        ? widget._infos[0]['orgEmail']
                                        : '---',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              final orgWebsite = widget._infos.isNotEmpty
                                  ? widget._infos[0]['orgWebsite']
                                  : '';
                              final uri = Uri.parse('$orgWebsite');
                              urlLauncher(uri, 'web');
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                        ? widget._infos[0]['orgWebsite']
                                        : '---',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget._infos.isEmpty
                            ? Container()
                            :
                          Column(
                            children: const [
                              SizedBox(height: 16),
                              Divider(
                                height: 1,
                                thickness: 1,
                                indent: 0,
                                endIndent: 0,
                                color: Color.fromRGBO(4, 26, 82, 0.1),
                              ),
                              SizedBox(height: 16),
                            ],
                          ),
                          widget._infos.isEmpty
                            ? Container()
                            :
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              hasLink > 0 && hasLink < 4
                                ? Expanded(
                                    flex: outFlex,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : Container(),
                              widget._infos[0]['orgFacebook'] == "" || widget._infos[0]['orgFacebook'] == null
                                ? Container()
                                :
                              Expanded(
                                flex: inFlex,
                                child: RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    final orgFacebook =
                                        widget._infos.isNotEmpty
                                            ? widget._infos[0]['orgFacebook']
                                            : '';
                                    final uri = Uri.parse('$orgFacebook');
                                    urlLauncher(uri, 'web');
                                  },
                                  child: Center(
                                    child: Column(
                                      children: const [
                                        SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: Icon(
                                            MaterialCommunityIcons.facebook,
                                            color: Color.fromRGBO(
                                                24, 119, 242, 1),
                                            size: 24,
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Facebook',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                4, 26, 82, 0.5),
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              widget._infos[0]['orgInstagram'] == "" || widget._infos[0]['orgInstagram'] == null
                                ? Container()
                                :
                              Expanded(
                                flex: inFlex,
                                child: Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(assetPath(
                                            'images/instagram-alt.png')),
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Instagram',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(4, 26, 82, 0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget._infos[0]['orgTwitter'] == "" || widget._infos[0]['orgTwitter'] == null
                                ? Container()
                                :
                              Expanded(
                                flex: inFlex,
                                child: Center(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Icon(
                                          Entypo.twitter,
                                          color:
                                              Color.fromRGBO(29, 161, 242, 1),
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Twitter',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(4, 26, 82, 0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              widget._infos[0]['orgTelegram'] == "" || widget._infos[0]['orgTelegram'] == null
                                ? Container()
                                :
                              Expanded(
                                flex: inFlex,
                                child: Center(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Icon(
                                          FontAwesome.telegram,
                                          color:
                                              Color.fromRGBO(38, 166, 230, 1),
                                          size: 24,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Telegram',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(4, 26, 82, 0.5),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              hasLink > 0 && hasLink < 4
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    widget._infos.isEmpty
                      ? Container()
                      :
                    Column(
                      children: otherItems.map<Widget>((e) {
                        return Column(
                          children: [
                            RawMaterialButton(
                              constraints: const BoxConstraints(),
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {
                                widget.model?.showPage('/_/${e['route']}', _selectedParishValue);
                              },
                              child: Container(
                                width: double.infinity,
                                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
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
          const SizedBox(height: 20),
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
            return const SizedBox(height: 10);
          },
          itemBuilder: (context, index) {
            if (index == widget.model!.items!.length - 1) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        widget.model!.fetchChurchInfo(orgId: index + 1);
                        setState(() {
                          _selectedParishValue = widget.model!.items![index]['name'].toString();
                        });
                        Navigator.pop(context);
                      },
                      child: Text(
                        widget.model!.items![index]['completename'] ?? '',
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }

            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: RawMaterialButton(
                  constraints: const BoxConstraints(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    widget.model!.fetchChurchInfo(orgId: index + 1);
                    setState(() {
                      _selectedParishValue = widget.model!.items![index]['name'].toString();
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    widget.model!.items![index]['completename'] ?? '',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );

  void urlLauncher(Uri uri, String source) async {
    if (source == 'web') {
      if (await canLaunchUrl(uri)) {
        await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        throw 'Could not launch $uri';
      }
    } else {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
}
