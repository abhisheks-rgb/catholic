import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/church_info_model.dart';

import '../../../utils/asset_path.dart';

class ChurchInfoView extends BaseStatelessPageView {
  final ChurchInfoModel? model;

  ChurchInfoView({Key? key, this.model}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Church Info'),
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
                  ),
                  child: Column(
                    children: [
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          showAlert(context);
                        },
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Church\'s Name',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                assetPath('chevron-down-solid.png'),
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
                          color: const Color.fromRGBO(219, 228, 251, 1),
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
                              assetPath('map-pin-solid.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              '24 Highland Road Singapore 549115',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: Image.asset(
                              assetPath('directions.png'),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              assetPath('phone-solid.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              '+65 1234 5678',
                              style: TextStyle(
                                color: Color.fromRGBO(12, 72, 224, 1),
                                fontWeight: FontWeight.w500,
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
                            children: const [
                              Text(
                                  'Rev Fr John Desal',
                                  style: TextStyle(
                                    color: Color.fromRGBO(12, 72, 224, 1),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                ),
                              SizedBox(height: 8),
                              Text(
                                  'See all priest',
                                  style: TextStyle(
                                    color: Color.fromRGBO(12, 72, 224, 1),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              assetPath('envelope-solid.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'church@info.sg',
                              style: TextStyle(
                                color: Color.fromRGBO(12, 72, 224, 1),
                                fontWeight: FontWeight.w500,
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
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              assetPath('globe.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'www.church.sg',
                              style: TextStyle(
                                color: Color.fromRGBO(12, 72, 224, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
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
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      assetPath('images/facebook.png')
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Facebook',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      assetPath('images/instagram-alt.png')
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Instagram',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      assetPath('images/twitter.png')
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Twitter',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      assetPath('images/telegram.png')
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Telegram',
                                    style: TextStyle(
                                      color: Color.fromRGBO(4, 26, 82, 0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(219, 228, 251, 1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Church Bulletin',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(219, 228, 251, 1),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Schedules',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
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
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
          maxHeight: 600,
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Select Church',
                        style: TextStyle(
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
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Image.asset(
                          assetPath('xmark-circle-solid.png'),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'DISTRICT NAME',
                  style: TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'DISTRICT NAME',
                  style: TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'DISTRICT NAME',
                  style: TextStyle(
                    color: Color.fromRGBO(4, 26, 82, 0.5),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Church Name',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
