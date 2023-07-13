import 'dart:async';

import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/priest_info_model.dart';
import '../../../utils/asset_path.dart';

class PriestInfoView extends BaseStatefulPageView {
  final PriestInfoModel? model;
  final List<Map> _infos;

  PriestInfoView(this.model, {Key? key})
      : _infos = List.generate(model?.priests?.length ?? 0,
            (index) => model?.priests![index] as Map),
        super();

  @override
  State<BaseStatefulPageView> createState() => _PriestInfoViewState();
}

class _PriestInfoViewState extends State<PriestInfoView> {
  int? currentPriestIndex;
  bool isAllPriests = true;
  Timer? myTimer;
  // String? _selectedPriestValue = '';

  @override
  void initState() {
    super.initState();

    // _selectedPriestValue = 'all';

    startTimer();
  }

  void startTimer() {
    int x = 0;

    myTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (widget._infos.isNotEmpty) {
        x += 1;

        final index = widget._infos
            .indexWhere((item) => item['name'] == widget.model!.priestName);

        if (!index.isNaN && index >= 0) {
          setState(() {
            isAllPriests = false;
            currentPriestIndex = index;
          });
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

    delayedResetPriestName();

    myTimer?.cancel();
  }

  void delayedResetPriestName() async {
    await widget.model!.setPriestName(priestName: null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: widget.model!.priestName != null &&
                  currentPriestIndex == null
              ? [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.only(top: 20),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                ]
              : [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.33,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          assetPath('page-bg.png'),
                        ),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    height: 350.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 252, 245, 0),
                          Color.fromRGBO(255, 252, 245, 1),
                        ],
                        stops: [0.0, 1.0],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
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
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(1, -1),
                              end: Alignment(-1, 1),
                              colors: <Color>[
                                Color.fromRGBO(24, 77, 212, 0.5),
                                Color.fromRGBO(255, 255, 255, 0),
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.5,
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
                    children: [
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(208, 185, 133, 0.15),
                              offset: Offset(0, 8),
                              blurRadius: 16,
                            ),
                            BoxShadow(
                              color: Color.fromRGBO(208, 185, 133, 0.05),
                              offset: Offset(0, 4),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // InputDecorator(
                            //   decoration: const InputDecoration(
                            //       contentPadding: EdgeInsets.all(0),
                            //       border: OutlineInputBorder(
                            //         borderSide: BorderSide.none,
                            //         borderRadius: BorderRadius.all(Radius.zero),
                            //       ),
                            //       constraints: BoxConstraints(
                            //         maxHeight: 20,
                            //       )),
                            //   child: DropdownButtonHideUnderline(
                            //     child: DropdownButton(
                            //       icon: const Icon(Icons.keyboard_arrow_down),
                            //       elevation: 16,
                            //       isDense: true,
                            //       isExpanded: true,
                            //       value: _selectedPriestValue,
                            //       hint: const Text('Select priest'),
                            //       items: [
                            //         const DropdownMenuItem<String>(
                            //           value: 'all',
                            //           child: Text('All Priests'),
                            //         ),
                            //         ...widget._infos.map((value) {
                            //           return DropdownMenuItem<String>(
                            //             value: value['name'].toString(),
                            //             child: Text(
                            //                 '${value['salutation']} ${value['name']}',
                            //                 style:
                            //                     const TextStyle(fontSize: 16)),
                            //           );
                            //         }).toList(),
                            //       ],
                            //       onChanged: (value) async {
                            //         final index = widget._infos.indexWhere(
                            //             (item) =>
                            //                 item['name'] == value.toString());

                            //         if (index != -1) {
                            //           setState(() {
                            //             _selectedPriestValue = value.toString();
                            //             currentPriestIndex = index;

                            //             if (isAllPriests) {
                            //               isAllPriests = false;
                            //             }
                            //           });
                            //         } else if (!isAllPriests) {
                            //           setState(() {
                            //             _selectedPriestValue = 'all';
                            //             isAllPriests = true;
                            //           });
                            //         }
                            //       },
                            //     ),
                            //   ),
                            // ),
                            RawMaterialButton(
                              constraints: const BoxConstraints(),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              onPressed: () {
                                if (widget.model!.items!.isNotEmpty &&
                                    widget._infos.isNotEmpty) {
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
                                          widget.model!.items != null &&
                                                  widget._infos.isNotEmpty &&
                                                  !isAllPriests &&
                                                  currentPriestIndex != null
                                              ? '${widget._infos[currentPriestIndex!]['salutation'] ?? ''} ${widget._infos[currentPriestIndex!]['name'] ?? ''}${widget._infos[currentPriestIndex!]['suffix'].isNotEmpty ? ', ${widget._infos[currentPriestIndex!]['suffix']}' : ''}'
                                              : 'All Priests',
                                          // overflow: TextOverflow.ellipsis,
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
                                  isAllPriests || widget._infos.isEmpty
                                      ? Container()
                                      : Column(
                                          children: [
                                            widget
                                                    ._infos[currentPriestIndex!]
                                                        ['churchrole']
                                                    .isEmpty
                                                ? Container()
                                                : Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      widget._infos[
                                                                  currentPriestIndex!]
                                                              ['churchrole'] ??
                                                          '',
                                                      style: const TextStyle(
                                                        color: Color.fromRGBO(
                                                            4, 26, 82, 0.5),
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                            widget
                                                    ._infos[currentPriestIndex!]
                                                        ['churchrole']
                                                    .isEmpty
                                                ? Container()
                                                : const SizedBox(height: 8),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                            isAllPriests || widget._infos.isEmpty
                                ? Container()
                                : _renderPriestInfo(),
                          ],
                        ),
                      ),
                      widget._infos.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              margin: const EdgeInsets.only(top: 20),
                              child: const Center(
                                  child: CircularProgressIndicator()),
                            )
                          : Container(),
                      const SizedBox(height: 16),
                      isAllPriests && widget._infos.isNotEmpty
                          ? _renderPriestList()
                          : Container(),
                    ],
                  ),
                ],
        ),
      ),
    );
  }

  Widget _renderPriestInfo() {
    Map priestParish = {};

    if (widget._infos[currentPriestIndex!]['churchid'] != null &&
        widget._infos[currentPriestIndex!]['churchid'] != '') {
      priestParish = widget.model!.items!.firstWhere((element) {
        return element['_id'].toString() ==
            widget._infos[currentPriestIndex!]['churchid'].toString();
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget._infos[currentPriestIndex!]['photo'].isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget._infos[currentPriestIndex!]['photo'],
                          width: 100,
                        ),
                      )
                    : Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 228, 251, 1),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                            child: Image.asset(
                          assetPath('priest.png'),
                          color: const Color.fromRGBO(4, 26, 82, 0.5),
                          width: 100,
                        )),
                      ),
              ]),
        ),
        priestParish.isEmpty
            ? Container()
            : Column(
                children: [
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          assetPath('church-alt.png'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          priestParish['name'] ?? '',
                          style: const TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  widget._infos[currentPriestIndex!]['phone'].isEmpty
                      ? Container()
                      : const SizedBox(height: 8),
                ],
              ),
        priestParish.isEmpty ? const SizedBox(height: 8) : Container(),
        widget._infos[currentPriestIndex!]['phone'].isEmpty
            ? Container()
            : RawMaterialButton(
                constraints: const BoxConstraints(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  final priestTel =
                      widget._infos[currentPriestIndex!]['phone'] ?? '';
                  final uri = Uri.parse('tel:$priestTel');
                  urlLauncher(uri, 'tel');
                },
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
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
                            widget._infos[currentPriestIndex!]['phone'] ?? '',
                            style: const TextStyle(
                              color: Color.fromRGBO(12, 72, 224, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
        widget._infos[currentPriestIndex!]['email'].isEmpty
            ? Container()
            : RawMaterialButton(
                constraints: const BoxConstraints(),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onPressed: () {
                  final priestEmail =
                      widget._infos[currentPriestIndex!]['email'] ?? '';
                  final uri = Uri.parse('mailTo:$priestEmail');
                  urlLauncher(uri, 'email');
                },
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
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
                            widget._infos[currentPriestIndex!]['email'] ?? '',
                            style: const TextStyle(
                              color: Color.fromRGBO(12, 72, 224, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
        widget._infos[currentPriestIndex!]['ordinationdate'].isEmpty
            ? Container()
            : Column(
                children: [
                  widget._infos[currentPriestIndex!]['email'].isEmpty ||
                          (widget._infos[currentPriestIndex!]['email']
                                  .isEmpty &&
                              widget
                                  ._infos[currentPriestIndex!]['phone'].isEmpty)
                      ? const SizedBox(height: 16)
                      : const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          FontAwesome5Solid.calendar,
                          color: Color.fromRGBO(130, 141, 168, 1),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget._infos[currentPriestIndex!]
                                    ['ordinationdate'] ??
                                '',
                            style: const TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Ordination Date',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 0.5),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _renderPriestList() {
    return Column(
      children: widget._infos.map<Widget>((element) {
        final index =
            widget._infos.indexWhere((item) => item['name'] == element['name']);
        Map priestParish = {};

        if (widget._infos[index]['churchid'] != null &&
            widget._infos[index]['churchid'] != '') {
          priestParish = widget.model!.items!.firstWhere((element) {
            return element['_id'].toString() ==
                widget._infos[index]['churchid'].toString();
          });
        }

        return RawMaterialButton(
          constraints: const BoxConstraints(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
            setState(() {
              currentPriestIndex = index;

              if (isAllPriests) {
                isAllPriests = false;
              }
            });
          },
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(208, 185, 133, 0.15),
                  offset: Offset(0, 8),
                  blurRadius: 16,
                ),
                BoxShadow(
                  color: Color.fromRGBO(208, 185, 133, 0.05),
                  offset: Offset(0, 4),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(219, 228, 251, 1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: element['photo'].isEmpty
                        ? Image.asset(
                            assetPath('priest.png'),
                            color: const Color.fromRGBO(4, 26, 82, 0.5),
                            width: 23,
                            height: 23,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              element['photo'],
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${element['salutation'] ?? ''} ${element['name'] ?? ''}${element['suffix'].isNotEmpty ? ', ${element['suffix']}' : ''}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        priestParish['name'] ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  void showAlert(BuildContext context) => showDialog(
        context: context,
        routeSettings:
            RouteSettings(name: ModalRoute.of(context)?.settings.name),
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
                      'Select Priest',
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
                itemCount: widget._infos.length,
                separatorBuilder: (BuildContext context, int index) {
                  return Container();
                },
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: const [
                                  SizedBox(height: 8),
                                  Text(
                                    'All Priests',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            if (!isAllPriests) {
                              setState(() {
                                isAllPriests = true;
                              });
                            }

                            Navigator.pop(context);
                          },
                        ),
                        InkWell(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    '${widget._infos[index]['salutation'] ?? ''} ${widget._infos[index]['name'] ?? ''}${widget._infos[index]['suffix'].isNotEmpty ? ', ${widget._infos[index]['suffix']}' : ''}',
                                    style: const TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 1),
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            _handleChangePriest(index);
                          },
                        ),
                      ],
                    );
                  } else if (index == widget._infos.length - 1) {
                    return InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 24),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              Text(
                                '${widget._infos[index]['salutation'] ?? ''} ${widget._infos[index]['name'] ?? '---'}${widget._infos[index]['suffix'].isNotEmpty ? ', ${widget._infos[index]['suffix']}' : ''}',
                                style: const TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        _handleChangePriest(index);
                      },
                    );
                  }

                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 24),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              '${widget._infos[index]['salutation'] ?? ''} ${widget._infos[index]['name'] ?? ''}${widget._infos[index]['suffix'].isNotEmpty ? ', ${widget._infos[index]['suffix']}' : ''}',
                              style: const TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _handleChangePriest(index);
                    },
                  );
                }),
          ),
        ),
      );

  void _handleChangePriest(int index) {
    setState(() {
      currentPriestIndex = index;

      if (isAllPriests) {
        isAllPriests = false;
      }
    });

    Navigator.pop(context);
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
}
