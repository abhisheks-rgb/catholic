import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/event_details_model.dart';
import '../../../utils/asset_path.dart';

class EventDetailsView extends BaseStatefulPageView {
  final EventDetailsModel? model;

  EventDetailsView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _EventDetailsViewState();
}

class _EventDetailsViewState extends State<EventDetailsView> {
  @override
  void dispose() {
    super.dispose();
    delayedReset();
  }

  void delayedReset() async {
    await widget.model!.setIsEventDetails(isEventDetails: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Stack(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * 0.25,
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(
            //         assetPath('events-bg.jpg'),
            //       ),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * 0.25,
            //   decoration: const BoxDecoration(
            //     gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       colors: [
            //         Color.fromRGBO(255, 252, 245, 0),
            //         Color.fromRGBO(255, 252, 245, 1),
            //       ],
            //     ),
            //   ),
            // ),
            // Container(
            //   width: double.infinity,
            //   height: MediaQuery.of(context).size.height * 0.25,
            //   decoration: const BoxDecoration(
            //     color: Color.fromRGBO(255, 252, 245, 0.5),
            //   ),
            // ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 160,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(219, 228, 251, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Event Title',
                    style: TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '1 interested',
                    style: TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(219, 228, 251, 1),
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                    child: const Text(
                      'Walk-In Only',
                      style: TextStyle(
                        color: Color.fromRGBO(62, 111, 234, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
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
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Start: Mon, 20 Mar 23 - 8:00PM',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'End: Tue, 21 Mar 23 - 9:00PM',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          MaterialCommunityIcons.map_marker,
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '24 Highland Road Singapore 549115',
                          style: TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          MaterialCommunityIcons.directions,
                          color: Color.fromRGBO(12, 72, 224, 1),
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          assetPath('seats.png'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          '199/299 seats available',
                          style: TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Image.asset(
                          assetPath('bill.png'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Free',
                          style: TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          MaterialIcons.info,
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                          size: 20,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Church of the Holy Cross invites you to join our Parish Lenten Retreat from 20-21 March 2023, for a greater appreciation of the Mystery of the Cross. Talks at Main Church (Free admission, No registration',
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
          ],
        ),
      ),
    );
  }
}
