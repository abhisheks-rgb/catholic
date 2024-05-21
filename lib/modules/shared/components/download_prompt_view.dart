import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class DownloadPrompt extends StatefulWidget {
  final bool isDownloadRequired;

  const DownloadPrompt({
    Key? key,
    required this.isDownloadRequired,
  }) : super(key: key);

  @override
  DownloadPromptState createState() => DownloadPromptState();
}

class DownloadPromptState extends State<DownloadPrompt> {
  @override
  Widget build(BuildContext context) {
    return !widget.isDownloadRequired
        ? Container()
        : RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () async {
              if (Platform.isIOS) {
                //do ios link
                final Uri url = Uri.parse(
                    'https://apps.apple.com/sg/app/mycatholicsg-app/id1151027240');
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                //do android link
                final Uri url = Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.CSG.CatholicSG');
                await launchUrl(url,
                    mode: LaunchMode.externalNonBrowserApplication);
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(204, 229, 255, 1),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color.fromRGBO(235, 235, 235, 1),
                    blurRadius: 15,
                    offset: Offset(0.0, 0.75),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.system_update,
                    color: Color.fromRGBO(4, 26, 82, 1),
                    size: 18,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Download Latest Version',
                    style: TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
