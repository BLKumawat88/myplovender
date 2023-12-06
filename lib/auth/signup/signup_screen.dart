import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/common_button.dart';
import '../../theme/common_color.dart';
import '../../theme/common_textfield_style.dart';
import '../../theme/media_query.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = '';
    _emailController.text = '';
    _companyController.text = '';
    _passwordController.text = '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void otpVerification() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pushNamed('/otp_verification');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = Sizess();
    double spaceBitweenWidget = size.height(context) * .02;
    double textFieldSpace = size.height(context) * .021;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF000000)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: textFieldSpace),
                        Text(
                          "Sign up",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.dosis(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF3C3C3C)),
                        ),
                        SizedBox(height: spaceBitweenWidget),
                        Text(
                          "Sign up with one of the following option",
                          style: GoogleFonts.archivo(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF828282)),
                        ),
                        SizedBox(
                          height: spaceBitweenWidget,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: _nameController,
                          decoration: InputDecoration(
                            hintText: "Name",
                            filled: true,
                            fillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.enabledBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: spaceBitweenWidget),
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: "Email",
                            filled: true,
                            fillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.enabledBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email address';
                            } else if (!RegExp(
                                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: spaceBitweenWidget,
                        ),
                        TextFormField(
                          controller: _companyController,
                          decoration: InputDecoration(
                            hintText: "Company Name",
                            filled: true,
                            fillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.enabledBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your company Name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: textFieldSpace,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.enabledBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password is required";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: textFieldSpace,
                        ),
                        CommonButton(
                            text: "Create account", callBack: otpVerification),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account? ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF828282),
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, "/login_screen");
                              },
                              child: const Text('Log in',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFF405E3),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          children: const [
                            Expanded(
                                child: Divider(
                              thickness: 1,
                              color: Color(0xFF555555),
                              endIndent: 6,
                            )),
                            Text(
                              'or',
                              style: TextStyle(
                                  color: Color(0xFF828282), fontSize: 14),
                            ),
                            Expanded(
                                child: Divider(
                                    thickness: 1,
                                    indent: 6,
                                    color: Color(0xFF555555))),
                          ],
                        ),
                        SizedBox(
                          height: textFieldSpace,
                        ),
                        google_facebook_button(size, context,
                            "assets/images/Google.png", "Coninue WIth Google"),
                        SizedBox(
                          height: textFieldSpace,
                        ),
                        google_facebook_button(
                            size,
                            context,
                            "assets/images/facebook.png",
                            "Coninue WIth Google"),
                        const SizedBox(
                          height: 30,
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container google_facebook_button(
      Sizess size, BuildContext context, image, String title) {
    return Container(
      width: size.width(context),
      height: 50,
      decoration: BoxDecoration(
          color: const Color(0xFFDEDEDE),
          borderRadius: BorderRadius.circular(22)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
