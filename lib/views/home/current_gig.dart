import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:provider/provider.dart';

import '../../theme/media_query.dart';

class CurrentGigScreen extends StatelessWidget {
  const CurrentGigScreen({super.key});

  final List currentGigList = const [
    {
      "image": "assets/images/gigs.png",
      "title": "Microsoft Power Automate Desktop Architect",
      "subTitle":
          "We seek an exceptional Microsoft Power Automate Desktop Architect to join our dynamicteam. As the driving force behind our RPA initiatives, you will be crucial in streamlining our life sciences operations and enhancing the customer experience.",
      "categoryName": " Category Name",
      "country": "India",
    },
    {
      "image": "assets/images/gigs.png",
      "title": "Microsoft Power Automate Desktop Architect",
      "subTitle":
          "We seek an exceptional Microsoft Power Automate Desktop Architect to join our dynamicteam. As the driving force behind our RPA initiatives, you will be crucial in streamlining our life sciences operations and enhancing the customer experience.",
      "categoryName": " Category Name",
      "country": "India",
    },
  ];

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getAllgigList(context);
    });
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.black));
    var size = Sizess();
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Current Services",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(
                    0xFF000000,
                  ),
                ),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 10),
            //   child: Text(
            //     "Lorem Ipsum is simply dummy text of the",
            //     style: TextStyle(
            //       fontSize: 10,
            //       fontWeight: FontWeight.w400,
            //       color: Color(
            //         0xFF676767,
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            ...commonProvider.allgigList.map(
              (e) => Container(
                margin: commonProvider.isDrawerOpen
                    ? const EdgeInsets.symmetric(
                        horizontal: 5,
                      )
                    : const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                width: commonProvider.isDrawerOpen
                    ? MediaQuery.of(context).size.width - 75
                    : MediaQuery.of(context).size.width - 15,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                      8.0,
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset(
                                  'assets/images/gigs.png',
                                  width: 40,
                                ),
                                SizedBox(
                                    width: commonProvider.isDrawerOpen
                                        ? size.width(context) * .45
                                        : size.width(context) * .5,
                                    child: Text(
                                      e["title"],
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(
                                          0xFF676767,
                                        ),
                                      ),
                                    )),
                                PopupMenuButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  icon: const Icon(Icons.more_vert),
                                  onSelected: (value) {
                                    if (value == "2") {
                                      Map requestData = {"gigId": e['_id']};
                                      commonProvider.deleteCurrentGig(
                                        context,
                                        requestData,
                                      );
                                    } else {
                                      print("Edit ${e['_id']}");
                                      Map requestData = {"gigId": e['_id']};
                                      commonProvider.getCurrentGigDataToEdit(
                                        context,
                                        requestData,
                                      );
                                    }
                                  },
                                  itemBuilder: (BuildContext context) => [
                                    const PopupMenuItem(
                                      value: '1',
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const PopupMenuItem(
                                      value: '2',
                                      child: Text(
                                        'Delete',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e["description"],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/india.png",
                                  width: 15,
                                ),
                                Text(
                                  e["category"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFFA6A6A6),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/india.png",
                                  width: 15,
                                ),
                                Text(
                                  e["location"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(
                                      0xFFA6A6A6,
                                    ),
                                  ),
                                ),
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
          ],
        );
      },
    );
  }
}
