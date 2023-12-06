import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/provider_controller.dart';
import '../../theme/common_button.dart';

class AddPaymentMethodTwo extends StatefulWidget {
  const AddPaymentMethodTwo({super.key});

  @override
  State<AddPaymentMethodTwo> createState() => _AddPaymentMethodTwoState();
}

class _AddPaymentMethodTwoState extends State<AddPaymentMethodTwo> {
  double widgetGap = 20;

  TextEditingController cName = TextEditingController();
  TextEditingController addressline1 = TextEditingController();
  TextEditingController addressline2 = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  save() {
    if (_formKey.currentState!.validate()) {
      print("from is validated");
      Map requestData = {
        "accountholdername": cName.text,
        "accountnumber": addressline1.text,
        "accountroutingnumber": addressline2.text,
      };
      print("Request data $requestData");
      CommonProvider provider = Provider.of(context, listen: false);
      provider.addUserBankDetailsMethod2(context, requestData);
    }
  }

  List businessList = [
    {'name': "Company", "value": "Company"},
    {'name': "Individual", "value": "Individual"},
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Bank Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: widgetGap,
                    ),
                    TextFormField(
                      controller: cName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Required Account Holder Name";
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        labelText: "Account Holder Name",
                        labelStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF83CA13)),
                        hintText: "Account Holder Name",
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFC8C8C8)),
                        enabledBorder: AuthCommonTheme.enabledBorder,
                        focusedBorder: AuthCommonTheme.focusedBorder,
                        errorBorder: AuthCommonTheme.errorBorder,
                        border: AuthCommonTheme.border,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                TextFormField(
                  controller: addressline1,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Account Number Required";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Account Number",
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF83CA13)),
                      hintText: "Account Number",
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC8C8C8)),
                      enabledBorder: AuthCommonTheme.enabledBorder,
                      focusedBorder: AuthCommonTheme.focusedBorder,
                      errorBorder: AuthCommonTheme.errorBorder,
                      border: AuthCommonTheme.border),
                ),
                SizedBox(
                  height: widgetGap,
                ),
                TextFormField(
                  controller: addressline2,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Routing Number Required";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Routing Number",
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF83CA13)),
                      hintText: "Routing Number",
                      hintStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFC8C8C8)),
                      enabledBorder: AuthCommonTheme.enabledBorder,
                      focusedBorder: AuthCommonTheme.focusedBorder,
                      errorBorder: AuthCommonTheme.errorBorder,
                      border: AuthCommonTheme.border),
                ),
                SizedBox(
                  height: widgetGap,
                ),
                SizedBox(
                  height: widgetGap,
                ),
                CommonButton(text: "Save", callBack: save),
              ],
            )),
      ),
    );
  }
}

class AuthCommonTheme {
  static OutlineInputBorder enabledBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFF83CA13)),
      borderRadius: BorderRadius.circular(15));

  static OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFF83CA13)),
      borderRadius: BorderRadius.circular(15));

  static OutlineInputBorder border = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFF83CA13)),
      borderRadius: BorderRadius.circular(15));

  static OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Color(0xFF83CA13)),
      borderRadius: BorderRadius.circular(15));
}
