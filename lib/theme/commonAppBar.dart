import 'package:flutter/material.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:provider/provider.dart';

class CommonAppBar {
  static AppBar returnCommonAppBar(context) {
    CommonProvider provider = Provider.of(context, listen: false);
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.only(left: 10),
        child: Image.asset(
          "assets/images/my_plo.png",
          // width: 70,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            provider.stateDropDwon(context, 1);
          },
          child: Container(
            margin: const EdgeInsets.only(right: 20),
            child: Image.asset(
              "assets/images/Frame.png",
              width: 30,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20),
          child: InkWell(
            onTap: () {
              provider.getAllNotification(context);
            },
            child: Image.asset(
              "assets/images/Group 1.png",
              width: 30,
            ),
          ),
        )
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
