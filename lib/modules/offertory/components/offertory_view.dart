import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/offertory_model.dart';
import '../../../utils/asset_path.dart';
import '../../shared/components/select_dialog_view.dart';

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
  String? _selectedParishValue = '';

  @override
  void initState() {
    super.initState();

    _selectedParishValue = 'Cathedral of the Good Shepherd';

    if (widget.model!.churchName != null && widget.model!.churchName != '') {
      _selectedParishValue = widget.model!.churchName;
      currentParishId = widget.model!.churchId!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    delayedResetChurchName();
  }

  void delayedResetChurchName() async {
    await widget.model!.setChurchName(churchName: '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
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
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
                        onPressed: () {
                          if (widget.model!.items!.isNotEmpty) {
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
                                    widget.model!.items == null
                                        ? ''
                                        : _selectedParishValue!,
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
                                            child: Image.asset(
                                              assetPath('copy.png'),
                                              fit: BoxFit.cover,
                                            ),
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
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Expanded(
                                      child: RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () async {
                                          Butter.d(widget.model!
                                              .items![currentParishId]['name']);
                                          await widget.model!.navigateTo!(
                                              currentParishId,
                                              '/_/church_info',
                                              widget.model!
                                                      .items![currentParishId]
                                                  ['name']);
                                          // ignore: use_build_context_synchronously
                                          Navigator.of(context)
                                              .pushNamed('/_/church_info');
                                        },
                                        child: Column(
                                          children: const [
                                            SizedBox(height: 8),
                                            Align(
                                              alignment: Alignment.centerLeft,
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
                                            SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: RawMaterialButton(
                                        constraints: const BoxConstraints(),
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () {
                                          final query = widget.model!
                                                  .items?[currentParishId]
                                              ['address'];

                                          _redirectToMaps(query);
                                        },
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 8),
                                            Row(
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
                                                    MaterialCommunityIcons
                                                        .directions,
                                                    color: Color.fromRGBO(
                                                        12, 72, 224, 1),
                                                    size: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
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
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        margin: const EdgeInsets.only(top: 20),
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    : Container(),
                widget._infos.isEmpty
                    ? Container()
                    : Column(
                        children: [
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 24),
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
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
                                RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () async {
                                    if (widget.model!.items!.isNotEmpty) {
                                      await Clipboard.setData(
                                        ClipboardData(
                                          text: widget._infos[0]['uen'],
                                        ),
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
                                              widget._infos[0]['uen'],
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
                                            child: Image.asset(
                                              assetPath('copy.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        widget._infos[0]['uenlabel'],
                                        style: const TextStyle(
                                          color: Color.fromRGBO(4, 26, 82, 0.5),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
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
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Row(
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
                                              widget._infos[0]['label'],
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    8, 51, 158, 1),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
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

                                final index = widget._infos.indexWhere(
                                    (item) => item['name'] == element['name']);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    index != 1
                                        ? const SizedBox(height: 8)
                                        : const SizedBox(height: 16),
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
                                    RawMaterialButton(
                                      constraints: const BoxConstraints(),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onPressed: () {
                                        final charityUrl =
                                            widget._infos[index]['url'] ?? '';
                                        final uri = Uri.parse('$charityUrl');
                                        urlLauncher(uri, 'web');
                                      },
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          Row(
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    color: Color.fromRGBO(
                                                        8, 51, 158, 1),
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
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

  void showAlert(BuildContext context) {
    List<dynamic> churchList = [...widget.model!.items!];
    showDialog(
      context: context,
      routeSettings: RouteSettings(name: ModalRoute.of(context)?.settings.name),
      builder: (BuildContext context) => SelectChurchDialog(
        context: context,
        churchList: churchList,
        onSelected: (index, name, parishlink) {
          _handleChangeParish(index, name);
        },
      ),
    );
  }

  void _handleChangeParish(int index, String churchName) {
    setState(() {
      currentParishId = index;
      _selectedParishValue = churchName;
    });
  }
}
