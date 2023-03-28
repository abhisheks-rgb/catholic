import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/profile_model.dart';
import '../../../utils/asset_path.dart';

class ProfileView extends BaseStatelessPageView {
  final ProfileModel? model;

  ProfileView(this.model) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color.fromRGBO(4, 26, 82, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        leading: RawMaterialButton(
          constraints: const BoxConstraints(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {
          },
          child: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              assetPath('icon-small.png'),
            ),
          ),
        ),
        actions: [
          RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
            child: const SizedBox(
              width: 20,
              height: 20,
              child: Icon(
                Octicons.bell_fill,
                color: Color.fromRGBO(130, 141, 168, 1),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 24),
          RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {
            },
            child: SizedBox(
              width: 20,
              height: 20,
              child: Image.asset(
                assetPath('user-active-solid.png'),
              ),
            ),
          ),
          const SizedBox(width: 24),
        ],
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
            // model?.loading == true
            //   ? Container(
            //       height: MediaQuery.of(context).size.height * 0.74,
            //       margin: const EdgeInsets.only(top: 16),
            //       child: const Center(
            //         child: CircularProgressIndicator(),
            //       ),
            //     )
            //   :
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(219, 228, 251, 1),
                            shape: BoxShape.circle,
                            image: model?.user?.photoURL != null
                              ? DecorationImage(
                                  image: NetworkImage(model?.user?.photoURL ?? ''),
                                  fit: BoxFit.contain,
                                )
                              : null,
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
                              assetPath('user-solid.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              model?.user?.displayName ?? '---',
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
                              model?.user?.email ?? '---',
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
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.asset(
                              assetPath('device-mobile-solid.png'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              model?.user?.phoneNumber ?? '---',
                              style: const  TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
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
                          const Expanded(
                            child: Text(
                              '---',
                              style: TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 1),
                                fontSize: 16,
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
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                    color: Colors.white,
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () async {
                        await model?.logout!();
                      },
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
              ],
            ),
            model?.loading == false || model?.loading == null
              ? Container()
              :
            Container(
              height: MediaQuery.of(context).size.height * 0.74,
              margin: const EdgeInsets.only(top: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}