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
                      onPressed: () {
                        widget.model?.setBookingFormView!();
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
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Next',
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
                      if (widget.model?.selectedEventDetail!['hasLiked'] ==
                          false) {
                        widget.model?.setInterestEvent!(
                            widget.model?.selectedEventDetail!['parentEventId'],
                            widget.model?.selectedEventDetail!['eventId']);
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
                        widget.model?.navigateToEventRegister!(
                            widget.model?.selectedEventDetail);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(4, 26, 82, 0.15),
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: const Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Book',
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
      ),
    );
  }
}
