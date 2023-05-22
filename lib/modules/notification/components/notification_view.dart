import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/notification_model.dart';
import '../../../utils/asset_path.dart';

class NotificationView extends BaseStatelessPageView {
  final NotificationModel? model;
  final List _notificationList;

  NotificationView(this.model, {Key? key})
      : _notificationList = List.generate(3, (index) {
          final item = {};

          switch (index) {
            case 0:
              item['from'] = 'St. Joseph';
              item['date'] = 'just now';
              item['isRead'] = false;
              break;
            case 1:
              item['from'] = 'Cathedral';
              item['date'] = '1 hr ago';
              item['isRead'] = false;
              break;
            case 2:
              item['from'] = 'Cathedral';
              item['date'] = 'a day ago';
              item['isRead'] = true;
              break;
            default:
          }

          item['content'] =
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

          return item;
        }),
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color.fromRGBO(4, 26, 82, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        leading: RawMaterialButton(
          constraints: const BoxConstraints(),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onPressed: () {},
          child: SizedBox(
            width: 36,
            height: 36,
            child: Image.asset(
              assetPath('icon-small.png'),
            ),
          ),
        ),
        actions: [
          RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
            child: Container(
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: const Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Icon(
                    Octicons.bell_fill,
                    color: Color.fromRGBO(4, 26, 82, 1),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () {},
            child: Container(
              width: 40,
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset(
                    assetPath('user-active-solid.png'),
                    color: const Color.fromRGBO(4, 26, 82, 0.5),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: _notificationList.map<Widget>((element) {
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
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
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          element['isRead']
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    assetPath('notification_read.png'),
                                    color: const Color.fromRGBO(4, 26, 82, 0.5),
                                  ),
                                )
                              : SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset(
                                    assetPath('notification_unread.png'),
                                  ),
                                ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      element['from'],
                                      style: TextStyle(
                                        color: element['isRead']
                                            ? const Color.fromRGBO(
                                                4, 26, 82, 0.5)
                                            : const Color.fromRGBO(
                                                10, 62, 194, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      ' posted ${element['date']}',
                                      style: TextStyle(
                                        color: element['isRead']
                                            ? const Color.fromRGBO(
                                                4, 26, 82, 0.5)
                                            : const Color.fromRGBO(
                                                10, 62, 194, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  element['content'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: element['isRead']
                                        ? const Color.fromRGBO(4, 26, 82, 0.5)
                                        : const Color.fromRGBO(10, 62, 194, 1),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
