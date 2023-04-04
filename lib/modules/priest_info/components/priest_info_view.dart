import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/priest_info_model.dart';
import '../../../utils/asset_path.dart';

class PriestInfoView extends BaseStatefulPageView {
  final PriestInfoModel? model;
  final List<Map> _infos;

  PriestInfoView(this.model, {Key? key})
      : _infos = List.generate(
            model?.priests?.length ?? 0, (index) => model?.priests![index] as Map),
        super();

  @override
  State<BaseStatefulPageView> createState() => _PriestInfoViewState();
}

class _PriestInfoViewState extends State<PriestInfoView> {
  int? currentPriestIndex;
  bool isAllPriests = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Priest Info',
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
            Navigator.of(context).maybePop();
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
              :
            Column(
              children: [
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
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
                  child: Column(
                    children: [
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          if (widget.model!.items!.isNotEmpty && widget._infos.isNotEmpty) {
                            showAlert(context);
                          }
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.model!.items!.isNotEmpty &&
                                widget._infos.isNotEmpty &&
                                !isAllPriests &&
                                currentPriestIndex != null
                                  ? '${widget._infos[currentPriestIndex!]['salutation'] ?? ''} ${widget._infos[currentPriestIndex!]['name'] ?? '---'}'
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
                      ),
                      isAllPriests || widget._infos.isEmpty
                        ? Container()
                        : _renderPriestInfo(),
                    ],
                  ),
                ),
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

    if (widget._infos[currentPriestIndex!]['churchid'] != null && widget._infos[currentPriestIndex!]['churchid'] != "") {
      priestParish = widget.model!.items!.firstWhere((element) {
        return element['_id'].toString() == widget._infos[currentPriestIndex!]['churchid'].toString();
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          widget._infos[currentPriestIndex!]['churchrole'].isNotEmpty
            ? widget._infos[currentPriestIndex!]['churchrole']
            : '---',
          style: const  TextStyle(
            color: Color.fromRGBO(4, 26, 82, 0.5),
            fontSize: 14,
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
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(219, 228, 251, 1),
              shape: BoxShape.circle,
              // image: widget._infos[currentPriestIndex!]['photo'] != null
              //   ? DecorationImage(
              //       image: NetworkImage(widget._infos[currentPriestIndex!]['photo'] ?? ''),
              //       fit: BoxFit.contain,
              //     )
              //   : null,
            ),
          ),
        ),
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
                priestParish['name'] ?? '---',
                style: const TextStyle(
                  color: Color.fromRGBO(12, 72, 224, 1),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
                widget._infos[currentPriestIndex!]['phone'].isNotEmpty
                  ? widget._infos[currentPriestIndex!]['phone']
                  : '---',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 1),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
                widget._infos[currentPriestIndex!]['email'].isNotEmpty
                  ? widget._infos[currentPriestIndex!]['email']
                  : '---',
                style: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 1),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
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
                  widget._infos[currentPriestIndex!]['ordinationdate'].isNotEmpty
                    ? widget._infos[currentPriestIndex!]['ordinationdate']
                    : '---',
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
    );
  }

  Widget _renderPriestList() {
    return Column(
      children: widget._infos.map<Widget>((element) {
        final index = widget._infos.indexWhere((item) => item['name'] == element['name']);
        Map priestParish = {};

        if (widget._infos[index]['churchid'] != null && widget._infos[index]['churchid'] != "") {
          priestParish = widget.model!.items!.firstWhere((element) {
            return element['_id'].toString() == widget._infos[index]['churchid'].toString();
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
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(219, 228, 251, 1),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${element['salutation'] ?? ''} ${element['name'] ?? '---'}',
                        overflow: TextOverflow.ellipsis,
                        style: const  TextStyle(
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
          itemCount: widget._infos.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 16);
          },
          itemBuilder: (context, index) {
            if (index == 0) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        if (!isAllPriests) {
                          setState(() {
                            isAllPriests = true;
                          });
                        }

                        Navigator.pop(context);
                      },
                      child: const Text(
                        'All Priests',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        _handleChangePriest(index);
                      },
                      child: Text(
                        '${widget._infos[index]['salutation'] ?? ''} ${widget._infos[index]['name'] ?? '---'}',
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (index == widget._infos.length -1) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        _handleChangePriest(index);
                      },
                      child: Text(
                        '${widget._infos[index]['salutation'] ?? ''} ${widget._infos[index]['name'] ?? '---'}',
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
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              child: Align(
                alignment: Alignment.topLeft,
                child: RawMaterialButton(
                  constraints: const BoxConstraints(),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: () {
                    _handleChangePriest(index);
                  },
                  child: Text(
                    '${widget._infos[index]['salutation'] ?? ''} ${widget._infos[index]['name'] ?? '---'}',
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }
        ),
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
}