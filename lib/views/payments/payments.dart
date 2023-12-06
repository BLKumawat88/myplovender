import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../controllers/provider_controller.dart';
import '../../theme/media_query.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  final List paymentList = const [
    {
      "image": "assets/images/paymentss.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "amountReceived": "Amount Received -",
      "dateOfAmountReceived": " 12/12/2023",
      "transaction": "transaction ID -",
      "transactionID": " 1234567"
    },
    {
      "image": "assets/images/paymentss.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "amountReceived": "Amount Received -",
      "dateOfAmountReceived": " 12/12/2023",
      "transaction": "transaction ID -",
      "transactionID": " 1234567"
    },
    {
      "image": "assets/images/paymentss.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "amountReceived": "Amount Received -",
      "dateOfAmountReceived": " 12/12/2023",
      "transaction": "transaction ID -",
      "transactionID": " 1234567"
    },
    {
      "image": "assets/images/paymentss.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "amountReceived": "Amount Received -",
      "dateOfAmountReceived": " 12/12/2023",
      "transaction": "transaction ID -",
      "transactionID": " 1234567"
    },
  ];

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getpaymentMethodList(context, true);
    });
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: commonProvider.isDrawerOpen
                  ? MediaQuery.of(context).size.width - 80
                  : MediaQuery.of(context).size.width - 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Payments",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF000000)),
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 10),
                      //   child: Text(
                      //     "Lorem Ipsum is simply dummy text of the",
                      //     style: TextStyle(
                      //       fontSize: 10,
                      //       color: Color(0xFF676767),
                      //       fontWeight: FontWeight.w400,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/aad_payment_one');
                      },
                      icon: const Icon(Icons.add))
                ],
              ),
            ),
            ...commonProvider.paymentMethodList.map(
              (card) => Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: commonProvider.isDrawerOpen
                    ? MediaQuery.of(context).size.width - 80
                    : MediaQuery.of(context).size.width - 25,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   alignment: Alignment.center,
                            //   width: 70,
                            //   child: Image.asset(
                            //     "assets/images/paymentss.png",
                            //     height: 55,
                            //   ),
                            // ),
                            Row(
                              children: [
                                const Text(
                                  "Name :",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF676767),
                                  ),
                                ),
                                Text("${card["accountholdername"]}")
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "A/c Number :",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF676767),
                              ),
                            ),
                            Text("${card["accountnumber"]}")
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Text(
                              "Routing No :",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF676767),
                              ),
                            ),
                            Text("${card["accountroutingnumber"]}")
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              card['primaryaccount']
                                  ? const Icon(
                                      Icons.lock,
                                      color: Colors.red,
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        Map requestData = {
                                          "bankAccountId": card['_id']
                                        };
                                        commonProvider.setprimaryaccount(
                                            context, requestData);
                                      },
                                      child: const Text("Set Primary A/c"),
                                    ),
                              IconButton(
                                onPressed: () {
                                  Map requestData = {
                                    "bankAccountId": card['stripebanktoken']
                                  };
                                  commonProvider.deletevendorstripebankdata(
                                    context,
                                    requestData,
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Row commonRow(title, subtitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF676767),
          ),
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFFA6A6A6),
          ),
        )
      ],
    );
  }
}
