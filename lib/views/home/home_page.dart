import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:provider/provider.dart';

import '../../side_bar/side_bar_drawer.dart';
import '../../theme/media_query.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getHomeScreenDashBoardData(context);
    });

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Consumer<CommonProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Dashboard",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(
                        0xFF000000,
                      ),
                    ),
                  ),
                ),
                ...commonProvider.homeList.map(
                  (home) => ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 5),
                      width: commonProvider.isDrawerOpen
                          ? MediaQuery.of(context).size.width - 80
                          : MediaQuery.of(context).size.width - 25,
                      height: commonProvider.isDrawerOpen ? 130 : 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            home["backgroundImage"],
                          ),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          if (home['title'] == "Services") {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DrawerScreen(
                                  routeName: "/current_gig",
                                  routeId: "3",
                                ),
                              ),
                              (route) => false,
                            );
                          } else if (home['title'] == "Messages") {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DrawerScreen(
                                  routeName: "/chats",
                                  routeId: "4",
                                ),
                              ),
                              (route) => false,
                            );
                          } else if (home['title'] == "Payment") {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DrawerScreen(
                                  routeName: "/payments",
                                  routeId: "6",
                                ),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Image.asset(
                                home["image"],
                                width: 50,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  // width: size.width(context) * .27,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 3),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          home["title"],
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFFFFFFFF)),
                                        ),
                                        Image.asset(
                                          home["subImage"],
                                          width: size.width(context) * .05,
                                          height: size.height(context) * .05,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      home["point"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFFFFFFF)),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: Text(
                                        home["totle"],
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFFFFFFFF)),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ));
  }
}
