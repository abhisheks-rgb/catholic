import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/schedules_model.dart';

class SchedulesPage extends BaseStatelessPageView {
  final SchedulesModel? model;

  SchedulesPage({Key? key, this.model}) : super();

  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['My Parish'];
    final List<String> entries = <String>[
      'All',
      'Devotion (DV)',
      'Holy Hour (HH)',
      'Station of the Cross (SC)',
      'Mass (M)',
      'Ash Wednesday (AW)'
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Mass Schedule'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).popAndPushNamed('/_/welcome');
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
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('My Parish',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 4),
                      const Text('Main Church, Chapel',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 4),
                      const Text('English • Mandarin • Tamil',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400)),
                      const SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Church Info',
                                style: TextStyle(
                                    color: Color.fromRGBO(12, 72, 224, 1))),
                            TextSpan(
                              style: TextStyle(
                                  color: Color.fromRGBO(12, 72, 224, 1)),
                              text: ' • ',
                            ),
                            TextSpan(
                                style: TextStyle(
                                    color: Color.fromRGBO(12, 72, 224, 1)),
                                children: [
                                  TextSpan(text: 'Direction '),
                                  WidgetSpan(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      child: Icon(Icons.directions,
                                          color:
                                              Color.fromRGBO(12, 72, 224, 1)),
                                    ),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ],
                  )),
              Container(
                  height: 35,
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: entries.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return FilledButton(
                            onPressed: () {}, child: Text(entries[index]));
                      } else {
                        return FilledButton(
                            onPressed: () {}, child: Text(entries[index]));
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 8,
                    ),
                  )),
              Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: 123,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 8);
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text("Today"),
                                          Text("12 Feb 23"),
                                        ]),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                                ListView.separated(
                                    itemCount: 2,
                                    separatorBuilder: (context, index) {
                                      return const SizedBox(height: 8);
                                    },
                                    physics: const ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text("5:30 PM",
                                                style: TextStyle(fontSize: 24)),
                                            Text("English • Main Church",
                                                style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      );
                                    }),
                              ],
                            ));
                      }))
            ]),
      ),
    );
  }
}
