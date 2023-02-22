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
                  height: 800,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 67),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(assetPath('logo.png'), height: 125),
                    ],
                  ),
                  const SizedBox(height: 197),
                  const Text(
                    'One connected church\nto grow our faith\n community',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff041a51),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
