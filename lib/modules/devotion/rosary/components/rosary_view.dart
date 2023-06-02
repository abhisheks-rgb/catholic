import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';

import '../models/rosary_model.dart';
import '../../../../utils/asset_path.dart';

class RosaryView extends BaseStatefulPageView {
  final RosaryModel? model;

  RosaryView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _RosaryViewState();
}

class _RosaryViewState extends State<RosaryView> {
  int? _currentMystery;
  List<dynamic> mystries = [
    {
      'title': 'Joyful Mysteries (Mondays and Saturdays)',
      'title2': 'Joyful Mysteries',
      'subTitle':
          'Prayed on Mondays, Saturdays, and, during the season of Advent, on Sundays',
      'label': 'JOYFUL MYSTERY',
      'days': ['Monday', 'Saturday'],
      'mysteries': [
        '',
        'The Annunciation',
        'The Visitation',
        'The Nativity',
        'The Presentation in the Temple',
        'The Finding in the Temple',
      ],
      'passage': [
        [''],
        [
          '“In the sixth month, the angel Gabriel was sent from God to a town of Galilee called Nazareth, to a virgin betrothed to a man named Joseph, of the house of David, and the virgin\'s name was Mary.” - Luke 1:26-27'
        ],
        [
          '“During those days Mary set out and traveled to the hill country in haste to a town of Judah, where she entered the house of Zechariah and greeted Elizabeth. When Elizabeth heard Mary’s greeting, the infant leaped in her womb, and Elizabeth, filled with the Holy Spirit, cried out in a loud voice and said, \'Most blessed are you among women, and blessed is the fruit of your womb.\'” - Luke 1:39-42'
        ],
        [
          '“In those days a decree went out from Caesar Augustus that the whole world should be enrolled. This was the first enrollment, when Quirinius was governor of Syria. So all went to be enrolled, each to his own town. And Joseph too went up from Galilee from the town of Nazareth to Judea, to the city of David that is called Bethlehem, because he was of the house and family of David, to be enrolled with Mary, his betrothed, who was with child. While they were there, the time came for her to have her child, and she gave birth to her firstborn son. She wrapped him in swaddling clothes and laid him in a manger, because there was no room for them in the inn.” - Luke 2:1-7'
        ],
        [
          '“When eight days were completed for his circumcision, he was named Jesus, the name given him by the angel before he was conceived in the womb."',
          '"When the days were completed for their purification according to the law of Moses, they took him up to Jerusalem to present him to the Lord, just as it is written in the law of the Lord, \'Every male that opens the womb shall be consecrated to the Lord,\' and to offer the sacrifice of \'a pair of turtledoves or two young pigeons,\' in accordance with the dictate in the law of the Lord.” - Luke 2:21-24'
        ],
        [
          '“Each year his parents went to Jerusalem for the feast of Passover, and when he was twelve years old, they went up according to festival custom. After they had completed its days, as they were returning, the boy Jesus remained behind in Jerusalem, but his parents did not know it. Thinking that he was in the caravan, they journeyed for a day and looked for him among their relatives and acquaintances, but not finding him, they returned to Jerusalem to look for him. After three days they found him in the temple, sitting in the midst of the teachers, listening to them and asking them questions, and all who heard him were astounded at his understanding and his answers.” - Luke 2:41-47',
        ],
      ],
      'fruit': [
        '',
        'Humility',
        'Love of Neighbor',
        'Poverty',
        'Purity of Heart and Body',
        'Devotion to Jesus',
      ],
    },
    {
      'title': 'Sorrowful Mysteries (Tuesdays and Fridays)',
      'title2': 'Sorrowful Mysteries',
      'subTitle':
          'Prayed on Tuesdays, Fridays, and, during the season of Lent, on Sundays',
      'label': 'SORROWFUL MYSTERY',
      'days': ['Tuesday', 'Friday'],
      'mysteries': [
        '',
        'The Agony in the Garden',
        'The Scourging at the Pillar',
        'The Crowning with Thorns',
        'The Carrying of the Cross',
        'The Crucifixion and Death',
      ],
      'passage': [
        [''],
        [
          '“Then Jesus came with them to a place called Gethsemane, and he said to his disciples, \'Sit here while I go over there and pray.\' He took along Peter and the two sons of Zebedee, and began to feel sorrow and distress. Then he said to them, \'My soul is sorrowful even to death. Remain here and keep watch with me.\' He advanced a little and fell prostrate in prayer, saying, \'My Father, if it is possible, let this cup pass from me; yet, not as I will, but as you will.\'” - Matthew 26:36-39',
        ],
        [
          '“Then he released Barabbas to them, but after he had Jesus scourged, he handed him over to be crucified.” - Matthew 27:26',
        ],
        [
          '“Then the soldiers of the governor took Jesus inside the praetorium and gathered the whole cohort around him. They stripped off his clothes and threw a scarlet military cloak about him. Weaving a crown out of thorns, they placed it on his head, and a reed in his right hand. And kneeling before him, they mocked him, saying, \'Hail, King of the Jews!\'” - Matthew 27:27-29',
        ],
        [
          '“They pressed into service a passer-by, Simon, a Cyrenian, who was coming in from the country, the father of Alexander and Rufus, to carry his cross. They brought him to the place of Golgotha (which is translated Place of the Skull).” - Mark 15:21-22',
        ],
        [
          '“When they came to the place called the Skull, they crucified him and the criminals there, one on his right, the other on his left. [Then Jesus said, \'Father, forgive them, they know not what they do.\'] They divided his garments by casting lots. The people stood by and watched; the rulers, meanwhile, sneered at him and said, \'He saved others, let him save himself if he is the chosen one, the Messiah of God.\' Even the soldiers jeered at him. As they approached to offer him wine they called out, \'If you are King of the Jews, save yourself.\' Above him there was an inscription that read, \'This is the King of the Jews.\' Now one of the criminals hanging there reviled Jesus, saying, \'Are you not the Messiah? Save yourself and us.\' The other, however, rebuking him, said in reply, \'Have you no fear of God, for you are subject to the same condemnation? And indeed, we have been condemned justly, for the sentence we received corresponds to our crimes, but this man has done nothing criminal.\' Then he said, \'Jesus, remember me when you come into your kingdom.\' He replied to him, \'Amen, I say to you, today you will be with me in Paradise.\'"',
          '"It was now about noon and darkness came over the whole land until three in the afternoon because of an eclipse of the sun. Then the veil of the temple was torn down the middle. Jesus cried out in a loud voice, \'Father, into your hands I commend my spirit\'; and when he had said this he breathed his last.” - Luke 23:33-46',
        ],
      ],
      'fruit': [
        '',
        'Obedience to God\'s Will',
        'Mortification',
        'Courage',
        'Patience',
        'Sorrow for our sins',
      ],
    },
    {
      'title': 'Glorious Mysteries (Wednesdays and Sundays)',
      'title2': 'Glorious Mysteries',
      'subTitle':
          'Prayed on Wednesdays and, outside the seasons of Advent and Lent, on Sundays',
      'label': 'GLORIOUS MYSTERY',
      'days': ['Wednesday', 'Sunday'],
      'mysteries': [
        '',
        'The Resurrection',
        'The Ascension',
        'The Descent of the Holy Spirit',
        'The Assumption',
        'The Coronation of Mary',
      ],
      'passage': [
        [''],
        [
          '“But at daybreak on the first day of the week they took the spices they had prepared and went to the tomb.They found the stone rolled away from the tomb; but when they entered, they did not find the body of the Lord Jesus. While they were puzzling over this, behold, two men in dazzling garments appeared to them. They were terrified and bowed their faces to the ground. They said to them, \'Why do you seek the living one among the dead? He is not here, but he has been raised.\'” - Luke 24:1-5',
        ],
        [
          '“So then the Lord Jesus, after he spoke to them, was taken up into heaven and took his seat at the right hand of God.” - Mark 16:19',
        ],
        [
          '“When the time for Pentecost was fulfilled, they were all in one place together. And suddenly there came from the sky a noise like a strong driving wind, and it filled the entire house in which they were. Then there appeared to them tongues as of fire, which parted and came to rest on each one of them. And they were all filled with the holy Spirit and began to speak in different tongues, as the Spirit enabled them to proclaim.” - Acts 2:1-4',
        ],
        [
          '“Behold, from now on will all ages call me blessed. The Mighty One has done great things for me, and holy is his name.” - Luke 1:48-49',
        ],
        [
          '“A great sign appeared in the sky, a woman clothed with the sun, with the moon under her feet, and on her head a crown of twelve stars.” - Revelation 12:1',
        ],
      ],
      'fruit': [
        '',
        'Faith',
        'Hope',
        'Wisdom',
        'Devotion to Mary',
        'Grace of a happy death',
      ],
    },
    {
      'title': 'Luminous Mysteries (Thursdays)',
      'title2': 'Luminous Mysteries',
      'subTitle': 'Prayed on Thursdays',
      'label': 'LUMINOUS MYSTERY',
      'days': ['Thursday'],
      'mysteries': [
        '',
        'The Baptism of Christ in the Jordan',
        'The Wedding Feast at Cana',
        'Jesus\' Proclamation of the Coming of the Kingdom of God',
        'The Transfiguration',
        'The Institution of the Eucharist',
      ],
      'passage': [
        [''],
        [
          '“After Jesus was baptized, he came up from the water and behold, the heavens were opened [for him], and he saw the Spirit of God descending like a dove [and] coming upon him. And a voice came from the heavens, saying, \'This is my beloved Son, with whom I am well pleased.\'” - Matthew 3:16-17',
        ],
        [
          '“On the third day there was a wedding in Cana in Galilee, and the mother of Jesus was there. Jesus and his disciples were also invited to the wedding. When the wine ran short, the mother of Jesus said to him, \'They have no wine.\' [And] Jesus said to her, \'Woman, how does your concern affect me? My hour has not yet come.\' His mother said to the servers, \'Do whatever he tells you.\'” - John 2:1-5',
        ],
        [
          '“\'This is the time of fulfillment. The kingdom of God is at hand. Repent, and believe in the gospel.\'” - Mark 1:15',
        ],
        [
          '“After six days Jesus took Peter, James, and John his brother, and led them up a high mountain by themselves. And he was transfigured before them; his face shone like the sun and his clothes became white as light.” - Matthew 17:1-2',
        ],
        [
          '“While they were eating, Jesus took bread, said the blessing, broke it, and giving it to his disciples said, \'Take and eat; this is my body.\'” - Matthew 26:26',
        ],
      ],
      'fruit': [
        '',
        'Openness to the Holy Spirit',
        'To Jesus through Mary',
        'Conversion',
        'Desire for holiness',
        'Adoration',
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
  void didUpdateWidget(RosaryView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.model?.showInfo != null) {
      if (widget.model?.showInfo == true &&
          widget.model?.showInfo != oldWidget.model?.showInfo) {
        handleShowInfo();
      }
    }
  }

  void handleShowInfo() async {
    await Future.delayed(const Duration(milliseconds: 500), () async {
      showInfo();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.model!.setShowInfo!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  assetPath('pray_banner.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
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
            Positioned(
              left: 0,
              top: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 100,
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
            Container(
              width: double.infinity,
              height: 105,
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
            Column(
              children: [
                _renderPrayer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderPrayer() {
    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Color(0x142c0807),
                offset: Offset(0, 8),
                blurRadius: 8,
              ),
            ],
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
                            color: Color.fromRGBO(4, 26, 82, 1),
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
        mystries[_currentMystery!] == null ? Container() : _renderGuide(),
        _renderHailHolyQueen(),
        _renderMemorare(),
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
              label = 'FIRST';
              break;
            case 2:
              label = 'SECOND';
              break;
            case 3:
              label = 'THIRD';
              break;
            case 4:
              label = 'FOURTH';
              break;
            case 5:
              label = 'FIFTH';
              break;
            default:
          }

          label = '$label ${mystries[_currentMystery!]['label']}';

          return Column(
            children: [
              element == ''
                  ? _renderApostlesCreed()
                  : _renderMystery(label, element, index),
              _renderOurFather(),
              _renderHailMary(element == '' ? '3' : '10'),
              _renderGloryBe(),
              element == '' ? Container() : _renderFatimaPrayer(),
            ],
          );
        }).toList(),
      );

  Widget _renderApostlesCreed() => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Apostles Creed',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I believe in God, the Father Almighty, Creator of heaven and earth.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I believe in Jesus Christ, his only Son, our Lord, who was conceived by the Holy Spirit and born of the Virgin Mary. He suffered under Pontius Pilate, was crucified, died, and was buried; he descended to hell. The third day he rose again from the dead. He ascended to heaven and is seated at the right hand of God the Father almighty. From there he will come to judge the living and the dead.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'I believe in the Holy Spirit, the Holy Catholic Church, the communion of saints, the forgiveness of sins, the resurrection of the body, and the life everlasting. Amen.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _renderMystery(String label, String mystery, int index) => Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(164, 187, 244, 0.5),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: const Color.fromRGBO(164, 187, 244, 1),
          ),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: TextStyle(
                color: const Color.fromRGBO(8, 51, 158, 1),
                fontWeight: FontWeight.w500,
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              mystery,
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w500,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Column(
              children: mystries[_currentMystery!]['passage'][index]
                  .map<Widget>((passage) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    passage,
                    style: TextStyle(
                      color: const Color.fromRGBO(4, 26, 82, 1),
                      fontSize: widget.model!.contentFontSize ?? 17,
                      height: 1.4,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fruit of the mystery: ${mystries[_currentMystery!]['fruit'][index]}',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      );

  Widget _renderOurFather() => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Our Father',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Our Father, Who art in heaven, Hallowed be Thy Name. Thy Kingdom come. Thy Will be done, on earth as it is in Heaven.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Give us this day our daily bread. And forgive us our trespasses, as we forgive those who trespass against us. And lead us not into temptation, but deliver us from evil. Amen.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _renderHailMary(String repeat) => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Hail Mary ${repeat.isNotEmpty ? 'x$repeat' : ''}',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hail, Mary, full of grace, the Lord is with thee. Blessed art thou amongst women and blessed is the fruit of thy womb, Jesus.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death. Amen.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _renderGloryBe() => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Glory Be',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Glory be to the Father, the Son, and the Holy Spirit; as it was in the beginning, is now, and ever shall be, world without end. Amen.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _renderFatimaPrayer() => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Fatima Prayer',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'O my Jesus, forgive us our sins, save us from the fires of hell; lead all souls to Heaven, especially those who have most need of your mercy. Amen',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _renderHailHolyQueen() => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Hail Holy Queen',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Hail, holy Queen, Mother of mercy, our life, our sweetness and our hope. To thee do we cry, poor banished children of Eve. To thee do we send up our sighs, mourning and weeping in this valley of tears. Turn then, most gracious advocate, thine eyes of mercy toward us, and after this our exile, show unto us the blessed fruit of thy womb, Jesus. O clement, O loving, O sweet Virgin Mary!',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Leader: Pray for us O Holy Mother of God,',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Text(
              'All: That we may be made worthy of the promises of Christ.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Leader: Let us pray.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'All: O God whose only begotten Son by his life, death, and resurrection has purchased for us the rewards of eternal life, grant we beseech Thee, that meditating upon these mysteries of the Most Holy Rosary of the Blessed Virgin Mary, we may imitate what they contain and obtain what they promise through the same Christ our Lord. Amen.',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );

  Widget _renderMemorare() => Container(
        margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Text(
              'Memorare',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontWeight: FontWeight.w600,
                fontSize: widget.model!.titleFontSize ?? 20,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Remember, O most gracious Virgin Mary, that never was it known that anyone who fled to thy protection, implored thy help, or sought thy intercession was left unaided. Inspired with this confidence, I fly to thee, O Virgin of virgins, my Mother; to thee do I come; before thee I stand, sinful and sorrowful. O Mother of the Word Incarnate, despise not my petitions, but in thy mercy hear and answer me. Amen',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      );

  Widget _renderRosary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'The Rosary is a set of prayers and meditations in the Catholic tradition. It consists of a string of beads or knots that are used to keep track of the prayers recited. The prayers focus on the life, ministry, death, and resurrection of Jesus Christ, as well as the intercession of the Virgin Mary.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The structure of the Rosary includes various prayers,',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. ',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'The Apostles\' Creed: This is a statement of faith, affirming the basic beliefs of Christianity.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'The Our Father: Also known as the Lord\'s Prayer, it was taught by Jesus to his disciples.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'The Hail Mary: This prayer is a meditation on the Incarnation and seeks the intercession of the Virgin Mary.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'The Glory Be: A short prayer praising the Holy Trinity.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'The Mysteries: The Rosary is divided into sets of mysteries, which are meditations on significant events in the lives of Jesus and Mary. The mysteries are categorized as Joyful, Sorrowful, Glorious, and Luminous (added by Pope John Paul II in 2002).',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'The Rosary is a popular devotion among Catholics for several reasons:',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. ',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'It fosters meditation: The repetitive nature of the prayers allows individuals to enter a contemplative state, focusing their minds on the mysteries of Christ\'s life. It provides an opportunity for spiritual reflection and deeper connection with God.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'It invokes the intercession of Mary: Catholics believe that Mary, as the Mother of Jesus, holds a special place in the life of the Church. Praying the Rosary is a way to seek her intercession and guidance.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'It builds a sense of community: Many Catholics pray the Rosary together in groups or as a family. This communal aspect strengthens bonds among believers and provides a shared spiritual experience.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
                height: 1.4,
              ),
            ),
            Expanded(
              child: Text(
                'It offers spiritual benefits: The Catholic Church teaches that the Rosary brings numerous spiritual benefits, including increased faith, inner peace, and graces from God.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'The Rosary can be a valuable spiritual practice that helps deepen one\'s relationship with God and the Church. It allows them to engage in a structured prayer form that has been cherished by generations of Catholics. Praying the Rosary can also provide a sense of belonging and connection to the broader Catholic community.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The purpose of the Rosary is to help keep in memory certain principal events in the history of our salvation. There are twenty mysteries reflected upon in the Rosary, and these are divided into the five Joyful Mysteries (said on Monday and Saturday), the five Luminous Mysteries (said on Thursday), the five Sorrowful Mysteries (said on Tuesday and Friday), and the five Glorious Mysteries (said on Wednesday and Sunday). As an exception, the Joyful Mysteries may be said on Sundays during Advent and Christmas, while the Sorrowful Mysteries may be said on the Sundays of Lent.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The question is sometimes asked, why, of all the incidents in our Lord\'s life, the Rosary only considers these particular twenty. The mysteries of the Rosary are based on the incidents in the life of Our Lord and His Mother that are celebrated in the Liturgy. There is a parallel between the main feasts honoring our Lord and his Mother in the liturgical year, and the twenty mysteries of the Rosary. Consequently, one who recites the twenty mysteries of the Rosary in one day reflects on the whole liturgical cycle that the Church commemorates during the course of each year. That is why some of the Popes have referred to the Rosary as a compendium of the Gospel. One cannot change the mysteries of the Rosary without losing the indulgences that the Church grants for the recitation of the Rosary.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
      ],
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
            padding: const EdgeInsets.fromLTRB(24, 16, 16, 14),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Select Mystery',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      shape: const CircleBorder(),
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: Icon(
                          MaterialCommunityIcons.close_circle,
                          color: Color.fromRGBO(130, 141, 168, 1),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 18, 0),
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: mystries.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return Container();
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                _currentMystery = index;
                              });

                              Navigator.pop(context);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        mystries[index]['title2'],
                                        style: const TextStyle(
                                          color: Color.fromRGBO(4, 26, 82, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        mystries[index]['subTitle'],
                                        style: const TextStyle(
                                          color: Color.fromRGBO(4, 26, 82, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          index == mystries.length - 1
                              ? Container()
                              : Column(
                                  children: const [
                                    SizedBox(height: 20),
                                    Divider(
                                      height: 1,
                                      thickness: 1,
                                      indent: 0,
                                      endIndent: 0,
                                      color: Color.fromRGBO(4, 26, 82, 0.1),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  void showInfo() => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          insetPadding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'What is the Rosary?',
                              style: TextStyle(
                                color: const Color.fromRGBO(4, 26, 82, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: widget.model!.titleFontSize ?? 20,
                              ),
                            ),
                          ),
                          RawMaterialButton(
                            constraints: const BoxConstraints(),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            shape: const CircleBorder(),
                            child: const SizedBox(
                              width: 24,
                              height: 24,
                              child: Icon(
                                MaterialCommunityIcons.close_circle,
                                color: Color.fromRGBO(130, 141, 168, 1),
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _renderRosary(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ).then((value) {
        widget.model!.setShowInfo!();
      });
}
