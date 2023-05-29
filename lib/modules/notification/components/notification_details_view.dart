import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/notification_details_model.dart';
// import '../../../utils/asset_path.dart';

class NotificationDetailsView extends BaseStatelessPageView {
  final NotificationDetailsModel? model;

  NotificationDetailsView(this.model, {Key? key}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 24),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'St. Joseph',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Posted • Mon, 20 Mar 2023',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras arcu est, condimentum vitae porttitor sit amet, egestas a elit. Duis eleifend lorem nec mattis scelerisque. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Vestibulum suscipit enim vitae dui sollicitudin facilisis. Phasellus dapibus elementum neque, quis faucibus metus malesuada nec. Integer sollicitudin eros id massa tempus consequat. Sed sit amet lacus semper, gravida eros non, dapibus risus. Morbi at pharetra ipsum. Phasellus rhoncus diam augue, eget blandit leo consectetur quis. Cras porta, dui tristique elementum venenatis, libero felis tempor tortor, et tristique ex nisl ut arcu. Fusce eu lectus metus..',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AspectRatio(
                        aspectRatio: 1.75,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(219, 228, 251, 1),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
