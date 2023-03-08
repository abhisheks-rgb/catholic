import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../models/church_bulletin_model.dart';

class ChurchBulletinPage extends BaseStatelessPageView {
  final ChurchBulletinModel? model;

  ChurchBulletinPage({Key? key, this.model}) : super();

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['My Parish'];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Bulletin'),
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
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InputDecorator(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.zero))),
              child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      isExpanded: true,
                      isDense: true,
                      menuMaxHeight: 40,
                      value: list.first,
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {})),
            ),
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: 6,
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 16);
                },
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      "My Parish",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Icon(
                                      FontAwesome.share_square_o,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                  ]),
                              const Text(
                                "Posted • Sun, 12 Feb 2023",
                                textAlign: TextAlign.left,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 449,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            color: const Color.fromRGBO(204, 204, 204, 1),
                          ),
                          child: SfPdfViewer.network(
                            'https://firebasestorage.googleapis.com/v0/b/mycatholicsgapp-dev.appspot.com/o/bulletin%2F2%2Fpublic%2Fpdf%2F2302281537_2302171100_Bulletin%2020230219%20(w%20links).pdf?alt=media&token=3ab00d3d-432c-4a07-b3c7-cdb2b637b874',
                            onDocumentLoaded:
                                (PdfDocumentLoadedDetails details) {
                              print(details.document.pages.count);
                            },
                          ),
                        ),
                        Container(
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 48,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.black, width: 1)),
                                    ),
                                    child: const Text(
                                      'Prev',
                                    ),
                                  ),
                                  // ignore: avoid_unnecessary_containers
                                  Container(
                                    child: const Text(
                                      'Page 1 / 2',
                                    ),
                                  ),
                                  Container(
                                    width: 48,
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(0),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              color: Colors.black, width: 1),
                                          right: BorderSide(
                                              color: Colors.black, width: 1)),
                                    ),
                                    child: const Text(
                                      'Next',
                                    ),
                                  ),
                                ],
                              )),
                              SizedBox(
                                width: 64,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 32,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        FontAwesome.download,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                    Container(
                                      width: 32,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Ionicons.expand,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
