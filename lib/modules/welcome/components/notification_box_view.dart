import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class NotificationBox extends StatefulWidget {
  final String header;
  final String content;
  final bool showAll;
  final Function urlLauncher;
  final Function onTap;
  final Function onPressed;

  const NotificationBox({
    Key? key,
    required this.header,
    required this.content,
    required this.showAll,
    required this.urlLauncher,
    required this.onTap,
    required this.onPressed,
  }) : super(key: key);

  @override
  NotificationBoxState createState() => NotificationBoxState();
}

class NotificationBoxState extends State<NotificationBox> {
  // bool showAll = false;

  @override
  Widget build(BuildContext context) {
    return widget.header != 'null'
        ? GestureDetector(
            onTap: () => widget.onTap(),
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 253, 244, 244),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x142c0807),
                    offset: Offset(0, 2),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    minLeadingWidth: 10,
                    leading: Column(
                      children: [
                        const SizedBox(height: 14),
                        badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            badgeColor: Colors.red.shade800,
                          ),
                          position:
                              badges.BadgePosition.topEnd(top: -5, end: -5),
                          showBadge: true,
                          ignorePointer: false,
                          badgeAnimation: const badges.BadgeAnimation.scale(
                            animationDuration: Duration(milliseconds: 200),
                            loopAnimation: false,
                            curve: Curves.linear,
                          ),
                          badgeContent: const Icon(
                            Octicons.bell_fill,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                    title: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.4,
                            color: Color.fromRGBO(4, 26, 82, 1)),
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.header,
                            style: const TextStyle(
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  widget.showAll == true
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(15, 0, 15, 10),
                                child: Linkify(
                                  onOpen: (link) async {
                                    final website = link.url;
                                    final uri = Uri.parse(website);
                                    widget.urlLauncher(uri, 'web');
                                  },
                                  text: widget.content,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromRGBO(4, 26, 82, 1),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RawMaterialButton(
                                    enableFeedback: true,
                                    elevation: 0,
                                    constraints: const BoxConstraints(),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onPressed: () => widget.onPressed(),
                                    shape: const CircleBorder(),
                                    child: const Text(
                                      'Close',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(4, 26, 82, 1),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 15)
                                ],
                              ),
                              const SizedBox(height: 15)
                            ])
                      : Container(),
                ],
              ),
            ),
          )
        : Container();
  }
}
