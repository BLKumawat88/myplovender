import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_plo_vendor/auth/login/login_screen.dart';
import 'package:my_plo_vendor/auth/otpverification/otp_verification.dart';
import 'package:my_plo_vendor/auth/signup/signup_screen.dart';
import 'package:my_plo_vendor/auth/splash/splash_screen.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:my_plo_vendor/side_bar/side_bar_drawer.dart';
import 'package:my_plo_vendor/views/home/current_gig.dart';
import 'package:my_plo_vendor/views/home/edit_current_gig.dart';
import 'package:my_plo_vendor/views/home/home_page.dart';
import 'package:my_plo_vendor/views/home/membership.dart';
import 'package:my_plo_vendor/views/home/orders.dart';
import 'package:my_plo_vendor/views/home/post_gig.dart';
import 'package:my_plo_vendor/views/notification/notification_screen.dart';
import 'package:my_plo_vendor/views/payments/add_payment.dart';
import 'package:my_plo_vendor/views/payments/add_payment_method_one.dart';
import 'package:my_plo_vendor/views/payments/add_payment_method_two.dart';
import 'package:my_plo_vendor/views/profile/profile.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommonProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme:
                GoogleFonts.robotoTextTheme(Theme.of(context).textTheme)),
        // home: const GigScreen(),
        home: const SplashScreen(),
        routes: {
          "/current_gig": (context) => const CurrentGigScreen(),
          "/membership": (context) => const MembershipScreen(),
          "/orders": (context) => const OrdersScreen(),
          "/post_gig": (context) => const PostGigScreen(),
          "/otp_verification": (context) => const OtpVerification(),
          "/home_page": (context) => const MyHomePage(),
          "/profile": (context) => const ProfileScreen(),
          "/login_screen": (context) => const LoginScreen(),
          "/signup_screen": (context) => const SignupScreen(),
          "/side_bar_drawer": (context) => const DrawerScreen(
                routeName: "/home_screen",
                routeId: "1",
              ),
          "/add_payment": (context) => const AddPaymentScreen(),
          "/aad_payment_one": (context) => const AddPaymentMethodOne(),
          "/aad_payment_two": (context) => const AddPaymentMethodTwo(),
          "/edit_current_gig": (context) => const EditCurrentGig(),
          "/notification_screen": (context) => const NotificationScreen()
        },
      ),
    );
  }
}
