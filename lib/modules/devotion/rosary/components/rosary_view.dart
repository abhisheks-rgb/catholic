import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

import '../models/rosary_model.dart';

class RosaryView extends BaseStatefulPageView {
  final RosaryModel? model;

  RosaryView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _RosaryViewState();
}

class _RosaryViewState extends State<RosaryView> {
  int _selected = 0;
  int? _currentMystery;
  List<dynamic> mystries = [
    {
      'title': 'Joyful Mysteries (Mondays and Saturdays)',
      'label': 'JOYFUL MYSTERY',
      'days': ['Monday', 'Saturday'],
      'mysteries': [
        '',
        'THE ANNOUNCIATION',
        'THE VISITATION',
        'THE NATIVITY',
        'THE PRESENTATION',
        'THE FINDING OF THE CHILD JESUS IN THE TEMPLE',
      ],
    },
    {
      'title': 'Sorrowful Mysteries (Tuesdays and Fridays)',
      'label': 'SORROWFUL MYSTERY',
      'days': ['Tuesday', 'Friday'],
      'mysteries': [
        '',
        'THE AGONY OF JESUS IN THE GARDEN',
        'THE SCOURGING AT THE PILLAR',
        'THE CROWNING WITH THORNS',
        'THE CARRYING OF THE CROSS',
        'THE CRUCIFIXION',
      ],
    },
    {
      'title': 'Glorious Mysteries (Wednesdays and Sundays)',
      'label': 'GLORIOUS MYSTERY',
      'days': ['Wednesday', 'Sunday'],
      'mysteries': [
        '',
        'THE RESURRECTION',
        'THE ASCENSION',
        'THE DESCENT OF THE HOLY SPIRIT',
        'THE ASSUMPTION OF MARY, THE MOTHER OF GOD, INTO HEAVEN',
        'THE CORONATION OF MARY IN HEAVEN',
      ],
    },
    {
      'title': 'Luminous Mysteries (Thursdays)',
      'label': 'LUMINOUS MYSTERY',
      'days': ['Thursday'],
      'mysteries': [
        '',
        'THE BAPTISM IN THE RIVER JORDAN',
        'THE WEDDING FEAST AT CANA',
        'THE PREACHING OF THE COMING OF THE KINGDOM OF GOD',
        'THE TRANSFIGURATION',
        'THE INSTITUTION OF THE HOLY EUCHARIST',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();

    checkDay();
  }

  void checkDay() {
    for (var e in mystries) {
      if (e['days'].contains(DateFormat('EEEE').format(DateTime.now()))) {
        final index =
            mystries.indexWhere((item) => item['title'] == e['title']);

        if (index > -1) {
          setState(() {
            _currentMystery = index;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            if (_selected != 0) {
                              setState(() {
                                _selected = 0;
                              });
                            }
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Prayer Guide',
                                style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: _selected != 0
                                      ? Colors.transparent
                                      : const Color.fromRGBO(217, 217, 217, 1),
                                  decorationThickness: 4,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            if (_selected != 1) {
                              setState(() {
                                _selected = 1;
                              });
                            }
                          },
                          child: Column(
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'What is a Rosary?',
                                style: TextStyle(
                                  shadows: const [
                                    Shadow(
                                        color: Colors.black,
                                        offset: Offset(0, -5))
                                  ],
                                  color: Colors.transparent,
                                  decoration: TextDecoration.underline,
                                  decorationColor: _selected != 1
                                      ? Colors.transparent
                                      : const Color.fromRGBO(217, 217, 217, 1),
                                  decorationThickness: 4,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _selected == 0 ? _renderPrayer() : _renderRosary(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderPrayer() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(217, 217, 217, 1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onPressed: () {
              showMysteriesList(context);
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          _currentMystery == null
                              ? mystries[0]['title']
                              : mystries[_currentMystery!]['title'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: Icon(
                          Entypo.chevron_down,
                          color: Color.fromRGBO(4, 26, 82, 1),
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        mystries[_currentMystery!] == null ? Container() : _renderGuide()
      ],
    );
  }

  Widget _renderGuide() => Column(
        children:
            mystries[_currentMystery!]['mysteries'].map<Widget>((element) {
          final index = mystries[_currentMystery!]['mysteries']
              .indexWhere((item) => item == element);
          var label = '';

          switch (index) {
            case 1:
              label = 'THE 1ST ${mystries[_currentMystery!]['label']}:';
              break;
            case 2:
              label = 'THE 2ND ${mystries[_currentMystery!]['label']}:';
              break;
            case 3:
              label = 'THE 3RD ${mystries[_currentMystery!]['label']}:';
              break;
            case 4:
              label = 'THE 4TH ${mystries[_currentMystery!]['label']}:';
              break;
            case 5:
              label = 'THE 5TH ${mystries[_currentMystery!]['label']}:';
              break;
            default:
          }

          return Column(
            children: [
              element == ''
                  ? _renderApostlesCreed()
                  : _renderMystery(label, element),
              _renderOurFather(),
              _renderHailMary(element == '' ? '3' : '10'),
              _renderGloryBe(),
              element == '' ? Container() : _renderFatimaPrayer(),
            ],
          );
        }).toList(),
      );

  Widget _renderApostlesCreed() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Apostles Creed',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: widget.model!.titleFontSize ?? 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I believe in God, the Father almighty, creator of heaven and earth.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I believe in Jesus Christ, his only Son, our Lord, who was conceived by the Holy Spirit and born of the virgin Mary. He suffered under Pontius Pilate, was crucified, died, and was buried; he descended to hell. The third day he rose again from the dead. He ascended to heaven and is seated at the right hand of God the Father almighty. From there he will come to judge the living and the dead.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'I believe in the Holy Spirit, the holy catholic church, the communion of saints, the forgiveness of sins, the resurrection of the body, and the life everlasting. Amen.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _renderMystery(String label, String mystery) => Column(
        children: [
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              mystery,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _renderOurFather() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Our Father',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: widget.model!.titleFontSize ?? 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _renderHailMary(String repeat) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Hail Mary ${repeat.isNotEmpty ? 'x$repeat' : ''}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: widget.model!.titleFontSize ?? 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Hail, Mary, full of grace,the Lord is with thee.Blessed art thou amongst womenand blessed is the fruit of thy womb, Jesus.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Holy Mary, Mother of God,pray for us sinners,now and at the hour of our death. Amen.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _renderGloryBe() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Glory Be',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: widget.model!.titleFontSize ?? 20,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Glory be to the Father, the Son, and the Holy Spirit; as it was in the beginning, is now, and ever shall be, world without end. Amen.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _renderFatimaPrayer() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text(
            'Fatima Prayer',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'O my Jesus, forgive us our sins, save us from the fires of hell; lead all souls to Heaven, especially those who have most need of your mercy. Amen',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _renderRosary() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          Text(
            'A rosary is a set of prayers and meditations in the Catholic tradition. It consists of a string of beads or knots that are used to keep track of the prayers recited. The prayers focus on the life, ministry, death, and resurrection of Jesus Christ, as well as the intercession of the Virgin Mary.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The structure of the rosary includes various prayers,',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The Apostles\' Creed: This is a statement of faith, affirming the basic beliefs of Christianity.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The Our Father: Also known as the Lord\'s Prayer, it was taught by Jesus to his disciples.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The Hail Mary: This prayer is a meditation on the Incarnation and seeks the intercession of the Virgin Mary.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '4. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The Glory Be: A short prayer praising the Holy Trinity.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '5. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The Mysteries: The rosary is divided into sets of mysteries, which are meditations on significant events in the lives of Jesus and Mary. The mysteries are categorized as Joyful, Sorrowful, Glorious, and Luminous (added by Pope John Paul II in 2002).',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'The rosary is a popular devotion among Catholics for several reasons:',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'It fosters meditation: The repetitive nature of the prayers allows individuals to enter a contemplative state, focusing their minds on the mysteries of Christ\'s life. It provides an opportunity for spiritual reflection and deeper connection with God.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'It invokes the intercession of Mary: Catholics believe that Mary, as the Mother of Jesus, holds a special place in the life of the Church. Praying the rosary is a way to seek her intercession and guidance.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'It builds a sense of community: Many Catholics pray the rosary together in groups or as a family. This communal aspect strengthens bonds among believers and provides a shared spiritual experience.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '4. ',
                style: TextStyle(
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'It offers spiritual benefits: The Catholic Church teaches that the rosary brings numerous spiritual benefits, including increased faith, inner peace, and graces from God.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'The rosary can be a valuable spiritual practice that helps deepen their relationship with God and the Church. It allows them to engage in a structured prayer form that has been cherished by generations of Catholics. Praying the rosary can also provide a sense of belonging and connection to the broader Catholic community.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The purpose of the Rosary is to help keep in memory certain principal events in the history of our salvation. There are twenty mysteries reflected upon in the Rosary, and these are divided into the five Joyful Mysteries (said on Monday and Saturday), the five Luminous Mysteries (said on Thursday), the five Sorrowful Mysteries (said on Tuesday and Friday), and the five Glorious Mysteries (said on Wednesday and Sunday). As an exception, the Joyful Mysteries may be said on Sundays during Advent and Christmas, while the Sorrowful Mysteries may be said on the Sundays of Lent.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The question is sometimes asked, why, of all the incidents in our Lord\'s life, the Rosary only considers these particular twenty. The mysteries of the Rosary are based on the incidents in the life of Our Lord and His Mother that are celebrated in the Liturgy. There is a parallel between the main feasts honoring our Lord and his Mother in the liturgical year, and the twenty mysteries of the Rosary. Consequently, one who recites the twenty mysteries of the Rosary in one day reflects on the whole liturgical cycle that the Church commemorates during the course of each year. That is why some of the Popes have referred to the Rosary as a compendium of the Gospel. One cannot change the mysteries of the Rosary without losing the indulgences that the Church grants for the recitation of the Rosary.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void showMysteriesList(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          insetPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: mystries.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Container();
                  },
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currentMystery = index;
                        });

                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                        child: Text(
                          mystries[index]['title'],
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: widget.model!.titleFontSize ?? 20,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
