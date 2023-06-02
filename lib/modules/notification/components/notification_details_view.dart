import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/notification_details_model.dart';

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
                      Text(
                        model?.item?['header'] ?? '',
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _renderPostedAt(model?.item?['created']),
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        model?.item?['content'] ?? '',
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      Linkify(
                        onOpen: (link) async {
                          final website = link.url;
                          final uri = Uri.parse(website);
                          urlLauncher(uri);
                        },
                        text: model?.item?['content'] ?? '',
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontSize: 16,
                          height: 1.4,
                        ),
                      ),
                      // const SizedBox(height: 16),
                      // AspectRatio(
                      //   aspectRatio: 1.75,
                      //   child: Container(
                      //     decoration: const BoxDecoration(
                      //       color: Color.fromRGBO(219, 228, 251, 1),
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //     ),
                      //   ),
                      // ),
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

  String _renderPostedAt(int created) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(created);

    String formattedDate = DateFormat('E, d MMM yy').format(date);

    return 'Posted • $formattedDate';
  }

  void urlLauncher(Uri uri) async {
    bool canLaunch = false;
    var source = '';

    switch (uri.scheme) {
      case 'mailto':
        source = 'email';
        break;
      default:
        source = 'web';
    }

    if (await canLaunchUrl(uri)) {
      canLaunch = true;
    } else {
      throw 'Could not launch $uri';
    }

    if (canLaunch) {
      switch (source) {
        case 'web':
          await launchUrl(
            uri,
            mode: LaunchMode.externalApplication,
          );
          break;
        default:
          await launchUrl(uri);
      }
    }
  }
}
