import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class FrontBanner extends StatefulWidget {
  final Function onTap;
  final dynamic properties;
  final bool isFrontBannerEnabled;

  const FrontBanner({
    Key? key,
    required this.onTap,
    required this.properties,
    required this.isFrontBannerEnabled,
  }) : super(key: key);

  @override
  FrontBannerState createState() => FrontBannerState();
}

class FrontBannerState extends State<FrontBanner> {
  String rightimage = '';
  String leftimage = '';
  String buttonlabel = '';
  late Color buttoncolor = const Color(0xffffffff);
  late Color buttonlabelcolor = const Color(0xffffffff);

  @override
  void initState() {
    super.initState();

    rightimage = widget.properties?['rightimage'] ?? '';
    leftimage = widget.properties?['leftimage'] ?? '';
    buttonlabel = widget.properties?['buttonlabel'] ?? '';
    buttoncolor =
        parseColor(widget.properties?['buttoncolor'] ?? '255, 255, 255, 255');
    buttonlabelcolor = parseColor(
        widget.properties?['buttonlabelcolor'] ?? '255, 255, 255, 255');
  }

  @override
  void didUpdateWidget(covariant FrontBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    //this make sure that the widget is updated when there are changes
    if (widget.properties != oldWidget.properties) {
      rightimage = widget.properties?['rightimage'] ?? '';
      leftimage = widget.properties?['leftimage'] ?? '';
      buttonlabel = widget.properties?['buttonlabel'] ?? '';
      buttoncolor = parseColor(widget.properties?['buttoncolor']);
      buttonlabelcolor = parseColor(widget.properties?['buttonlabelcolor']);
    }
  }

  Color parseColor(String colorString) {
    List<String> colorParts = colorString.split(', ');

    int alpha = int.parse(colorParts[0]);
    int red = int.parse(colorParts[1]);
    int green = int.parse(colorParts[2]);
    int blue = int.parse(colorParts[3]);

    return Color.fromARGB(alpha, red, green, blue);
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFrontBannerEnabled
        ? GestureDetector(
            onTap: () => widget.onTap(),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(6),
                    padding: const EdgeInsets.all(0),
                    dashPattern: const [8, 0],
                    strokeWidth: 4,
                    color: buttoncolor,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const RadialGradient(
                            center: Alignment.center,
                            radius: 0.5,
                            stops: [0.0, 0.22, 0.4, 0.68, 0.98],
                            // stops: [0.0, 0.22, 0.4, 0.68, 0.80, 0.98],
                            colors: [
                              Color.fromARGB(255, 255, 255, 255),
                              Color.fromARGB(255, 255, 249, 231),
                              // Color.fromARGB(255, 255, 252, 246),
                              Color.fromARGB(255, 255, 249, 231),
                              Color.fromARGB(255, 255, 252, 246),
                              Color.fromARGB(255, 252, 248, 231),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: SizedBox(
                                      height: 38,
                                      child: leftimage != ''
                                          ? Image.network(
                                              leftimage,
                                              fit: BoxFit.cover,
                                            )
                                          : Container(),
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 5, 0, 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(4.0),
                                      child: Container(
                                        color: buttoncolor,
                                        child: Padding(
                                          padding: buttonlabel.length <= 10
                                              ? const EdgeInsets.fromLTRB(
                                                  40, 5, 40, 5)
                                              : const EdgeInsets.fromLTRB(
                                                  8, 5, 8, 5),
                                          child: Text(
                                            buttonlabel,
                                            style: TextStyle(
                                              color: buttonlabelcolor,
                                              fontWeight: FontWeight.w500,
                                              fontSize: buttonlabel.length <= 10
                                                  ? 13
                                                  : 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SizedBox(
                                height: 100,
                                child: rightimage != ''
                                    ? Image.network(
                                        rightimage,
                                        fit: BoxFit.cover,
                                      )
                                    : Container(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          )
        : Container();
  }
}
