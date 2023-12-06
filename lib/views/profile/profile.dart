import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controllers/provider_controller.dart';
import '../../theme/media_query.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _locationController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryController = TextEditingController();
  final _descController = TextEditingController();
  String stateDropDown = '';
  String finalImage = "";

  final _formKey = GlobalKey<FormState>();

  _showPicker(context) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library,
                        color: Color(0xFF7A112F)),
                    title: const Text('Gallery'),
                    onTap: () async {
                      upload();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: Color(0xFF7A112F),
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    camerapicker();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  upload() async {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    try {
      final XFile? result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (result != null) {
        Uint8List imagebytes = await result.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);
        finalImage = "data:image/jpeg;base64,$base64string";
        Map requestData = {"image": finalImage};
        // ignore: use_build_context_synchronously
        commonProvider.updateUserProfileImage(context, requestData);
      } else {}
    } on PlatformException {}
  }

  camerapicker() async {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    try {
      final XFile? result = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (result != null) {
        Uint8List imagebytes = await result.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);
        finalImage = "data:image/jpeg;base64,$base64string";

        Map requestData = {"image": finalImage};
        // ignore: use_build_context_synchronously
        commonProvider.updateUserProfileImage(context, requestData);
      } else {}
    } on PlatformException {}
  }

  @override
  void initState() {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    super.initState();
    _nameController.text = commonProvider.userProfileData['name'];
    _numberController.text = commonProvider.userProfileData['number'];
    stateDropDown = commonProvider.userProfileData['location'];
    _locationController.text = commonProvider.userProfileData['location'];
    _emailController.text = commonProvider.userProfileData['email'];
    _descController.text = commonProvider.userProfileData['description'];
    _countryController.text = commonProvider.userProfileData['country'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: const Color(
          0xFF0E6BFD,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width(context),
            decoration: const BoxDecoration(
              // color: Colors.red,
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/profileBackground.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                        left: 20,
                        right: 20,
                      ),
                      width: size.width(
                        context,
                      ),
                      height: 180,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${commonProvider.userProfileData['name']}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const Text(
                                "Vendor",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(
                                    0xFFF903E3,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Consumer<CommonProvider>(
                      builder: (context, value, child) => InkWell(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(
                              "${commonProvider.baseUrlForImagesAndVideo}${commonProvider.userProfileData['userImage']}"),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 25, right: 25),
                  child: Column(
                    children: [
                      commonTextFeild(
                        "Name",
                        "Enter your name",
                        _nameController,
                        true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      commonTextFeild(
                        "Number",
                        "Phone Number",
                        _numberController,
                        true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<CommonProvider>(
                        builder: (context, value, child) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: 50,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.0, color: Color(0xFFF903E3)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isDense: true,
                              value: stateDropDown,
                              isExpanded: true,
                              menuMaxHeight: 350,
                              items: [
                                const DropdownMenuItem(
                                  value: "",
                                  child: Text(
                                    "State",
                                    style: TextStyle(color: Color(0xFFF903E3)),
                                  ),
                                ),
                                ...commonProvider.dropdwonList.map((e) {
                                  return DropdownMenuItem(
                                    value: e["name"],
                                    child: Text(e["name"],
                                        style: const TextStyle(
                                          color: Color(
                                            0xFFF903E3,
                                          ),
                                        )),
                                  );
                                })
                              ],
                              onChanged: (value) {
                                setState(
                                  () {
                                    stateDropDown = value!;
                                    print(stateDropDown);
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // commonTextFeild(
                      //   "State",
                      //   "Location",
                      //   _locationController,
                      //   true,
                      // ),

                      const SizedBox(
                        height: 20,
                      ),
                      commonTextFeild(
                        "Email",
                        "Email",
                        _emailController,
                        false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      commonTextFeild(
                        "Country",
                        "Country",
                        _countryController,
                        false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 130,
                        child: TextFormField(
                          maxLines: 30,
                          controller: _descController,
                          decoration: const InputDecoration(
                            labelText: "Description",
                            hintText:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFFF903E3),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(0xFFF903E3),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            Map requestData = {
                              "vendorname": _nameController.text,
                              "vendoraddress": _emailController.text,
                              "vendormobile": _numberController.text,
                              "vendordescription": _descController.text,
                              "vendorstate": stateDropDown,
                              "vendorcountry": _countryController.text
                            };
                            commonProvider.updateUserProfile(
                              context,
                              requestData,
                            );
                          },
                          child: const Text("Submit"),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField commonTextFeild(
      String labels, String hints, TextEditingController controls, isEnable) {
    return TextFormField(
      enabled: isEnable,
      controller: controls,
      decoration: InputDecoration(
        labelText: labels,
        hintText: hints,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFFF903E3),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Color(0xFF0E6BFD),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
      ),
    );
  }
}
