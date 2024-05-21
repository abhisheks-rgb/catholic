import 'package:flutter/material.dart';

class LoginPrompt extends StatefulWidget {
  final Function onPressed;
  final bool isLoggedIn;
  final bool isFull;

  const LoginPrompt({
    Key? key,
    required this.onPressed,
    required this.isLoggedIn,
    this.isFull = true,
  }) : super(key: key);

  @override
  LoginPromptState createState() => LoginPromptState();
}

class LoginPromptState extends State<LoginPrompt> {
  @override
  Widget build(BuildContext context) {
    return !widget.isLoggedIn
        ? RawMaterialButton(
            constraints: const BoxConstraints(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: () => widget.onPressed(),
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: widget.isFull
                    ? const EdgeInsets.all(20)
                    : const EdgeInsets.fromLTRB(0, 20, 0, 20),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 244, 219, 1),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(235, 235, 235, 1),
                      blurRadius: 15,
                      offset: Offset(0.0, 0.75),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log in Now',
                      style: TextStyle(
                        color: const Color.fromRGBO(99, 69, 4, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width *
                            0.045, // 4% of screen width
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'to make full use of the App!',
                      style: TextStyle(
                        color: const Color.fromRGBO(99, 69, 4, 1),
                        fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.width *
                            0.045, // 4% of screen width
                      ),
                    ),
                  ],
                )),
          )
        : Container();
  }
}
