import 'package:flutter/material.dart';
import 'package:my_plo_vendor/theme/common_button.dart';
import 'package:provider/provider.dart';

import '../../controllers/provider_controller.dart';
import '../../theme/media_query.dart';

class AddPaymentScreen extends StatelessWidget {
  const AddPaymentScreen({super.key});

  void addPayments() {}
  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(statusBarColor: Colors.black));
    var size = Sizess();
    return Consumer<CommonProvider>(
      builder: (context, value, child) {
        return Container(
          margin: commonProvider.isDrawerOpen
              ? const EdgeInsets.symmetric(horizontal: 5, vertical: 2)
              : const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(
            horizontal: 2,
          ),
          width: commonProvider.isDrawerOpen
              ? MediaQuery.of(context).size.width - 75
              : MediaQuery.of(context).size.width - 15,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Payments",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000)),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Lorem Ipsum is simply dummy text of the",
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF676767)),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Image.asset(
                  'assets/images/add_payment.png',
                  height: 200,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CommonButton(
                    text: "Add Payment Method", callBack: addPayments),
              )
            ],
          ),
        );
      },
    );
  }
}
