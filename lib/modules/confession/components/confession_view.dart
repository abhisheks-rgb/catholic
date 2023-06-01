import 'package:butter/butter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/confession_model.dart';
import '../../../../utils/asset_path.dart';

class ConfessionView extends BaseStatefulPageView {
  final ConfessionModel? model;

  ConfessionView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _ConfessionViewState();
}

class _ConfessionViewState extends State<ConfessionView> {
  @override
  void didUpdateWidget(ConfessionView oldWidget) {
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Bless yourself with the Sign of the Cross.',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Say  “Bless me, Father, for I have sinned. It\'s been [however many days/months/years] since my last confession.”',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '3. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: const Color.fromRGBO(4, 26, 82, 1),
                        fontSize: widget.model!.contentFontSize ?? 17,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'Say '),
                        TextSpan(
                          text: '"My sins are..."',
                          style: TextStyle(
                            color: Color.fromRGBO(4, 26, 82, 1),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '[List your sins here]',
                    style: TextStyle(
                      color: const Color.fromRGBO(4, 26, 82, 1),
                      fontSize: widget.model!.contentFontSize ?? 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '4. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: widget.model!.contentFontSize ?? 17,
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: 'Say '),
                          TextSpan(
                            text:
                                '“I will try not to do these things that are wrong anymore. For these and all of my sins, I am truly sorry”',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '5. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Listen to the penance and advice that the priest accords to you.',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '6. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: widget.model!.contentFontSize ?? 17,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  'When invited by the priest, say Act of Contrition: '),
                          TextSpan(
                            text:
                                '“Oh my God, I am very sorry that I have sinned against you. Because you are so good, and with your help and grace. I will try not to sin again.”',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '7. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The priest will then give an Absolution and Final Blessing',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '8. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: const Color.fromRGBO(4, 26, 82, 1),
                          fontSize: widget.model!.contentFontSize ?? 17,
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: 'Say '),
                          TextSpan(
                            text: '“Amen”',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          TextSpan(text: ' and thank the priest.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '9. ',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Return to the pew to do the assigned Penance and final prayers. Resolve to receive Sacramental Confession often.',
                  style: TextStyle(
                    color: const Color.fromRGBO(4, 26, 82, 1),
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _renderConfession() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confession, also known as the Sacrament of Reconciliation or Penance, is a sacrament in the Catholic Church where a person confesses their sins to a priest and receives absolution, or forgiveness, for those sins. It is an essential part of the Catholic faith and is viewed as a means of reconciling with God and the Church.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
          ),
        ),
        Text(
          'When a new Catholic participates in the Sacrament of Confession, they have the opportunity to:',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '1. ',
              style: TextStyle(
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
              ),
            ),
            Expanded(
              child: Text(
                'Seek forgiveness: Confession allows individuals to acknowledge their sins and express genuine remorse for their actions. It provides a formal and sacramental way to ask for God\'s forgiveness and receive absolution.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
              ),
            ),
            Expanded(
              child: Text(
                'Receive spiritual healing: Through the Sacrament of Confession, Catholics believe they receive spiritual healing and reconciliation with both God and the Church. It is seen as a way to restore one\'s relationship with God and to strengthen the individual\'s commitment to living a holy life.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
              ),
            ),
            Expanded(
              child: Text(
                'Obtain guidance and advice: During Confession, the priest acts as a spiritual guide and advisor. They offer counsel, support, and guidance to help individuals overcome their sins and make positive changes in their lives.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
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
                color: const Color.fromRGBO(4, 26, 82, 1),
                fontSize: widget.model!.contentFontSize ?? 17,
              ),
            ),
            Expanded(
              child: Text(
                'Experience peace of mind: Confessing one\'s sins and receiving absolution can bring a sense of relief, peace, and freedom from guilt. It allows individuals to let go of their past mistakes and start anew with a clean slate.',
                style: TextStyle(
                  color: const Color.fromRGBO(4, 26, 82, 1),
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          'For new Catholics, Confession can be a transformative and liberating experience. It provides an opportunity to actively participate in the sacramental life of the Church and to receive God\'s mercy and forgiveness. Confession can help new Catholics deepen their relationship with God, grow in humility and self-awareness, and strengthen their commitment to living a virtuous life.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'It\'s important to note that the Seal of Confession is sacred and inviolable. The priest is bound by absolute confidentiality and cannot disclose anything revealed during Confession under any circumstances. This confidentiality ensures that individuals can approach Confession with complete trust and openness.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
          ),
        ),
        Text(
          'While Confession is highly encouraged in the Catholic faith, it is not obligatory for new Catholics to immediately participate. It is recommended that they undergo proper preparation, receive instruction from a priest, and discern when they are ready to receive the Sacrament of Reconciliation.',
          style: TextStyle(
            color: const Color.fromRGBO(4, 26, 82, 1),
            fontSize: widget.model!.contentFontSize ?? 17,
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
                      _renderConfession(),
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
