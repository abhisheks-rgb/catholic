import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:add_2_calendar/add_2_calendar.dart' as a2c;
import 'package:html/parser.dart';

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
    bool isWalkin = widget.model?.selectedEventDetail!['isWalkIn'] ?? false;
    bool isEventRegister =
        ModalRoute.of(context)!.settings.name == '/_/events/register';
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
        child: isEventRegister
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
                        widget.model?.discardBooking!();
                        await Navigator.of(context)
                            .popAndPushNamed('/_/events/details');
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
                        widget.model?.redirectToLogin!();
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
                          if (widget.model?.selectedEventDetail!['hasBooked'] ==
                              false) {
                            if (!isWalkin) {
                              widget.model?.navigateToEventRegister!(
                                  widget.model?.selectedEventDetail);
                            }
                          } else {
                            if (_checkStartDateCanCancel(widget.model
                                    ?.selectedEventDetail!['startDate']) ==
                                true) {
                              _showUnableCancelBookingPopup(context);
                            } else {
                              _showCancelBookingPopup(context);
                            }
                          }
                        } else {
                          widget.model?.redirectToLogin!();
                        }
                      },
                      child: Container(
                        height: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.model
                                        ?.selectedEventDetail!['hasBooked'] ==
                                    false
                                ? const Color.fromRGBO(4, 26, 82, 0.15)
                                : _checkStartDateCanCancel(widget.model
                                        ?.selectedEventDetail!['startDate'])
                                    ? const Color.fromRGBO(4, 26, 82, 0.05)
                                    : const Color.fromRGBO(252, 223, 222, 1),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                          color:
                              widget.model?.selectedEventDetail!['hasBooked'] ==
                                      false
                                  ? isWalkin
                                      ? const Color.fromRGBO(4, 26, 82, 0.05)
                                      : const Color.fromRGBO(255, 255, 255, 1)
                                  : _checkStartDateCanCancel(widget.model
                                          ?.selectedEventDetail!['startDate'])
                                      ? const Color.fromRGBO(4, 26, 82, 0.05)
                                      : const Color.fromRGBO(252, 223, 222, 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.model?.selectedEventDetail!['hasBooked'] ==
                                    false
                                ? const SizedBox()
                                : SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Ionicons.close_circle_outline,
                                      color: _checkStartDateCanCancel(widget
                                                  .model?.selectedEventDetail![
                                              'startDate'])
                                          ? const Color.fromRGBO(4, 26, 82, 0.5)
                                          : const Color.fromRGBO(
                                              233, 40, 35, 1),
                                      size: 20,
                                    ),
                                  ),
                            widget.model?.selectedEventDetail!['hasBooked'] ==
                                    false
                                ? const SizedBox()
                                : const SizedBox(
                                    width: 4,
                                  ),
                            Text(
                              widget.model?.selectedEventDetail!['hasBooked'] ==
                                      false
                                  ? isWalkin
                                      ? 'Walk-In Only'
                                      : 'Book'
                                  : 'Cancel',
                              style: TextStyle(
                                color: widget.model?.selectedEventDetail![
                                            'hasBooked'] ==
                                        false
                                    ? isWalkin
                                        ? const Color.fromRGBO(4, 26, 82, 0.5)
                                        : const Color.fromRGBO(12, 72, 224, 1)
                                    : _checkStartDateCanCancel(widget.model
                                            ?.selectedEventDetail!['startDate'])
                                        ? const Color.fromRGBO(4, 26, 82, 0.5)
                                        : const Color.fromRGBO(233, 40, 35, 1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _showUnableCancelBookingPopup(BuildContext context) {
    showDialog(
      barrierDismissible: false,
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
                        'Sorry!',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        icon: const Icon(
                          Ionicons.close_circle,
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                        ),
                        onPressed: () async {
                          await Navigator.of(context).maybePop();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        MaterialCommunityIcons.emoticon_sad,
                        color: Color.fromRGBO(233, 40, 35, 1),
                        size: 44,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Flexible(
                        child: Text(
                          'You can only cancel an event, 1 hour before it starts.',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                            color: Color.fromRGBO(4, 26, 82, 1),
                          ),
                        ),
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
                          onPressed: () async {
                            await Navigator.of(context).maybePop();
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

  void _showCancelBookingPopup(BuildContext context) {
    showDialog(
      barrierDismissible: false,
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
                        'Cancel Booking',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        alignment: Alignment.centerRight,
                        icon: const Icon(
                          Ionicons.close_circle,
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                        ),
                        onPressed: () async {
                          await Navigator.of(context).maybePop();
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        FontAwesome5Solid.calendar_times,
                        color: Color.fromRGBO(233, 40, 35, 0.5),
                        size: 44,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Flexible(
                        child: Text(
                          'Are you sure you want to cancel your booking for this event?',
                          softWrap: true,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.1,
                            color: Color.fromRGBO(4, 26, 82, 1),
                          ),
                        ),
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
                          onPressed: () async {
                            widget.model?.cancelFormEvent!();

                            await Navigator.of(context).maybePop();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color.fromRGBO(233, 40, 35, 1),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: const Color.fromRGBO(233, 40, 35, 1),
                            ),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Cancel Booking',
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
                          onPressed: () async {
                            await Navigator.of(context).maybePop();
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

  void _showPopup(BuildContext context) {
    showDialog(
      barrierDismissible: false,
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
                        icon: const Icon(
                          Ionicons.close_circle,
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                        ),
                        onPressed: () async {
                          await Navigator.of(context).maybePop();
                          widget.model?.closeSuccessPrompt!();
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          onPressed: () async {
                            await Navigator.of(context).maybePop();
                            widget.model?.gotoMyEvents!();
                          },
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
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Icon(
                                      Ionicons.close_circle_outline,
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    'Go to My Events',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
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
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Icon(
                                      FontAwesome5Solid.share_alt,
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Share',
                                    style: TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
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
                          onPressed: () {
                            _addEventToCalendar();
                          },
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: Color.fromRGBO(219, 228, 251, 1),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Icon(
                                      FontAwesome5Solid.calendar_plus,
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      size: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    'Add to Calendar',
                                    style: TextStyle(
                                      color: Color.fromRGBO(12, 72, 224, 1),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
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

  void _addEventToCalendar() {
    final startDate =
        _dateEvent(widget.model?.selectedEventDetail!['startDate']);
    final endDate = _dateEvent(widget.model?.selectedEventDetail!['endDate']);

    final a2c.Event event = a2c.Event(
      title: widget.model?.selectedEventDetail!['eventName'] as String,
      description: _parseHtmlString(
          widget.model?.selectedEventDetail!['eventDescription']),
      location: widget.model?.selectedEventDetail!['eventVenue'] as String,
      startDate: startDate,
      endDate: endDate,
      allDay: false,
    );

    a2c.Add2Calendar.addEvent2Cal(event);
  }

  DateTime _dateEvent(dateEvent) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(dateEvent['_seconds'] * 1000);

    return date;
  }

  String _parseHtmlString(htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body?.text).documentElement!.text;

    return parsedString;
  }

  bool _checkStartDateCanCancel(startDate) {
    DateTime currentTime = DateTime.now();
    DateTime startDateTime =
        DateTime.fromMillisecondsSinceEpoch(startDate['_seconds'] * 1000);
    Duration difference = startDateTime.difference(currentTime);

    bool isWithinOneHour = difference.inHours <= 1;
    bool isPastSpecificTime = currentTime.isAfter(startDateTime);

    return isWithinOneHour || isPastSpecificTime;
  }
}
