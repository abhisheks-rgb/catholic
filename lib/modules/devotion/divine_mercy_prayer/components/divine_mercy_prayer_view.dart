import 'package:butter/butter.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:intl/intl.dart';

import '../models/divine_mercy_prayer_model.dart';
import '../../../../utils/asset_path.dart';

class DivineMercyPrayerView extends BaseStatefulPageView {
  final DivineMercyPrayerModel? model;

  DivineMercyPrayerView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _DivineMercyPrayerViewState();
}

class _DivineMercyPrayerViewState extends State<DivineMercyPrayerView> {
  @override
  void didUpdateWidget(DivineMercyPrayerView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.model?.showInfo != null) {
      if (widget.model?.showInfo == true &&
          widget.model?.showInfo != oldWidget.model?.showInfo) {
        EasyDebounce.debounce(
            'debounce-divine', const Duration(milliseconds: 100), () {
          showInfo();
        });
      }
    }
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 32),
              child: Column(
                children: [
                  _renderGuide(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderGuide() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '1. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'Make the Sign of the Cross',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'In the name of the Father, and of the Son, and of the Holy Spirit. Amen.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'Optional Opening Prayers',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'You expired, Jesus, but the source of life gushed forth for souls, and the ocean of mercy opened up for the whole world. O Fount of Life, unfathomable Divine Mercy, envelop the whole world and empty Yourself out upon us.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'O Blood and Water, which gushed forth from the Heart of Jesus as a fount of mercy for us, I trust in You! (Repeat three times)',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'Our Father',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Our Father, Who art in heaven, hallowed be Thy name; Thy kingdom come; Thy will be done on earth as it is in heaven. Give us this day our daily bread; and forgive us our trespasses as we forgive those who trespass against us; and lead us not into temptation, but deliver us from evil, Amen.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '4. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'Hail Mary',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Hail Mary, full of grace. The Lord is with thee. Blessed art thou amongst women, and blessed is the fruit of thy womb, Jesus. Holy Mary, Mother of God, pray for us sinners, now and at the hour of our death, Amen.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '5. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'The Apostles’ Creed',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'I believe in God, the Father almighty, Creator of heaven and earth, and in Jesus Christ, His only Son, our Lord, who was conceived by the Holy Spirit, born of the Virgin Mary, suffered under Pontius Pilate, was crucified, died and was buried; He descended into hell; on the third day He rose again from the dead; He ascended into heaven, and is seated at the right hand of God the Father almighty; from there He will come to judge the living and the dead. I believe in the Holy Spirit, the holy catholic Church, the communion of saints, the forgiveness of sins, the resurrection of the body, and life everlasting. Amen.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '6. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'For each of the five decades',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'On each "Our Father" bead of the rosary, pray:V. Eternal Father, I offer you the Body and Blood, soul and divinity of your dearly beloved Son, our Lord Jesus Christ,R. in atonement for our sins and those of the whole world.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'On each of the 10 "Hail Mary" beads, pray:',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          Text(
            'V. For the sake of his sorrowful Passion,',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          Text(
            'R. have mercy on us and on the whole world.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '7. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'Conclusion',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Holy God, Holy Mighty One, Holy Immortal One, have mercy on us and on the whole world.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          Text(
            '(Repeat three times)',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '8. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontWeight: FontWeight.w500,
                  fontSize: widget.model!.contentFontSize ?? 17,
                  height: 1.4,
                ),
              ),
              Expanded(
                child: Text(
                  'Optional Closing Prayers',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: widget.model!.contentFontSize ?? 17,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Closing Prayer (optional)',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          Text(
            'Eternal God, in whom mercy is endless and the treasury of compassion inexhaustible, look kindly upon us and increase your mercy in us, that in difficult moments we might not despair nor become despondent, but with great confidence submit ourselves to your holy will, which is Love and Mercy itself. Amen.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Or:',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          Text(
            '(Roman Missal, Votive Mass of the Mercy of God)',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          Text(
            'O God, whose mercies are without number and whose treasure of goodness is infinite, graciously increase the faith of the people consecrated to you, that all may grasp and rightly understand by whose love they have been created, through whose Blood they have been redeemed, and by whose Spirit they have been reborn. Through Christ our Lord. Amen.',
            style: TextStyle(
              color: const Color.fromRGBO(4, 26, 82, 1),
              fontSize: widget.model!.contentFontSize ?? 17,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _renderDivineMercyPrayer() {
    return Column(
      children: [
        Text(
          'The message of The Divine Mercy is simple. It is that God loves us – all of us. And, He wants us to recognize that His mercy is greater than our sins, so that we will call upon Him with trust, receive His mercy, and let it flow through us to others. Thus, all will come to share His joy.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'The Divine Mercy message is one we can call to mind simply by remembering ABC:',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A - Ask for His Mercy. God wants us to approach Him in prayer constantly, repenting of our sins and asking Him to pour His mercy out upon us and upon the whole world.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'B - Be merciful. God wants us to receive His mercy and let it flow through us to others. He wants us to extend love and forgiveness to others just as He does to us.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'C - Completely trust in Jesus. God wants us to know that all the graces of His mercy can only be received by our trust. The more we open the door of our hearts and lives to Him with trust, the more we can receive.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'This message and devotion to Jesus as The Divine Mercy is based on the writings of Saint Faustina Kowalska, an uneducated Polish nun who, in obedience to her spiritual director, wrote a diary of about 600 pages recording the revelations she received about God\'s mercy. Even before her death in 1938, the devotion to The Divine Mercy had begun to spread.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  void showInfo() => showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          insetPadding: const EdgeInsets.all(24),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Row(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'What is Confession?',
                        style: TextStyle(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: widget.model!.titleFontSize ?? 20,
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
                pinned: true,
                automaticallyImplyLeading: false,
                elevation: 0,
                backgroundColor: Colors.white,
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 16, 16),
                  child: _renderDivineMercyPrayer(),
                ),
              ),
            ],
          ),
        ),
      ).then((value) {
        widget.model!.setShowInfo!();
      });
}
