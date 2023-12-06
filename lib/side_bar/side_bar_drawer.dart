import 'package:flutter/material.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:my_plo_vendor/theme/commonAppBar.dart';
import 'package:my_plo_vendor/theme/media_query.dart';
import 'package:my_plo_vendor/views/chat/chats.dart';
import 'package:my_plo_vendor/views/home/membership.dart';
import 'package:my_plo_vendor/views/home/post_gig.dart';
import 'package:my_plo_vendor/views/payments/payments.dart';
import 'package:provider/provider.dart';

import '../views/home/current_gig.dart';
import '../views/home/home_page.dart';
import '../views/home/orders.dart';
import '../views/introduction/introduction_screen.dart';

class DrawerScreen extends StatefulWidget {
  final String routeName;
  final String routeId;
  const DrawerScreen(
      {super.key, required this.routeName, required this.routeId});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List drawerList = [
    {
      "image": "assets/images/home.png",
      "routeUrl": "/home_screen",
      "backColor": true,
      "routeid": "1",
    },
    {
      "image": "assets/images/post_a_gig.png",
      "routeUrl": "/post_gig",
      "backColor": false,
      "routeid": "2",
    },
    {
      "image": "assets/images/current_gig.png",
      "routeUrl": "/current_gig",
      "backColor": false,
      "routeid": "3",
    },
    {
      "image": "assets/images/chat.png",
      "routeUrl": "/chats",
      "backColor": false,
      "routeid": "4",
    },
    {
      "image": "assets/images/orders.png",
      "routeUrl": "/orders",
      "backColor": false,
      "routeid": "5",
    },
    {
      "image": "assets/images/Payments.png",
      "routeUrl": "/payments",
      "backColor": false,
      "routeid": "6",
    },
    {
      "image": "assets/images/membership.png",
      "routeUrl": "/membership",
      "backColor": false,
      "routeid": "7",
    },
    {
      "image": "assets/images/introductionicon.png",
      "routeUrl": "/introduction",
      "backColor": false,
      "routeid": "9",
    },
    {
      "image": "assets/images/logout.png",
      "routeUrl": "/loguot",
      "backColor": false,
      "routeid": "8",
    },
  ];
  String routeName = "/home_screen";
  String routeId = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    routeName = widget.routeName;
    routeId = widget.routeId;
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    var size = Sizess();
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      onDrawerChanged: (isOpened) {
        commonProvider.updateOpneDrawerValue(isOpened);
      },
      appBar: CommonAppBar.returnCommonAppBar(context),
      drawer: Container(
        height: size.height(context) * .75,
        width: 70,
        decoration: const BoxDecoration(
          color: Color(0xFF0E6BFD),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ...drawerList.map(
                  (e) => InkWell(
                    onTap: () {
                      setState(() {
                        routeName = e["routeUrl"];
                        routeId = e['routeid'];
                        // for (var i = 0; i < drawerList.length; i++) {
                        //   if (drawerList[i]["routeUrl"] == routeName) {
                        //     setState(() {
                        //       drawerList[i]["backColor"] = true;
                        //     });
                        //   } else {
                        //     setState(() {
                        //       drawerList[i]["backColor"] = false;
                        //     });
                        //   }
                        // }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.only(
                          left: 15, right: 20, top: 10, bottom: 15),
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              topLeft: Radius.circular(20)),
                          color: e["routeid"] == routeId
                              ? Colors.white
                              : const Color(0xFF0E6BFD)),
                      child: Image.asset(
                        e["image"],
                        width: 25,
                        color: e["routeid"] == routeId
                            ? const Color(0xFF0E6BFD)
                            : const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 2.7),
                        height: 150,
                        width: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                routeName == "/home_screen"
                    ? const MyHomePage()
                    : routeName == "/current_gig"
                        ? const CurrentGigScreen()
                        : routeName == "/orders"
                            ? const OrdersScreen()
                            : routeName == "/payments"
                                ? const PaymentsScreen()
                                : routeName == "/chats"
                                    ? const ChatScreen()
                                    : routeName == "/post_gig"
                                        ? const PostGigScreen()
                                        : routeName == "/membership"
                                            ? const MembershipScreen()
                                            : routeName == "/home_screen"
                                                ? const MyHomePage()
                                                : routeName == "/introduction"
                                                    ? const IntroductionImage()
                                                    : const SizedBox()

                // Column(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     ...data.map(
                //       (e) => Padding(
                //         padding: const EdgeInsets.only(bottom: 10),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             color: Colors.red,
                //             borderRadius: BorderRadius.circular(20),
                //           ),
                //           height: 150,
                //           width: isDrawerOpen
                //               ? MediaQuery.of(context).size.width - 75
                //               : MediaQuery.of(context).size.width - 10,
                //           child: const Padding(
                //             padding: EdgeInsets.all(8.0),
                //             child: Text("HHHH"),
                //           ),
                //         ),
                //       ),
                //     )
                //   ],
                // )
              ],
            )
          ],
        ),
      )),
    );
  }
}
