import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../theme/common_button.dart';
import '../../theme/common_color.dart';
import '../../theme/media_query.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _secondsRemaining = 30;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    errorController!.close();
    _timer?.cancel();
    super.dispose();
  }

  void getStartedOtp() {
    formKey.currentState!.validate();

    if (currentText.length == 4 || currentText != "") {
      errorController!.add(ErrorAnimationType.shake);

      setState(() => hasError = true);
    } else {
      setState(
        () {
          hasError = false;
        },
      );
    }
  }

  dynamic routesData = {};
  @override
  Widget build(BuildContext context) {
    routesData = ModalRoute.of(context)?.settings.arguments;
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width(context),
          height: size.height(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/my_plo.png",
                      width: 150,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "The Genius Way to Buy & Sell Party Leftover",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height(context) * .03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Otp",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dosis(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF3C3C3C)),
                      ),
                      SizedBox(
                        height: size.height(context) * .01,
                      ),
                      Text(
                        "We’ll send you a verification code on the phone number",
                        style: GoogleFonts.archivo(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF828282)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height(context) * .02,
                ),
                Form(
                  key: formKey,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (v) {
                          return null;

                          // if (v!.length < 3) {
                          //   return "I'm from validator";
                          // } else {
                          //   return null;
                          // }
                        },
                        pinTheme: PinTheme(
                            errorBorderColor: const Color(0xFFFF5A5F),
                            borderWidth: 1,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(15),
                            fieldHeight: 55,
                            fieldWidth: 66,
                            selectedFillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            activeColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            activeFillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            inactiveColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            disabledColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            // errorBorderColor:
                            //     Color(CommonColor.textFieldsBackgroundColor),
                            inactiveFillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            selectedColor:
                                Color(CommonColor.textFieldsBackgroundColor)),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        errorAnimationController: errorController,
                        controller: textEditingController,
                        keyboardType: TextInputType.number,
                        onCompleted: (v) {},
                        onChanged: (value) {
                          debugPrint(value);
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      )),
                ),
                SizedBox(
                  height: size.height(context) * .02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CommonButton(text: "Next", callBack: getStartedOtp),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       const Text(
                //         "Resend code to",
                //         style: TextStyle(
                //             color: Color(0xFF6A6A6A),
                //             fontWeight: FontWeight.w500,
                //             fontSize: 15),
                //       ),
                //       _secondsRemaining > 0
                //           ? Text(
                //               '00:$_secondsRemaining ',
                //               style: const TextStyle(
                //                   color: Color(0xFF6A6A6A),
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16),
                //             )
                //           : TextButton(
                //               onPressed: () {
                //                 setState(() {
                //                   _secondsRemaining = 30;
                //                 });
                //                 startTimer();
                //               },
                //               child: const Text('Resend OTP'),
                //             ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
