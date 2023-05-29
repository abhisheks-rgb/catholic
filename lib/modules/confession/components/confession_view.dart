import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/confession_model.dart';

class ConfessionView extends BaseStatefulPageView {
  final ConfessionModel? model;

  ConfessionView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _ConfessionViewState();
}

class _ConfessionViewState extends State<ConfessionView> {
  int _selected = 0;

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
                                'Confession Guide',
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
                                'What is a Confession?',
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
                  _selected == 0 ? _renderGuide() : _renderConfession(),
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
          const SizedBox(height: 28),
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
                  'Bless yourself with the Sign of the Cross.',
                  style: TextStyle(
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Say  “Bless me, Father, for I have sinned. It\'s been [however many days/months/years] since my last confession.”',
                  style: TextStyle(
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: widget.model!.contentFontSize ?? 17,
                        color: Colors.black,
                      ),
                      children: const <TextSpan>[
                        TextSpan(text: 'Say '),
                        TextSpan(
                          text: '"My sins are..."',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '[List your sins here]',
                    style: TextStyle(
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
                          fontSize: widget.model!.contentFontSize ?? 17,
                          color: Colors.black,
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: 'Say '),
                          TextSpan(
                            text:
                                '“I will try not to do these things that are wrong anymore. For these and all of my sins, I am truly sorry”',
                            style: TextStyle(
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Listen to the penance and advice that the priest accords to you.',
                  style: TextStyle(
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
                          fontSize: widget.model!.contentFontSize ?? 17,
                          color: Colors.black,
                        ),
                        children: const <TextSpan>[
                          TextSpan(
                              text:
                                  'When invited by the priest, say Act of Contrition: '),
                          TextSpan(
                            text:
                                '“Oh my God, I am very sorry that I have sinned against you. Because you are so good, and with your help and grace. I will try not to sin again.”',
                            style: TextStyle(
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'The priest will then give an Absolution and Final Blessing',
                  style: TextStyle(
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
                          fontSize: widget.model!.contentFontSize ?? 17,
                          color: Colors.black,
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: 'Say '),
                          TextSpan(
                            text: '“Amen”',
                            style: TextStyle(
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Return to the pew to do the assigned Penance and final prayers. Resolve to receive Sacramental Confession often.',
                  style: TextStyle(
                    fontSize: widget.model!.contentFontSize ?? 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _renderConfession() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 28),
          Text(
            'Confession, also known as the Sacrament of Reconciliation or Penance, is a sacrament in the Catholic Church where a person confesses their sins to a priest and receives absolution, or forgiveness, for those sins. It is an essential part of the Catholic faith and is viewed as a means of reconciling with God and the Church.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          Text(
            'When a new Catholic participates in the Sacrament of Confession, they have the opportunity to:',
            style: TextStyle(
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
                  fontSize: widget.model!.contentFontSize ?? 17,
                ),
              ),
              Expanded(
                child: Text(
                  'Seek forgiveness: Confession allows individuals to acknowledge their sins and express genuine remorse for their actions. It provides a formal and sacramental way to ask for God\'s forgiveness and receive absolution.',
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
                  'Receive spiritual healing: Through the Sacrament of Confession, Catholics believe they receive spiritual healing and reconciliation with both God and the Church. It is seen as a way to restore one\'s relationship with God and to strengthen the individual\'s commitment to living a holy life.',
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
                  'Obtain guidance and advice: During Confession, the priest acts as a spiritual guide and advisor. They offer counsel, support, and guidance to help individuals overcome their sins and make positive changes in their lives.',
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
                  'Experience peace of mind: Confessing one\'s sins and receiving absolution can bring a sense of relief, peace, and freedom from guilt. It allows individuals to let go of their past mistakes and start anew with a clean slate.',
                  style: TextStyle(
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
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'It\'s important to note that the Seal of Confession is sacred and inviolable. The priest is bound by absolute confidentiality and cannot disclose anything revealed during Confession under any circumstances. This confidentiality ensures that individuals can approach Confession with complete trust and openness.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          Text(
            'While Confession is highly encouraged in the Catholic faith, it is not obligatory for new Catholics to immediately participate. It is recommended that they undergo proper preparation, receive instruction from a priest, and discern when they are ready to receive the Sacrament of Reconciliation.',
            style: TextStyle(
              fontSize: widget.model!.contentFontSize ?? 17,
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
