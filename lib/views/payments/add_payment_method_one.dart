import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/provider_controller.dart';
import '../../theme/common_button.dart';

class AddPaymentMethodOne extends StatefulWidget {
  const AddPaymentMethodOne({super.key});

  @override
  State<AddPaymentMethodOne> createState() => _AddPaymentMethodOneState();
}

class _AddPaymentMethodOneState extends State<AddPaymentMethodOne> {
  String currentItem = "Company";
  double widgetGap = 20;

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController cName = TextEditingController();
  TextEditingController addressline1 = TextEditingController();
  TextEditingController addressline2 = TextEditingController();
  TextEditingController city = TextEditingController(text: 'New York');
  TextEditingController state = TextEditingController(text: "Texas");
  TextEditingController postalcode = TextEditingController(text: '75015');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  save() {
    if (_formKey.currentState!.validate()) {
      print("from is validated");
      Map requestData = {
        "vendorbusinesstype":
            currentItem == "Company" ? "company" : "individual",
        "vendorcompanyname": cName.text,
        "vendorfirstname": firstname.text,
        "vendorlastname": lastname.text,
        "vendordob": selectedDateForBackendDeveloper,
        "addressline1": addressline1.text,
        "addressline2": addressline2.text,
        "addresscity": city.text,
        "addressstate": state.text,
        "addresspostalcode": postalcode.text
      };
      print("Request data $requestData");
      CommonProvider provider = Provider.of(context, listen: false);
      provider.addUserBankDetailsMethod1(context, requestData);
    }
  }

  DateTime currentDate = DateTime.now();
  String? selectedDateForBackendDeveloper;
  datePicker(context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      // firstDate: DateTime(2022),
      firstDate: DateTime.now(),
      // firstDate: DateTime(2022, 9, 15),

      // lastDate: DateTime(3000),

      lastDate: DateTime(30000),
    );

    if (userSelectedDate == null) {
      return;
    } else {
      setState(() {
        currentDate = userSelectedDate;
        selectedDateForBackendDeveloper =
            "${currentDate.year}/${currentDate.month}/${currentDate.day}";
        print("Date $selectedDateForBackendDeveloper");
      });
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
        title: const Text('Payment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                const Text(
                  "Business Type",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: const Color(0xFF83CA13))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        alignment: Alignment.topLeft,
                        borderRadius: BorderRadius.circular(8),
                        dropdownColor: Colors.white,
                        value: currentItem,
                        items: [
                          // const DropdownMenuItem(
                          //   value: '',
                          //   child: Text(
                          //     'Business Type ',
                          //     style: TextStyle(color: Color(0xFF83CA13)),
                          //   ),
                          // ),
                          ...businessList
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e['value'],
                                  child: Text(
                                    e['name'],
                                    style: TextStyle(color: Color(0xFF83CA13)),
                                  ),
                                ),
                              )
                              .toList()
                        ],
                        onChanged: (value) {
                          print(value);

                          setState(
                            () {
                              currentItem = value.toString();
                            },
                          );
                        }),
                  ),
                ),
                currentItem == "Individual"
                    ? Column(
                        children: [
                          SizedBox(
                            height: widgetGap,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: firstname,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required First Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: "First Name",
                                    labelStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF83CA13)),
                                    hintText: "First Name",
                                    hintStyle: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFFC8C8C8)),
                                    enabledBorder:
                                        AuthCommonTheme.enabledBorder,
                                    focusedBorder:
                                        AuthCommonTheme.focusedBorder,
                                    errorBorder: AuthCommonTheme.errorBorder,
                                    border: AuthCommonTheme.border,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: widgetGap,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: lastname,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Required Last Name";
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: InputDecoration(
                                      labelText: "Last Name",
                                      labelStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF83CA13)),
                                      hintText: "Last Name",
                                      hintStyle: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFFC8C8C8)),
                                      enabledBorder:
                                          AuthCommonTheme.enabledBorder,
                                      focusedBorder:
                                          AuthCommonTheme.focusedBorder,
                                      errorBorder: AuthCommonTheme.errorBorder,
                                      border: AuthCommonTheme.border),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: widgetGap,
                          ),
                          Container(
                            height: 60,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    width: 1, color: const Color(0xFF83CA13))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Date : ${currentDate.year}/${currentDate.month}/${currentDate.day}",
                                    style: const TextStyle(fontSize: 18),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      datePicker(context);
                                    },
                                    icon: const Icon(Icons.arrow_drop_down))
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: widgetGap,
                          ),
                          TextFormField(
                            controller: cName,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Required Company Name";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              labelText: "Company Name",
                              labelStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF83CA13)),
                              hintText: "Company Name",
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
                      return "Address Required";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Address Line 1",
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF83CA13)),
                      hintText: "Address Line 1",
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
                  decoration: InputDecoration(
                      labelText: "Address Line 2",
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF83CA13)),
                      hintText: "Address Line 2",
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: city,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required City Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "City",
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF83CA13)),
                            hintText: "City",
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFC8C8C8)),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.focusedBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border),
                      ),
                    ),
                    SizedBox(
                      width: widgetGap,
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: state,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Required State Name";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "State",
                            labelStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF83CA13)),
                            hintText: "State",
                            hintStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFC8C8C8)),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.focusedBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: widgetGap,
                ),
                TextFormField(
                  controller: postalcode,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required Postal Code";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Postal Code",
                      labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF83CA13)),
                      hintText: "Postal Code",
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
