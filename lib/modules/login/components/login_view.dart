import 'package:butter/butter.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/login_model.dart';
import '../../../utils/asset_path.dart';

class LoginView extends BaseStatefulPageView {
  final LoginModel? model;

  LoginView(this.model) : super();

  @override
  State<BaseStatefulPageView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  bool obscureText = true;
  List<Map<String, dynamic>> items = [
    {
      'label': 'EMAIL',
      'hintText': 'name@email.com',
      'error': 'Enter a valid email',
      'regex': RegExp(r''),
    },
    {
      'label': 'PASSWORD',
      'hintText': 'Password',
      'error': 'Enter a valid password',
      'regex': RegExp(r''),
    },
  ];
  final loginEmail = TextEditingController();
  final loginPassword = TextEditingController();
  String? _error;

  @override
  void didUpdateWidget(LoginView oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.model!.error != widget.model!.error) {
      if (widget.model!.error == 'Incorrect email/password') {
        _error = widget.model!.error;
      } else if (widget.model!.loading == false &&
          widget.model!.error!.isNotEmpty) {
        EasyDebounce.debounce(
            'debounce-login', const Duration(milliseconds: 100), () {
          showAlert();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            assetPath('icon-small.png'),
            width: 36,
            height: 36,
          ),
          onPressed: () {
            Navigator.of(context).popAndPushNamed('/_/welcome');
          },
        ),
        title: const Text(
          'Login',
          style: TextStyle(
            color: Color.fromRGBO(4, 26, 82, 1),
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        // leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          assetPath('welcome_bg.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: const Alignment(0.957, -1.211),
                              end: const Alignment(0.515, 1),
                              colors: <Color>[
                                const Color(0x51ffffff),
                                const Color(0xffffffff).withOpacity(0.9)
                              ],
                              stops: const <double>[0, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(1, -1),
                              end: Alignment(-1, 1),
                              colors: <Color>[
                                Color.fromRGBO(24, 77, 212, 0.5),
                                Color.fromRGBO(255, 255, 255, 0)
                              ],
                              stops: <double>[0, 1],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Align(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: Container(
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '“For I was hungry and you gave me food, I was thirsty and you gave me drink, I was a stranger and you welcomed me”',
                    style: TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '- Matthew 25:35',
                      style: TextStyle(
                        color: Color.fromRGBO(4, 26, 82, 1),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  _error == null
                      ? const SizedBox()
                      : const Center(
                          child: Text('Incorrect email/password.',
                              style: TextStyle(
                                  color: Color.fromRGBO(247, 9, 22, 1)))),
                  Form(
                    key: formKey,
                    child: Column(
                      children: items.map<Widget>((element) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element['label'] ?? '',
                              style: const TextStyle(
                                color: Color.fromRGBO(4, 26, 82, 0.5),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            TextFormField(
                              controller: element['label'] == 'EMAIL'
                                  ? loginEmail
                                  : loginPassword,
                              obscureText: element['label'] == 'EMAIL'
                                  ? false
                                  : obscureText,
                              decoration: InputDecoration(
                                hintText: element['hintText'] ?? '',
                                border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                suffixIcon: element['label'] == 'EMAIL'
                                    ? null
                                    : IconButton(
                                        icon: Icon(
                                          obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: const Color.fromRGBO(
                                              4, 26, 82, 0.5),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            obscureText = !obscureText;
                                          });
                                        },
                                      ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  // || !element['regex'].hasMatch(value)
                                  return element['error'] ?? '';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (_) => setState(() => _error = null),
                            ),
                            const SizedBox(height: 16),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: const Color.fromRGBO(12, 72, 224, 1),
                    clipBehavior: Clip.antiAlias,
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          widget.model
                              ?.login(loginEmail.text, loginPassword.text);
                        }
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.156),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        'No Account Yet?',
                        style: TextStyle(
                          color: Color.fromRGBO(4, 26, 82, 0.5),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      RawMaterialButton(
                        constraints: const BoxConstraints(),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          const registerWebSIte =
                              'https://mycatholic.sg/register';
                          final uri = Uri.parse(registerWebSIte);
                          urlLauncher(uri);
                        },
                        child: const Text(
                          'Signup here.',
                          style: TextStyle(
                            color: Color.fromRGBO(12, 72, 224, 1),
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: RawMaterialButton(
                      constraints: const BoxConstraints(),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      onPressed: () {
                        const registerWebSIte = 'https://mycatholic.sg/forgot';
                        final uri = Uri.parse(registerWebSIte);
                        urlLauncher(uri);
                      },
                      child: const Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Color.fromRGBO(12, 72, 224, 1),
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            widget.model?.loading == false || widget.model?.loading == null
                ? Container()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.74,
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void urlLauncher(Uri uri) async {
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $uri';
    }
  }

  void showAlert() => showDialog(
        context: context,
        routeSettings:
            RouteSettings(name: ModalRoute.of(context)?.settings.name),
        builder: (BuildContext context) => Dialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          insetPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Linkify(
                    onOpen: (link) async {
                      final website = link.url;
                      final uri = Uri.parse(website);
                      urlLauncher(uri);
                    },
                    text: widget.model!.error ?? '',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromRGBO(4, 26, 82, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).then((value) {
        widget.model!.resetError();
      });
}
