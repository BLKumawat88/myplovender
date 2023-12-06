import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:my_plo_vendor/theme/common_button.dart';
import 'package:provider/provider.dart';

import '../../theme/common_color.dart';
import '../../theme/common_textfield_style.dart';
import '../../theme/media_query.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwords;

  late GlobalKey<FormState> _formKey;
  bool _passwordVisible = false;
  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController(text: "");
    _passwords = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwords.dispose();
  }

  void userLogin() {
    CommonProvider provider = Provider.of(context, listen: false);
    if (_formKey.currentState!.validate()) {
      Map requestData = {
        "vendoremail": _emailController.text,
        "vendorpassword": _passwords.text
      };

      provider.userLogin(requestData, context);
    }
  }

  final Uri _url = Uri.parse('https://myplo.itworkshop.in/');
  Future<void> _launchUrl() async {
    print(_url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    double spaceBitweenWidget = size.height(context) * .02;
    double textFieldSpace = size.height(context) * .03;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: size.width(context),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
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
                          "Log in",
                          textAlign: TextAlign.left,
                          style: GoogleFonts.dosis(
                              fontSize: 40,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF3C3C3C)),
                        ),
                        SizedBox(height: spaceBitweenWidget),
                        Text(
                          "Login up with one of the following option",
                          style: GoogleFonts.archivo(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF828282)),
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
                          height: textFieldSpace,
                        ),
                        TextFormField(
                          controller: _passwords,
                          obscureText: !_passwordVisible,
                          decoration: InputDecoration(
                            hintText: "Password",
                            filled: true,
                            fillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.enabledBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
                            ),
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
                        CommonButton(text: "Log in", callBack: userLogin),
                        const SizedBox(
                          height: 10,
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
                        // google_facebook_button(size, context,
                        //     "assets/images/Google.png", "Coninue WIth Google"),
                        // SizedBox(
                        //   height: textFieldSpace,
                        // ),
                        // google_facebook_button(
                        //     size,
                        //     context,
                        //     "assets/images/facebook.png",
                        //     "Coninue WIth Google"),
                        // const SizedBox(
                        //   height: 30,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'To create account Go to Our Website ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF828282),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              _launchUrl();
                              // https://myplo.com/
                              // Navigator.pushNamed(context, "/signup_screen");
                            },
                            child: const Text('Signup',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF405E3),
                                )),
                          ),
                        ),
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
