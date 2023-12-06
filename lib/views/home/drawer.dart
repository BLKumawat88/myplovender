import 'package:flutter/material.dart';
import 'package:my_plo_vendor/theme/media_query.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  List drawer = [
    "assets/images/home.png",
    "assets/images/current_gig.png",
    "assets/images/current_gig.png",
    "assets/images/chat.png",
    "assets/images/orders.png",
    "assets/images/Payments.png",
    "assets/images/membership.png",
    "assets/images/membership.png",
  ];
  @override
  Widget build(BuildContext context) {
    var size = Sizess();
    return SafeArea(
      child: Container(
        height: size.height(context) * .7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Drawer(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            backgroundColor: Colors.blue,
            width: size.width(context) * .2,
            child: ListView.builder(
              itemCount: drawer.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  drawer[index],
                  width: 30,
                );
              },
            )),
      ),
    );
  }
}
