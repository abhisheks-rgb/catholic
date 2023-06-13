import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../utils/asset_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    Butter.d('SplashScreen::build');
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: 800,
          decoration: const BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Stack(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Image.asset(assetPath('splash-bg.png'),
                      fit: BoxFit.cover)),
              Align(
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.957, -1.211),
                        end: Alignment(0.515, 1),
                        colors: <Color>[Color(0x51ffffff), Color(0xffffffff)],
                        stops: <double>[0, 1],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  assetPath('logo.png'),
                  height: 168,
                  width: 168,
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 111,
                child: SizedBox(
                  height: 44, // specify th
                  child: Center(
                    child: Text(
                      'Empowering one connected church\nto grow our faith community',
                      textScaleFactor: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                        color: Color(0xff041a51),
                      ),
                    ),
                  ),
                ),
              ),
              const Positioned(
                left: 0,
                right: 0,
                bottom: 47,
                child: SizedBox(
                  height: 15, // specify th
                  child: Center(
                    child: Text(
                      'DIGITAL CHURCH OFFICE',
                      textAlign: TextAlign.center,
                      textScaleFactor: 1,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        // color: Color.fromRGBO(4, 26, 82, 0.5),
                        color: Color(0xff041a51),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
