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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Scripture Reflection'),
        elevation: 0,
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      body: model?.loading == true
        ? Container(
            height: MediaQuery.of(context).size.height * 0.74,
            margin: const EdgeInsets.only(top: 16),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        :
      SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _item['contentTitle'],
                style: const TextStyle(
                  color: Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              Html(
                data: _item['content'] ?? '---',
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
                  ),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}