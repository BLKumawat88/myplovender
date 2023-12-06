import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../services/services.dart';
import '../side_bar/side_bar_drawer.dart';
import '../theme/commonDailog.dart';
import '../views/chat/message_screen.dart';

class CommonProvider with ChangeNotifier {
  bool isDrawerOpen = false;
  String user_token = "";
  String baseUrlForImagesAndVideo = "";

  updateOpneDrawerValue(isOpenedValue) {
    isDrawerOpen = isOpenedValue;
    notifyListeners();
  }

  Future<void> userLogin(Map loginUser, context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);

        var result = await APICall.postRequest("/vendor/login", loginUser, '');
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          user_token = result['Authtoken'];

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DrawerScreen(
                  routeName: "/home_screen",
                  routeId: "1",
                ),
              ),
              (route) => false);
          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     '/side_bar_drawer', (Route<dynamic> route) => false);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List homeList = [
    {
      "backgroundImage": "assets/images/gigsBackImage.png",
      "image": "assets/images/gigsImage.png",
      "subImage": "assets/images/Group5.png",
      "title": "Services",
      "point": "",
      "totle": "Totle Gigs"
    },
    {
      "backgroundImage": "assets/images/messageBackImage.png",
      "image": "assets/images/messageImage.png",
      "subImage": "assets/images/Group5.png",
      "title": "Messages",
      "point": "",
      "totle": "Messages"
    },
    {
      "backgroundImage": "assets/images/paymentBackImage.png",
      "image": "assets/images/paymentImage.png",
      "subImage": "assets/images/Group5.png",
      "title": "Payment",
      "point": "",
      "totle": " Payments Received"
    },
  ];
  Future<void> getHomeScreenDashBoardData(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);

        var result = await APICall.postRequest(
            "/vendor/vendordashboarddata", {}, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          homeList[0]['point'] = result['gigsCount'].toString();
          homeList[1]['point'] = result['messagescount'].toString();
          homeList[2]['point'] = "\$ ${result['paymentreceived']}";
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Map userProfileData = {
    "name": "",
    "number": "",
    "location": "",
    "email": "",
    "country": "",
    "description": "",
    "userImage": ""
  };

  Future<void> getUserProfile(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.postRequest("/vendor/getvendordata", {}, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          log("$result");
          userProfileData['name'] = result['vendorData']['vendorname'];
          userProfileData['email'] = result['vendorData']['vendoremail'];
          userProfileData['location'] = result['vendorData']['vendorstate'];
          userProfileData['number'] = result['vendorData']['vendormobile'];
          userProfileData['country'] = result['vendorData']['vendorcountry'];
          baseUrlForImagesAndVideo = result['baseurl'];
          userProfileData['userImage'] = result['vendorData']['image'];
          userProfileData['description'] =
              result['vendorData']['vendordescription'];

          Navigator.of(context).pushNamed('/profile');
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> updateUserProfileImage(context, requestData) async {
    print("dfdfddfdfd");
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/vendor/updateProfileImage", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          userProfileData['userImage'] = result['image'];
          print("12345666${userProfileData['userImage']}");
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> updateUserProfile(context, requiredData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);

        var result = await APICall.postRequest(
            "/vendor/updatevendordata", requiredData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          CommonCirculer.hideLoading(context);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  //Post A Gig
  List gigCategoryList = [];
  Future<void> getGigCategory(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.getRequest("/gigs/getvendorcatdata", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          gigCategoryList = result['data'];
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List gigSubCategoryList = [];
  Future<void> getSubGigCategory(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/gigs/getvendorsubcatdata", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          gigSubCategoryList = result['data'];
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  String currentSelectedCategoryID = "";
  String currentSelectedSubcategoryID = "";

  String currentGigTitle = "";
  String currentGigPrice = "";
  String currentGigLocatioin = "";
  String currentGigDescription = "";
  String slectedGigId = "";
  List allImagesforEditGit = [];
  String videoUrl = "";

  Future<void> getCurrentGigDataToEdit(context, requestData) async {
    slectedGigId = requestData['gigId'];
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/gigs/getgigsdatabyid", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          log("result $result");
          currentSelectedCategoryID = result['data']['category'].toString();
          currentSelectedSubcategoryID =
              result['data']['subcategory'].toString();
          currentGigTitle = result['data']['title'];
          currentGigPrice = result['data']['price'].toString();
          currentGigLocatioin = result['data']['location'];
          currentGigDescription = result['data']['description'];
          baseUrlForImagesAndVideo = result['baseurl'];
          allImagesforEditGit = result['gigimages'];
          videoUrl = result['data']['video'];
          getGigCategoryToEdit(context);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> getGigCategoryToEdit(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.getRequest("/gigs/getvendorcatdata", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          gigCategoryList = result['data'];
          getSubGigCategoryToEdit(context);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  String introTitle = "";
  String videoTitle = "";
  Future<void> getIntroductionData(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.getRequest("/vendor/getVendorSiteData", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          print(result);
          baseUrlForImagesAndVideo = result['baseurl'];
          introTitle = result['data']['vendor_intro'];
          videoTitle = result['data']['video'];
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> getSubGigCategoryToEdit(context) async {
    Map requestData = {"parentcat": currentSelectedSubcategoryID};
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/gigs/getvendorsubcatdata", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          gigSubCategoryList = result['data'];
          if (gigSubCategoryList.isEmpty) {
            currentSelectedSubcategoryID = "";
          }
          Navigator.pushNamed(context, '/edit_current_gig');
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> addNewGig(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/mobile/addgigsdata", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          print(result);

          Navigator.of(context).pushNamedAndRemoveUntil(
              '/side_bar_drawer', (Route<dynamic> route) => false);
          CommonCirculer.showErrorMessage(context, result['message']);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> deleteAddedGig(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/gigs/deletegigimage", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          print(result);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List allgigList = [];
  Future<void> getAllgigList(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.getRequest("/gigs/getgigsdata", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          allgigList = result['data'];
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List allNotificationList = [];
  Future<void> getAllNotification(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.getRequest("/vendor/getnotificationdata", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          allNotificationList = result['data'];
          updateOrderStatus(context);
          Navigator.pushNamed(context, "/notification_screen");
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> updateOrderStatus(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        var result =
            await APICall.postRequest("/vendor/orderstatus", {}, user_token);
        if (result["status"] == "success") {}
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        print("Dsfsfs");
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> deleteCurrentGig(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/gigs/deletegig", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          getAllgigList(context);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List ordersList = [];
  Future<void> getOrdersList(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.getRequest("/vendor/getvendororder", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          ordersList = result['data'];
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List paymentMethodList = [];
  Future<void> getpaymentMethodList(context, status) async {
    print(user_token);
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        if (status) {
          CommonCirculer.showProgressIndicator(context);
        }
        var result =
            await APICall.getRequest("/payment/getvendorbankdata", user_token);
        if (status) {
          CommonCirculer.hideLoading(context);
        }
        if (result["status"] == "success") {
          paymentMethodList = result['data'];
          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        if (status) {
          CommonCirculer.showErrorMessage(context, error);
        }
      }
    }
  }

  Future<void> addUserBankDetailsMethod1(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/payment/addvendorstripedata", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          print("result $result");
          Navigator.pushNamed(context, '/aad_payment_two');
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> addUserBankDetailsMethod2(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/payment/addvendorstripebankdata", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          getpaymentMethodList(context, false);
          CommonCirculer.hideLoading(context);
          CommonCirculer.hideLoading(context);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List getChatUserList = [];
  Future<void> getUserChatList(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/chat/showallusermessage", {}, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          getChatUserList = result['data'];
          notifyListeners();
          print("get chat api response ${result['data'][0]['_id']}");
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  List getShowAllMessage = [];
  Map requestIdtoGetMessage = {"roomid": ""};
  Future<void> getChatDataById(
      context, requestData, requiredData, loadingStatus) async {
    requestIdtoGetMessage['roomid'] = requestData['roomid'];
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        if (loadingStatus) {
          CommonCirculer.showProgressIndicator(context);
        }

        var result = await APICall.postRequest(
            "/chat/getchatdatabyid", requestData, user_token);
        if (loadingStatus) {
          CommonCirculer.hideLoading(context);
        }

        if (result["status"] == "success") {
          getShowAllMessage = result['data'];
          notifyListeners();
          if (loadingStatus) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(data: requiredData),
              ),
            );
          } else {
            notifyListeners();
          }
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        if (loadingStatus) {
          CommonCirculer.hideLoading(context);
        }

        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> getSendMessageUser(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/chat/sendmessage", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          print("Response after sending message $result");
          getChatDataById(context, requestIdtoGetMessage, "", false);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> setprimaryaccount(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/payment/setprimaryaccount", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          getpaymentMethodList(context, true);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<void> deletevendorstripebankdata(context, requestData) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result = await APICall.postRequest(
            "/payment/deletevendorstripebankdata", requestData, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          getpaymentMethodList(context, true);
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  String expiredDate = "";

  Future<void> getUserPaymentInfo(context) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.postRequest("/vendor/getvendordata", {}, user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          expiredDate = result['vendorData']['membershipenddate'];

          notifyListeners();
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

// usa state dropdwon list api

  List dropdwonList = [];
  Future<void> stateDropDwon(context, statusForCallingAnotherAPi) async {
    if (!await checkInternetAvailableOrNot()) {
      CommonCirculer.showErrorMessage(context, "No Internet Connection");
      return;
    } else {
      try {
        CommonCirculer.showProgressIndicator(context);
        var result =
            await APICall.getRequest("/gigs/getstatesdata", user_token);
        CommonCirculer.hideLoading(context);
        if (result["status"] == "success") {
          dropdwonList = result['data'];
          notifyListeners();
          if (statusForCallingAnotherAPi == 1) {
            getUserProfile(context);
          }
        }
        if (result["status"] == "error") {
          CommonCirculer.showErrorMessage(context, result['message']);
        }
      } catch (error) {
        CommonCirculer.hideLoading(context);
        CommonCirculer.showErrorMessage(context, error);
      }
    }
  }

  Future<bool> checkInternetAvailableOrNot() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      print("Connected with Mobile");
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      print("Connected with Wifi");
      return true;
    } else {
      return false;
    }
  }
}
