import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import '../models/profile_model.dart';
import '../../../utils/asset_path.dart';

class ProfileView extends BaseStatelessPageView {
  final ProfileModel? model;

  ProfileView(this.model, {Key? key}) : super();

  @override
  Widget build(BuildContext context) {
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
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 228, 251, 1),
                            shape: BoxShape.circle,
                            image: model!.user?['smallpic'] == null
                                ? DecorationImage(
                                    image: AssetImage(
                                      assetPath('user-placeholder-img.png'),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: NetworkImage(
                                      model!.user?['smallpic'],
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      model!.user == null
                          ? Container()
                          : const SizedBox(height: 8),
                      model!.user == null
                          ? Container()
                          : model!.user?['fullname'] == null
                              ? Container()
                              : Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                            assetPath('user-solid.png'),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            model!.user?['fullname'],
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(4, 26, 82, 1),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                      model!.user == null
                          ? Container()
                          : model!.user?['email'] == null
                              ? Container()
                              : RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    final userEmail =
                                        model!.user?['email'] ?? '';
                                    final uri = Uri.parse('mailTo:$userEmail');
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
                                              color: Color.fromRGBO(
                                                  130, 141, 168, 1),
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              model!.user?['email'],
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    12, 72, 224, 1),
                                                fontWeight: FontWeight.w500,
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
                      model!.user == null
                          ? Container()
                          : model!.user?['mobile'] == null
                              ? Container()
                              : RawMaterialButton(
                                  constraints: const BoxConstraints(),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  onPressed: () {
                                    final userTel =
                                        model!.user?['mobile'] ?? '';
                                    final uri = Uri.parse('tel:$userTel');
                                    urlLauncher(uri, 'tel');
                                  },
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: Image.asset(
                                              assetPath(
                                                  'device-mobile-solid.png'),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              model!.user?['mobile'],
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    12, 72, 224, 1),
                                                fontWeight: FontWeight.w500,
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
                      model!.user == null
                          ? Container()
                          : model!.user?['churchName'] == null
                              ? Container()
                              : Column(
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
                                    const Text(
                                      'My Parish',
                                      style: TextStyle(
                                        color: Color.fromRGBO(4, 26, 82, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
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
                                            model!.user?['churchName'],
                                            style: const TextStyle(
                                              color:
                                                  Color.fromRGBO(4, 26, 82, 1),
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                  child: RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      const feedbackWebsite =
                          'https://mycatholic.sg/link/appfeedback';
                      final uri = Uri.parse(feedbackWebsite);
                      urlLauncher(uri, 'web');
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Send Feedback',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
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
                  child: RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () async {
                      await model?.logout!();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              assetPath('logout.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Column(children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Text(
                        '© ${DateTime.now().year}\nRoman Catholic Archdiocese of Singapore\nDigital Church Office (DCO)',
                        textScaleFactor: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          color: Color(0xff041a51),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'App Version: ${Platform.isIOS ? model!.appVersion!['ios'] : model!.appVersion!['android']}',
                    textScaleFactor: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      color: Color(0xff041a51),
                    ),
                  ),
                ]),
                const SizedBox(height: 50),
              ],
            ),
            // model!.user != null && _items.isNotEmpty
            //     ? Container()
            //     : Container(
            //         height: MediaQuery.of(context).size.height * 0.74,
            //         margin: const EdgeInsets.only(top: 16),
            //         decoration: BoxDecoration(
            //           color: Colors.white.withOpacity(0.5),
            //         ),
            //         child: const Center(
            //           child: CircularProgressIndicator(),
            //         ),
            //       ),
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
}
