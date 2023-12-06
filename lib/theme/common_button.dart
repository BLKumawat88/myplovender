import 'package:flutter/material.dart';

import 'media_query.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final Function callBack;

  const CommonButton({super.key, required this.text, required this.callBack});

  @override
  Widget build(BuildContext context) {
    var size = Sizess();
    return InkWell(
      onTap: () {
        callBack();
      },
      child: Container(
        // margin: const EdgeInsets.only(bottom: 10, left: 0),
        width: size.width(context),
        height: size.height(context) * .07,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/common_button.png"),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 18,
                color: Color(0xFFF5F5F5),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class CommonButtonWithArgument extends StatelessWidget {
  final String text;
  final Function(BuildContext) callBack;

  const CommonButtonWithArgument(
      {super.key, required this.text, required this.callBack});

  @override
  Widget build(BuildContext context) {
    var size = Sizess();
    return InkWell(
      onTap: () {
        callBack(context);
      },
      child: Container(
        margin: const EdgeInsets.only(right: 0, bottom: 10, left: 0),
        width: size.width(context),
        height: size.height(context) * .08,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/common_button.png"),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 17,
                color: Color(0xFFffffff),
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
