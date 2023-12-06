import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:my_plo_vendor/theme/commonDailog.dart';
import 'package:provider/provider.dart';
import '../../controllers/provider_controller.dart';
import '../../theme/common_color.dart';
import '../../theme/common_textfield_style.dart';
import '../../theme/media_query.dart';

class MessageScreen extends StatefulWidget {
  final data;
  const MessageScreen({super.key, required this.data});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final _textController = TextEditingController();
  final ScrollController _listScrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  @override
  void sendMessage() {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    if (_textController.text == "") {
      CommonCirculer.showErrorMessage(context, "Required Message");
    } else {
      Map sendMessageData = {
        "content": _textController.text,
        "gigId": widget.data['gigId']['_id'],
        "sentby": "VENDOR",
        "userid": widget.data['userid']['_id'],
        "vendorid": widget.data['vendorid']['_id']
      };
      commonProvider.getSendMessageUser(context, sendMessageData);

      setState(() {
        _textController.text = "";
      });
      Timer(
        const Duration(seconds: 4),
        () => jumpToBotton(),
      );
    }
  }

  @override
  void initState() {
    jumpToBotton();
    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  jumpToBotton() async {
    setState(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 1),
            curve: Curves.fastOutSlowIn);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = Sizess();
    CommonProvider commonProvider = Provider.of(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: const Color(0xFF0E6BFD),
        title: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              width: 40,
              child: Image.asset("assets/images/ellipse.png", width: 20),
              // child: Image.asset(
              //   widget.data["image"],
              //   width: 20,
              //   fit: BoxFit.cover,
              // ),
            ),
            Text(
              widget.data["userid"]['userName'].toString(),
            ),
          ],
        ),
      ),
      body: Consumer<CommonProvider>(
        builder: (context, value, child) {
          return Column(children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: commonProvider.getShowAllMessage.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  var message = commonProvider.getShowAllMessage[index];
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 14, right: 14, top: 10, bottom: 10),
                        child: Align(
                          alignment: (message['sentby'] == "USER"
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: (message['sentby'] == "USER"
                                  ? const Color(0xFFFFFFFF)
                                  : const Color(0xFFF903E3)),
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              message['message'].toString(),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: TextFormField(
                          focusNode: _focusNode,
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: const TextStyle(color: Colors.black54),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                sendMessage();
                              },
                              child: Container(
                                height: 50,
                                width: 30,
                                margin: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0xFFF903E3)),
                                child: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            fillColor:
                                Color(CommonColor.textFieldsBackgroundColor),
                            enabledBorder: AuthCommonTheme.enabledBorder,
                            focusedBorder: AuthCommonTheme.enabledBorder,
                            errorBorder: AuthCommonTheme.errorBorder,
                            border: AuthCommonTheme.border,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
