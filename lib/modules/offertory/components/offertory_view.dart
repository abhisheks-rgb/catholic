import 'dart:async';
import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/offertory_model.dart';
import '../../../utils/asset_path.dart';

class OffertoryView extends BaseStatefulPageView {
  final OffertoryModel? model;
  final List<Map> _infos;

  OffertoryView(this.model, {Key? key})
      : _infos = List.generate(model?.offertories?.length ?? 0,
            (index) => model?.offertories![index] as Map),
        super();

  @override
  State<BaseStatefulPageView> createState() => _OffertoryViewState();
}

class _OffertoryViewState extends State<OffertoryView> {
  int currentParishId = 1;
  Timer? myTimer;
  // String? _selectedParishValue = '';

  @override
  void initState() {
    super.initState();

    // _selectedParishValue = 'Cathedral of the Good Shepherd';

    if (widget.model!.churchName != null && widget.model!.churchName != '') {
      startTimer();
    }
  }

  void startTimer() async {
    int x = 0;

    Future.delayed(const Duration(seconds: 1), () async {
      myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (widget.model!.churchName != null &&
            widget.model!.churchName != '') {
          if (widget.model!.items!.isNotEmpty) {
            x += 1;

            final index = widget.model!.items!
                .indexWhere((item) => item['name'] == widget.model!.churchName);

            if (!index.isNaN) {
              setState(() {
                // _selectedParishValue = widget.model!.churchName.toString();
                currentParishId = index;
              });
            }
          }
        } else {
          x += 1;
        }

        if (x > 0) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    myTimer?.cancel();
    delayedResetChurchName();
  }

  void delayedResetChurchName() async {
    await widget.model!.setChurchName(churchName: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // widget.model?.loading == true
            //     ? Container(
            //         height: MediaQuery.of(context).size.height * 0.74,
            //         margin: const EdgeInsets.only(top: 16),
            //         child: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       )
            //     :
            Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  // padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      // InputDecorator(
                      //   decoration: const InputDecoration(
                      //       contentPadding: EdgeInsets.all(0),
                      //       border: OutlineInputBorder(
                      //           borderSide: BorderSide.none,
                      //           borderRadius: BorderRadius.all(Radius.zero))),
                      //   child: DropdownButtonHideUnderline(
                      //     child: DropdownButton(
                      //       borderRadius:
                      //           const BorderRadius.all(Radius.circular(10)),
                      //       icon: const Icon(Icons.keyboard_arrow_down),
                      //       elevation: 16,
                      //       isDense: true,
                      //       isExpanded: true,
                      //       value: _selectedParishValue,
                      //       hint: const Text('Select parish'),
                      //       items: [
                      //         ...?widget.model!.items?.map((value) {
                      //           return DropdownMenuItem<String>(
                      //             value: value['name'].toString(),
                      //             child: Text(value['name'],
                      //                 style: const TextStyle(fontSize: 16)),
                      //           );
                      //         }).toList()
                      //       ],
                      //       onChanged: (value) {
                      //         final index = widget.model!.items?.indexWhere(
                      //             (item) => item['name'] == value.toString());

                      //         if (index != -1) {
                      //           setState(() {
                      //             _selectedParishValue = value.toString();
                      //             currentParishId = index!;
                      //           });
                      //         }
                      //       },
                      //     ),
                      //   ),
                      // ),
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          showAlert(context);
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.model!.items == null
                                    ? 'Cathedral of the Good Shepherd'
                                    : widget.model!.items!.isNotEmpty
                                        ? widget.model!.items![currentParishId]
                                            ['name']
                                        : 'Cathedral of the Good Shepherd',
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
                                RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () async {
                                    if (widget.model!.items!.isNotEmpty) {
                                      await Clipboard.setData(
                                        ClipboardData(
                                            text: widget.model!
                                                    .items![currentParishId]
                                                ['uen']),
                                      ).then((_) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'UEN copied to your clipboard'),
                                          ),
                                        );
                                      });
                                    }
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              widget.model!.items!.isNotEmpty
                                                  ? widget.model!.items![
                                                      currentParishId]['uen']
                                                  : '',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    233, 40, 35, 1),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                            height: 16,
                                            child: Image.asset(assetPath(
                                                'square-on-square-solid.png')),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'PayNow UEN',
                                        style: TextStyle(
                                          color: Color.fromRGBO(4, 26, 82, 0.5),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () async {
                                          await widget.model!.navigateTo!(
                                              currentParishId + 1,
                                              '/_/church_info');
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .pushNamed('/_/church_info');
                                        },
                                        child: const Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            'Church Info',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  12, 72, 224, 1),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: const [
                                          Spacer(),
                                          Text(
                                            'Directions',
                                            style: TextStyle(
                                              color: Color.fromRGBO(
                                                  12, 72, 224, 1),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Icon(
                                              MaterialCommunityIcons.directions,
                                              color: Color.fromRGBO(
                                                  12, 72, 224, 1),
                                              size: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                widget._infos.isEmpty
                    ? Container()
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget._infos[0]['name'],
                                  style: const TextStyle(
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget._infos[0]['description'],
                                  style: const TextStyle(
                                    color: Color.fromRGBO(4, 26, 82, 0.5),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  widget._infos[0]['uen'],
                                  style: const TextStyle(
                                    color: Color.fromRGBO(233, 40, 35, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget._infos[0]['uenlabel'],
                                  style: const TextStyle(
                                    color: Color.fromRGBO(4, 26, 82, 0.5),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    final orgWebsite =
                                        widget._infos[0]['url'] ?? '';
                                    final uri = Uri.parse('$orgWebsite');
                                    urlLauncher(uri, 'web');
                                  },
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 14,
                                        height: 14,
                                        child: Icon(
                                          Ionicons.open_outline,
                                          color: Color.fromRGBO(12, 72, 224, 1),
                                          size: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          widget._infos[0]['label'],
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(8, 51, 158, 1),
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                const SizedBox(height: 16),
                widget._infos.isEmpty
                    ? Container()
                    : Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Charities',
                              style: TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            Column(
                              children: widget._infos.map<Widget>((element) {
                                if (widget._infos[0]['name'] ==
                                    element['name']) {
                                  return Container();
                                }

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 16),
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                      color: Color.fromRGBO(4, 26, 82, 0.1),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      element['name'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(4, 26, 82, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      element['description'],
                                      style: const TextStyle(
                                        color: Color.fromRGBO(4, 26, 82, 0.5),
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    RawMaterialButton(
                                      constraints: const BoxConstraints(),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onPressed: () {
                                        final orgWebsite =
                                            widget._infos[0]['url'] ?? '';
                                        final uri = Uri.parse('$orgWebsite');
                                        urlLauncher(uri, 'web');
                                      },
                                      child: Row(
                                        children: [
                                          const SizedBox(
                                            width: 14,
                                            height: 14,
                                            child: Icon(
                                              Ionicons.open_outline,
                                              color: Color.fromRGBO(
                                                  12, 72, 224, 1),
                                              size: 14,
                                            ),
                                          ),
                                          const SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              element['label'],
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    8, 51, 158, 1),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                const SizedBox(height: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
                return const SizedBox(height: 16);
              },
              itemBuilder: (context, index) {
                if (index == widget.model!.items!.length - 1) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            _handleChangeParish(index);
                          },
                          child: Text(
                            widget.model!.items![index]['name'] ?? '',
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  );
                }

                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        _handleChangeParish(index);
                      },
                      child: Text(
                        widget.model!.items![index]['name'] ?? '',
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

  void _handleChangeParish(int index) {
    setState(() {
      currentParishId = index;
    });
    Navigator.pop(context);
  }
}
