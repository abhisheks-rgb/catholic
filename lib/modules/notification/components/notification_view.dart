import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../models/notification_model.dart';
import '../../../utils/asset_path.dart';

class NotificationView extends BaseStatefulPageView {
  final NotificationModel? model;
  final List _notificationList;

  NotificationView(this.model, {Key? key})
      : _notificationList = List.generate(
            model?.items?.length ?? 0, (index) => model?.items![index] as Map),
        super();

  @override
  State<BaseStatefulPageView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    // Function to request notification permissions
    Future<void> requestNotificationPermission() async {
      Butter.d('Requesting notification permissions...');
      final status = await Permission.notification.status;
      Butter.d('Notification permissions status: $status');
      if (status.isDenied || status.isPermanentlyDenied) {
        final isGranted = await openAppSettings();
        Butter.d(isGranted);
        if (isGranted) {
          // Permissions have been granted.
          // Handle this case as needed.
          Butter.d('Notification permissions  granted.');
        }
      } else {
        // Permissions have already been granted.
        // Handle this case as needed.
        Butter.d('Notification permissions already granted.');
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            widget.model!.loading == true || widget.model!.items == null
                ? Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    margin: const EdgeInsets.only(top: 20),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    children: [
                      widget.model!.showNotification == true
                          ? Container(
                              width: double.infinity,
                              color: Colors.yellow[100],
                              padding: const EdgeInsets.all(16),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        await requestNotificationPermission();
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            'Tap to enable notifications',
                                            style: TextStyle(
                                              color:
                                                  Color.fromRGBO(4, 26, 82, 1),
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.touch_app,
                                            color: Color.fromRGBO(4, 26, 82, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(),
                      ...widget._notificationList.map<Widget>((element) {
                        for (var e in element.keys) {
                          Butter.d('$e: ${element[e]}');
                        }
                        return Column(
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 20),
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
                              child: RawMaterialButton(
                                constraints: const BoxConstraints(),
                                materialTapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                onPressed: () {
                                  widget.model?.showPage(
                                    route: '/_/notification/details',
                                    element: element as Map,
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // element['isRead']
                                      //     ? SizedBox(
                                      //         width: 20,
                                      //         height: 20,
                                      //         child: Image.asset(
                                      //           assetPath('notification_read.png'),
                                      //           color: const Color.fromRGBO(
                                      //               4, 26, 82, 0.5),
                                      //         ),
                                      //       )
                                      //     : SizedBox(
                                      //         width: 20,
                                      //         height: 20,
                                      //         child: Image.asset(
                                      //           assetPath('notification_unread.png'),
                                      //         ),
                                      //       ),
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                          assetPath('notification_unread.png'),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element['header'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                // color: element['isRead']
                                                //     ? const Color.fromRGBO(
                                                //         4, 26, 82, 0.5)
                                                //     : const Color.fromRGBO(
                                                //         10, 62, 194, 1),
                                                color: Color.fromRGBO(
                                                    10, 62, 194, 1),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              _renderPostedAt(
                                                  element['created']),
                                              style: const TextStyle(
                                                // color: element['isRead']
                                                //     ? const Color.fromRGBO(
                                                //         4, 26, 82, 0.5)
                                                //     : const Color.fromRGBO(
                                                //         10, 62, 194, 1),
                                                color: Color.fromRGBO(
                                                    4, 26, 82, 1),
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              element['content'],
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                // color: element['isRead']
                                                //     ? const Color.fromRGBO(
                                                //         4, 26, 82, 0.5)
                                                //     : const Color.fromRGBO(
                                                //         10, 62, 194, 1),
                                                color: Color.fromRGBO(
                                                    10, 62, 194, 1),
                                                fontSize: 16,
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList()
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  String _renderPostedAt(int created) {
    DateTime now = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(created);

    final differenceInMinutes = now.difference(date).inMinutes;
    final differenceInHours = now.difference(date).inHours;
    final differenceInDays = now.difference(date).inDays;

    if (differenceInMinutes < 60) {
      if (differenceInMinutes == 1) {
        return 'Posted just now';
      } else {
        return 'Posted $differenceInMinutes minutes ago';
      }
    } else if (differenceInHours < 24) {
      return 'Posted $differenceInHours hr${differenceInHours > 1 ? 's' : ''} ago';
    } else if (differenceInDays == 1) {
      return 'Posted a day ago';
    } else {
      return 'Posted $differenceInDays days ago';
    }
  }
}
