import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scripture_details_model.dart';

class ScriptureDetailsView extends BaseStatelessPageView {
  final ScriptureDetailsModel? model;
  final Map _item;

  ScriptureDetailsView(this.model, {Key? key})
      : _item = model?.item as Map,
        super();

  @override
  Widget build(BuildContext context) {
    String content = _item['content'] ?? '---';

    if (_item.isNotEmpty) {
      if (_item['content'].contains(_item['contentTitle'])) {
        content =
            content.replaceFirst('<h2>${_item['contentTitle']}</h2><br/>', '');
      }
    }

    return Scaffold(
      body: model?.loading == true
          ? Container(
              height: MediaQuery.of(context).size.height * 0.74,
              margin: const EdgeInsets.only(top: 16),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 8),
                      child: Text(
                        _item['contentTitle'],
                        style: const TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Html(
                      data: content,
                      onLinkTap: (url, context, attributes, element) async {
                        final uri = Uri.parse(url ?? '');
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode.externalApplication,
                          );
                        } else {
                          throw 'Could not launch $uri';
                        }
                      },
                      style: {
                        'body': Style(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: FontSize(16),
                          textAlign: TextAlign.left,
                        ),
                        'div': Style(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: FontSize(16),
                          textAlign: TextAlign.left,
                        ),
                        'p': Style(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: FontSize(16),
                          textAlign: TextAlign.left,
                        ),
                      },
                    ),
                    // TODO Universalis credit
                  ],
                ),
              ),
            ),
    );
  }
}
