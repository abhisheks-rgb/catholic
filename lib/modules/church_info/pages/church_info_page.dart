import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/church_info_model.dart';

import '../../../utils/asset_path.dart';

class ChurchInfoPage extends BaseStatelessPageView {
  final ChurchInfoModel? model;

  ChurchInfoPage({Key? key, this.model}) : super();

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['My Parish'];
    const List<dynamic> list2 = <dynamic>[
      {'title': 'Bulletin', 'route': 'church_bulletin'},
      {'title': 'Schedule', 'route': 'church_bulletin'},
      {'title': 'Confession Times', 'route': 'church_bulletin'},
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Church Info'),
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
      body: SingleChildScrollView(
        child: Container(
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
                        items:
                            list.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {})),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 492,
                width: double.infinity,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                      width: double.infinity,
                      child: Image.asset(
                        assetPath('welcome_bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(
                      height: 28,
                      width: double.infinity,
                      child: Text('My Parish', style: TextStyle(fontSize: 24)),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(
                            AntDesign.infocirlce,
                            color: Colors.black,
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '24 Highland Road Singapore 549115',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              RichText(
                                textAlign: TextAlign.start,
                                text: TextSpan(
                                  text: '',
                                  style: DefaultTextStyle.of(context).style,
                                  children: const <TextSpan>[
                                    TextSpan(
                                        text: 'Address',
                                        style: TextStyle(
                                            color: Color.fromRGBO(
                                                119, 119, 119, 1))),
                                    TextSpan(
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(119, 119, 119, 1)),
                                      text: ' • ',
                                    ),
                                    TextSpan(
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(12, 72, 224, 1)),
                                        children: [
                                          TextSpan(text: 'Direction '),
                                          WidgetSpan(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2.0),
                                              child: Icon(Icons.directions,
                                                  color: Color.fromRGBO(
                                                      12, 72, 224, 1)),
                                            ),
                                          ),
                                        ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(
                            AntDesign.infocirlce,
                            color: Colors.black,
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                '+65 1234 5678',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Contact',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(
                            AntDesign.infocirlce,
                            color: Colors.black,
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Rev Fr John Desal',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Priest',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(
                            AntDesign.infocirlce,
                            color: Colors.black,
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'info@ihm.sg',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const Icon(
                            AntDesign.infocirlce,
                            color: Colors.black,
                            size: 40,
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'www.ihm.sg',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                'Website',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color.fromRGBO(119, 119, 119, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      height: 1,
                      color: Color.fromRGBO(204, 204, 204, 1),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 69,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: const [
                              Icon(
                                MaterialIcons.facebook,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(height: 8.52),
                              Text(
                                'Facebook',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Entypo.twitter_with_circle,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(height: 8.52),
                              Text(
                                'Twitter',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: const [
                              Icon(
                                Entypo.instagram_with_circle,
                                color: Colors.black,
                                size: 40,
                              ),
                              SizedBox(height: 8.52),
                              Text(
                                'Instagram',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 136,
                width: double.infinity,
                child: GridView.builder(
                  itemCount: list2.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemBuilder: (_, int index) {
                    return InkWell(
                        onTap: () {
                          model?.showPage('/_/${list2[index]['route']}');
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(8, 18, 8, 18),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              const Icon(
                                AntDesign.infocirlce,
                                color: Colors.black,
                                size: 24,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                list2[index]['title'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
