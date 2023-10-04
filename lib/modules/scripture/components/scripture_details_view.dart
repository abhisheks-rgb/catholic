import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/scripture_details_model.dart';
import '../../../utils/asset_path.dart';

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
              physics: const ClampingScrollPhysics(),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        height: 85,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          assetPath('pray_banner.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(0.957, -1.211),
                              end: const Alignment(0.515, 1),
                              colors: <Color>[
                                const Color(0x51ffffff).withOpacity(0.2),
                                const Color(0xffffffff).withOpacity(0.9)
                              ],
                              stops: const <double>[0, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 85,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(1, -1),
                              end: Alignment(-1, 1),
                              colors: <Color>[
                                Color.fromRGBO(24, 77, 212, 0.3),
                                Color.fromRGBO(255, 255, 255, 0.3)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 100,
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 24, horizontal: 16),
                    child: SelectionArea(
                      selectionControls: MaterialTextSelectionControls(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 8),
                            child: Text(
                              _item['contentTitle'],
                              style: TextStyle(
                                color: const Color.fromRGBO(4, 26, 82, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: model!.titleFontSize ?? 20,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Html(
                            data: content,
                            onLinkTap: (url, _, __) async {
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
                                fontSize: FontSize(model!.titleFontSize ?? 16),
                                textAlign: TextAlign.left,
                                lineHeight: const LineHeight(1.4),
                              ),
                              'div': Style(
                                color: const Color.fromRGBO(4, 26, 82, 1),
                                fontSize: FontSize(model!.titleFontSize ?? 16),
                                textAlign: TextAlign.left,
                                lineHeight: const LineHeight(1.4),
                              ),
                              'p': Style(
                                color: const Color.fromRGBO(4, 26, 82, 1),
                                fontSize: FontSize(model!.titleFontSize ?? 16),
                                textAlign: TextAlign.left,
                                lineHeight: const LineHeight(1.4),
                              ),
                              'span': Style(
                                color: const Color.fromRGBO(4, 26, 82, 1),
                                fontSize: FontSize(model!.titleFontSize ?? 16),
                                textAlign: TextAlign.left,
                                lineHeight: const LineHeight(1.4),
                              ),
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
