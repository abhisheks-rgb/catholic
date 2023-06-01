import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../models/home_model.dart';

class EventDetailsFooter extends StatefulWidget {
  final HomeModel? model;

  const EventDetailsFooter({
    super.key,
    this.model,
  });

  @override
  State<EventDetailsFooter> createState() => _EventDetailsFooterState();
}

class _EventDetailsFooterState extends State<EventDetailsFooter> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 82,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(235, 235, 235, 1),
              blurRadius: 15,
              offset: Offset(0.0, 1.25),
            ),
          ],
        ),
        child: widget.model!.isEventRegister
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        await Navigator.of(context).maybePop();
                        widget.model?.discardBooking!();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(4, 26, 82, 0.05),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: const Color.fromRGBO(4, 26, 82, 0.05),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Back',
                            style: TextStyle(
                              color: Color.fromRGBO(4, 26, 82, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () async {
                        if (widget.model?.bookingFormView == 'bookingForm') {
                          widget.model?.setBookingFormView!();
                        } else {
                          await widget.model?.submitFormEvent!();

                          Future.delayed(const Duration(milliseconds: 1000),
                              () {
                            if (widget
                                    .model?.selectedEventDetail!['hasBooked'] ==
                                true) {
                              _showPopup(context);
                            }
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(12, 72, 224, 1),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color: const Color.fromRGBO(12, 72, 224, 1),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.model?.bookingFormView == 'bookingForm'
                                ? 'Next'
                                : 'Submit',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {},
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(4, 26, 82, 0.15),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            FontAwesome5Solid.share_alt,
                            color: Color.fromRGBO(4, 26, 82, 0.5),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  RawMaterialButton(
                    constraints: const BoxConstraints(),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      if (widget.model?.user != null) {
                        if (widget.model?.selectedEventDetail!['hasLiked'] ==
                            false) {
                          widget.model?.setInterestEvent!(
                              widget
                                  .model?.selectedEventDetail!['parentEventId'],
                              widget.model?.selectedEventDetail!['eventId']);
                        }
                      } else {
                        widget.model?.showPage('/_/login');
                      }
                    },
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              widget.model?.selectedEventDetail!['hasLiked'] ==
                                      false
                                  ? Colors.white
                                  : const Color.fromRGBO(219, 228, 251, 1),
                          border: Border.all(
                            color: const Color.fromRGBO(4, 26, 82, 0.15),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: Icon(
                            widget.model?.selectedEventDetail!['hasLiked'] ==
                                    false
                                ? Octicons.star
                                : Octicons.star_fill,
                            color: widget.model
                                        ?.selectedEventDetail!['hasLiked'] ==
                                    false
                                ? const Color.fromRGBO(4, 26, 82, 0.5)
                                : const Color.fromRGBO(12, 72, 224, 1),
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        if (widget.model?.user != null) {
                          widget.model?.navigateToEventRegister!(
                              widget.model?.selectedEventDetail);
                        } else {
                          widget.model?.showPage('/_/login');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.model
                                        ?.selectedEventDetail!['hasBooked'] ==
                                    false
                                ? const Color.fromRGBO(4, 26, 82, 0.15)
                                : const Color.fromRGBO(252, 223, 222, 1),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color:
                              widget.model?.selectedEventDetail!['hasBooked'] ==
                                      false
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(252, 223, 222, 1),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.model?.selectedEventDetail!['hasBooked'] ==
                                    false
                                ? 'Book'
                                : 'Withdraw',
                            style: TextStyle(
                              color: widget.model
                                          ?.selectedEventDetail!['hasBooked'] ==
                                      false
                                  ? const Color.fromRGBO(12, 72, 224, 1)
                                  : const Color.fromRGBO(233, 40, 35, 1),
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Congratulations!',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        icon: const Icon(Ionicons.close_circle),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Ionicons.checkmark_circle,
                        color: Colors.green,
                        size: 44,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'You have successfully booked for:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.1,
                              color: Color.fromRGBO(4, 26, 82, 1),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.model?.selectedEventDetail!['eventName'],
                            softWrap: true,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.1,
                              color: Color.fromRGBO(4, 26, 82, 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {},
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(12, 72, 224, 1),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: const Color.fromRGBO(12, 72, 224, 1),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Go to My Events',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {},
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color.fromRGBO(219, 228, 251, 1),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Share',
                                style: TextStyle(
                                  color: Color.fromRGBO(12, 72, 224, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () {},
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color.fromRGBO(219, 228, 251, 1),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Add to Calendar',
                                style: TextStyle(
                                  color: Color.fromRGBO(12, 72, 224, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          constraints: const BoxConstraints(),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          onPressed: () async {
                            await Navigator.of(context).maybePop();
                            widget.model?.closeSuccessPrompt!();
                          },
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color.fromRGBO(4, 26, 82, 0.05),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Close',
                                style: TextStyle(
                                  color: Color.fromRGBO(4, 26, 82, 1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
