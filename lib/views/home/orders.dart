import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:provider/provider.dart';

import '../../theme/media_query.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  final List orderList = const [
    {
      "image": "assets/images/order.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "date": "date -",
      "dateOfAmountReceived": " 12/12/2023",
    },
    {
      "image": "assets/images/order.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "date": "date -",
      "dateOfAmountReceived": " 12/12/2023",
    },
    {
      "image": "assets/images/order.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "date": "date -",
      "dateOfAmountReceived": " 12/12/2023",
    },
    {
      "image": "assets/images/order.png",
      "title": "Microsoft Power Automate ..",
      "buyerName": "Buyer Name -",
      "name": " Anshul",
      "date": "date -",
      "dateOfAmountReceived": " 12/12/2023",
    },
  ];

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getOrdersList(context);
    });
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Consumer<CommonProvider>(
          builder: (context, value, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Orders",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000)),
                ),
              ),
              // const Padding(
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
              const SizedBox(
                height: 20,
              ),
              ...commonProvider.ordersList.map(
                (card) => Container(
                  margin: commonProvider.isDrawerOpen
                      ? const EdgeInsets.symmetric(horizontal: 5)
                      : const EdgeInsets.symmetric(vertical: 0),
                  width: commonProvider.isDrawerOpen
                      ? MediaQuery.of(context).size.width - 75
                      : MediaQuery.of(context).size.width - 15,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: commonProvider.isDrawerOpen
                          ? const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5)
                          : const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              print("vender id ${card['_id']}");
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(vertical: 20),
                                //   child: Image.asset(
                                //     "assets/images/order.png",
                                //     width: 55,
                                //   ),
                                // ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Service Title :",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF676767),
                                          ),
                                        ),
                                        Text(
                                          card["gigname"],
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF676767),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonRow(
                                        "Buyer Name - ", card["username"]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonRow(
                                      "Date : ",
                                      DateFormat.yMMMd().format(
                                        DateTime.parse(
                                          card["reqdate"],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonRow("Time : ", "${card["reqtime"]}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonRow("Payment Received : ",
                                        "\$ ${card["amount"]}"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    commonRow(
                                      "Status : ",
                                      card["status"] == "1"
                                          ? "Success"
                                          : "Feild",
                                    ),
                                  ],
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
          ),
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
            fontSize: 14,
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
