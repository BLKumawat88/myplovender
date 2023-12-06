import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../theme/media_query.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  final List membershipCard = const [
    {
      "image": "assets/images/memberships.png",
      "cost": "\$4.99",
      "month": " /month",
      "expiredDate": "Expired On 31 March"
    }
  ];

  getIsPlanExpiredOrNot(startData, endData) {
    print(startData);
    if (startData == "" && endData == "") {
      return true;
    } else {
      // String currentData = DateTime.now().toString();
      // DateTime eDate = DateTime.parse(endData);
      // DateTime sDate = DateTime.parse(currentData);
      // Duration diff1 = eDate.difference(sDate);
      // print("diffrence $diff1");
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getUserPaymentInfo(context);
    });
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Membership",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                ...membershipCard.map(
                  (e) => Container(
                    height: 120,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    width: commonProvider.isDrawerOpen
                        ? MediaQuery.of(context).size.width - 80
                        : MediaQuery.of(context).size.width - 25,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Image.asset(
                                    e["image"],
                                    width: size.width(context) * .1,
                                  ),
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          "\$0.99",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xFF838383)),
                                        ),
                                        Text(
                                          e["month"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xFF838383)),
                                        ),
                                      ],
                                    ),
                                    Consumer<CommonProvider>(
                                      builder: (context, value, child) => Text(
                                        commonProvider.expiredDate == ""
                                            ? ""
                                            : "Expired On ${DateFormat.yMd().format(
                                                DateTime.parse(
                                                  commonProvider.expiredDate,
                                                ),
                                              )}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF838383)),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 30,
                  child: Container(
                    height: 25,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green,
                    ),
                    child: Center(
                      child: getIsPlanExpiredOrNot(commonProvider.expiredDate,
                              commonProvider.expiredDate)
                          ? const Text(
                              "Active",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF)),
                            )
                          : const Text(
                              "Expired",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFFFFFFFF)),
                            ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: commonProvider.isDrawerOpen
                  ? const EdgeInsets.only(left: 25)
                  : const EdgeInsets.only(left: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "To Renew Your Plan Go Our Website. ",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF676767),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final Uri _url = Uri.parse(
                          'https://myplovendor.itworkshop.in/login/${commonProvider.user_token}');

                      if (!await launchUrl(_url)) {
                        throw Exception('Could not launch $_url');
                      }
                    },
                    child: const Text(
                      "Click Here",
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFF903E3),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
