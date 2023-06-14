import 'package:butter/butter.dart';
import 'package:flutter/material.dart';

import '../models/event_register_model.dart';
import './event_register_form_view.dart';
import './event_register_details_view.dart';

class EventRegisterView extends BaseStatefulPageView {
  final EventRegisterModel? model;

  EventRegisterView(this.model, {Key? key}) : super();

  @override
  State<BaseStatefulPageView> createState() => _EventRegisterViewState();
}

class _EventRegisterViewState extends State<EventRegisterView> {
  @override
  void dispose() {
    delayedReset();

    super.dispose();
  }

  void delayedReset() async {
    widget.model!.setIsEventRegister(isEventRegister: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(255, 252, 245, 1),
          ),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  widget.model?.bookingFormView == 'bookingForm'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : const Color.fromRGBO(164, 187, 244, 1),
                              radius: 15,
                              child: const Text(
                                '1',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: 180,
                            color:
                                widget.model?.bookingFormView == 'bookingForm'
                                    ? const Color.fromRGBO(4, 26, 82, 0.3)
                                    : const Color.fromRGBO(12, 72, 224, 1),
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsetsDirectional.symmetric(
                                horizontal: 8),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              backgroundColor:
                                  widget.model?.bookingFormView == 'bookingForm'
                                      ? const Color.fromRGBO(4, 26, 82, 0.5)
                                      : const Color.fromRGBO(12, 72, 224, 1),
                              radius: 15,
                              child: const Text(
                                '2',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Fill In Form',
                            style: TextStyle(
                              color:
                                  widget.model?.bookingFormView == 'bookingForm'
                                      ? const Color.fromRGBO(12, 72, 224, 1)
                                      : const Color.fromRGBO(164, 187, 244, 1),
                              fontWeight:
                                  widget.model?.bookingFormView == 'bookingForm'
                                      ? FontWeight.w500
                                      : FontWeight.w400,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'Review',
                            style: TextStyle(
                              color:
                                  widget.model?.bookingFormView == 'bookingForm'
                                      ? const Color.fromRGBO(4, 26, 82, 0.5)
                                      : const Color.fromRGBO(12, 72, 224, 1),
                              fontWeight:
                                  widget.model?.bookingFormView == 'bookingForm'
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      IndexedStack(
                        index: widget.model?.bookingFormView == 'bookingForm'
                            ? 0
                            : 1,
                        children: <Widget>[
                          widget.model?.bookingFormView == 'bookingForm'
                              ? EventRegisterFormView(
                                  widget.model,
                                )
                              : const SizedBox(),
                          widget.model?.bookingFormView == 'bookingFormReview'
                              ? EventRegisterDetailsView(
                                  widget.model,
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
