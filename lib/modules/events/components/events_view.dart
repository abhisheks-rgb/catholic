import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/events_model.dart';
import '../../../utils/asset_path.dart';

class EventsView extends BaseStatelessPageView {
  final EventsModel? model;

  EventsView(this.model, {Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    assetPath('events-bg.jpg'),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
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
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(255, 252, 245, 0.5),
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.77,
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 28),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Sorry, there are currently no available events',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(4, 26, 82, 0.5),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
