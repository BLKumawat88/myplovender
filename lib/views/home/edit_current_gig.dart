import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_plo_vendor/theme/common_button.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../controllers/provider_controller.dart';
import '../../theme/media_query.dart';
import '../introduction/video_item.dart';

class EditCurrentGig extends StatefulWidget {
  const EditCurrentGig({super.key});

  @override
  State<EditCurrentGig> createState() => _EditCurrentGigState();
}

class _EditCurrentGigState extends State<EditCurrentGig> {
  List<String> img = [];
  List finalImage = [];

  upload() async {
    try {
      final XFile? result = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (result != null) {
        File? file = File(result.path);
        setState(() {
          img.add(file.path);
        });
        Uint8List imagebytes = await result.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);

        finalImage.add("data:image/jpeg;base64,$base64string");
      } else {}
    } on PlatformException {}
  }

  camerapicker() async {
    try {
      final XFile? result = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (result != null) {
        File? file = File(result.path);
        setState(() {
          img.add(file.path);
        });
        Uint8List imagebytes = await result.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);

        finalImage.add("data:image/jpeg;base64,$base64string");
      } else {}
    } on PlatformException {}
  }

  List dropDwonList = [
    {"title": "Category 1", "value": "1"},
    {"title": "Category 2", "value": "2"},
    {"title": "Category 3", "value": "3"},
  ];

  List dropDwonSecondList = [
    {"title": "Category 1", "value": "1"},
    {"title": "Category 2", "value": "2"},
    {"title": "Category 3", "value": "3"},
  ];
  String defaultValue = '';
  String defaultSecondValue = '';

  TextEditingController _title = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _location = TextEditingController();
  TextEditingController _description = TextEditingController();

  @override
  void initState() {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    // TODO: implement initState
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   commonProvider.getGigCategory(context);
    // });
    defaultValue = commonProvider.currentSelectedCategoryID;
    defaultSecondValue = commonProvider.currentSelectedSubcategoryID;
    _title.text = commonProvider.currentGigTitle;
    _price.text = commonProvider.currentGigPrice;
    _location.text = commonProvider.currentGigLocatioin;
    _description.text = commonProvider.currentGigDescription;
  }

  _showPickers(
    context,
  ) {
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
                      uploadVideo();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                    color: Color(0xFF7A112F),
                  ),
                  title: const Text('Camera'),
                  onTap: () {
                    videoPick();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  File? videoFile;
  String videopicks = "";

  uploadVideo() async {
    try {
      final XFile? result = await ImagePicker().pickVideo(
        source: ImageSource.gallery,
      );

      if (result != null) {
        videoFile = File(result.path);
        setState(() {});
        Uint8List imagebytes = await result.readAsBytes(); //convert to bytes
        String base64string = base64.encode(imagebytes);

        videopicks = "data:image/jpeg;base64,$base64string";
      } else {}
    } on PlatformException {}
  }

  videoPick() async {
    try {
      final XFile? result = await ImagePicker().pickVideo(
        source: ImageSource.camera,
      );
      if (result != null) {
        videoFile = File(result.path);
        setState(() {});
        Uint8List imagebytes = await result.readAsBytes();
        String base64string = base64.encode(imagebytes);
        videopicks = "data:image/jpeg;base64,$base64string";
      } else {}
    } on PlatformException {}
  }

  void saveImage() async {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    Map requestData = {
      "gigId": commonProvider.slectedGigId,
      "title": _title.text,
      "price": _price.text,
      "description": _description.text,
      "location": _location.text,
      "subcategory": defaultSecondValue,
      "category": defaultValue,
      "images": finalImage,
      "video": videopicks,
    };
    print("requestData $requestData");
    commonProvider.addNewGig(context, requestData);
  }

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Gig"),
      ),
      body: Consumer<CommonProvider>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      ...commonProvider.allImagesforEditGit
                          .map((imagedata) => Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.network(
                                      "${commonProvider.baseUrlForImagesAndVideo}${imagedata['image']}",
                                      width: 80,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    // left: commonProvider.isDrawerOpen
                                    //     ? size.height(context) * .10
                                    //     : size.height(context) * .12,
                                    child: GestureDetector(
                                      onTap: () {
                                        print(
                                            "daffffaf $imagedata  ${commonProvider.slectedGigId}");
                                        Map requestData = {
                                          "id": commonProvider.slectedGigId,
                                          "imageIdToDelete": imagedata['_id']
                                        };
                                        commonProvider.deleteAddedGig(
                                            context, requestData);
                                      },
                                      child: Image.asset(
                                        "assets/images/cancel_icon.png",
                                        width: size.width(context) * .045,
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                          .toList(),
                    ],
                  ),
                  Wrap(
                    children: [
                      ...img.map(
                        (e) => Container(
                          height: commonProvider.isDrawerOpen
                              ? size.height(context) * .12
                              : size.height(context) * .15,
                          width: commonProvider.isDrawerOpen
                              ? size.height(context) * .12
                              : size.height(context) * .15,
                          child: Stack(
                            children: [
                              // Positioned(
                              //   left: commonProvider.isDrawerOpen
                              //       ? size.height(context) * .10
                              //       : size.height(context) * .12,
                              //   child: GestureDetector(
                              //     onTap: () {},
                              //     child: Image.asset(
                              //       "assets/images/cancel_icon.png",
                              //       width: size.width(context) * .045,
                              //     ),
                              //   ),
                              // ),
                              Positioned(
                                top: size.height(context) * .02,
                                child: GestureDetector(
                                  onTap: () {
                                    // _showPicker(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        6,
                                      ),
                                      child: Image.file(
                                        File(e),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  commonProvider.videoUrl == ""
                      ? const SizedBox()
                      : Stack(
                          children: [
                            SizedBox(
                              height: 150,
                              child: VideoItems(
                                videoPlayerController:
                                    VideoPlayerController.networkUrl(
                                  Uri.parse(
                                      "${commonProvider.baseUrlForImagesAndVideo}${commonProvider.videoUrl}"),
                                ),

                                // VideoPlayerController.network(commonProvider.videoUrl),
                                looping: true,
                                autoplay: false,
                              ),
                            ),
                            Positioned(
                              // left: commonProvider.isDrawerOpen
                              //     ? size.height(context) * .10
                              //     : size.height(context) * .12,
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "assets/images/cancel_icon.png",
                                  width: size.width(context) * .045,
                                ),
                              ),
                            ),
                          ],
                        ),
                  ElevatedButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: img.isEmpty
                        ? const Text('Upload Image')
                        : const Text("Add More Images"),
                  ),
                  SizedBox(
                    // height: commonProvider.isDrawerOpen
                    //     ? size.height(context) * .10
                    //     : size.height(context) * .12,
                    // width: commonProvider.isDrawerOpen
                    //     ? size.height(context) * .10
                    //     : size.height(context) * .12,
                    child: videoFile == null
                        ? const SizedBox()
                        : SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Text(videoFile!.path)),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _showPickers(context);
                      },
                      child: const Text('Upload Video')),
                  SizedBox(
                    height: size.height(context) * .75,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
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
                                value: defaultValue,
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  const DropdownMenuItem(
                                    value: "",
                                    child: Text(
                                      "Choose Category",
                                      style:
                                          TextStyle(color: Color(0xFFF903E3)),
                                    ),
                                  ),
                                  ...commonProvider.gigCategoryList.map((e) {
                                    return DropdownMenuItem(
                                      value: e["_id"],
                                      child: Text(
                                        e["name"],
                                        style: const TextStyle(
                                            color: Color(0xFFF903E3)),
                                      ),
                                    );
                                  })
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    defaultValue = value!;
                                  });
                                  if (defaultValue != "") {
                                    Map requestData = {
                                      "parentcat": defaultValue
                                    };
                                    defaultSecondValue = "";
                                    commonProvider.getSubGigCategory(
                                      context,
                                      requestData,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                value: defaultSecondValue,
                                isExpanded: true,
                                menuMaxHeight: 350,
                                items: [
                                  const DropdownMenuItem(
                                    value: "",
                                    child: Text(
                                      "Sub category",
                                      style:
                                          TextStyle(color: Color(0xFFF903E3)),
                                    ),
                                  ),
                                  ...commonProvider.gigSubCategoryList.map((e) {
                                    return DropdownMenuItem(
                                      value: e["_id"],
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
                                      defaultSecondValue = value!;
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        textFieldWidget("Title", "My Plo", _title),
                        const SizedBox(height: 15),
                        textFieldWidget("Price", "My Plo", _price),
                        const SizedBox(height: 15),
                        textFieldWidget("Location", "My Plo", _location),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: 100,
                          child: TextFormField(
                            controller: _description,
                            maxLines: 20,
                            style: const TextStyle(color: Color(0xFFF903E3)),
                            decoration: InputDecoration(
                                labelText: "Description",
                                labelStyle:
                                    const TextStyle(color: Color(0xFFF903E3)),
                                hintText: "My Plo",
                                errorBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF903E3),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Color(0xFFF903E3),
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF903E3), width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFF903E3), width: 1),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10)),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        CommonButton(text: "Update Gig", callBack: saveImage),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  TextFormField textFieldWidget(
      lebleTexts, hindtTexts, TextEditingController controllerName) {
    return TextFormField(
      controller: controllerName,
      style: const TextStyle(color: Color(0xFFF903E3)),
      decoration: InputDecoration(
          labelText: lebleTexts,
          labelStyle: const TextStyle(color: Color(0xFFF903E3)),
          hintText: hindtTexts,
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFF903E3),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xFFF903E3),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFF903E3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFF903E3), width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 5)),
    );
  }

  _showPicker(
    context,
  ) {
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
}
