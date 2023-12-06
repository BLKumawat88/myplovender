import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../controllers/provider_controller.dart';
import '../../theme/media_query.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  final List chatList = const [
    {
      "image": "assets/images/ellipse.png",
      "titleName": "DJI Mavic Mini 2",
      "chat": "You: Does it come with an additional box?",
      "time": "9:03 AM",
    },
    {
      "image": "assets/images/ellipse.png",
      "titleName": "DJI Mavic Mini 2",
      "chat": "You: Does it come with an additional box?",
      "time": "9:03 AM",
    },
    {
      "image": "assets/images/ellipse.png",
      "titleName": "DJI Mavic Mini 2",
      "chat": "You: Does it come with an additional box?",
      "time": "9:03 AM",
    },
    {
      "image": "assets/images/ellipse.png",
      "titleName": "DJI Mavic Mini 2",
      "chat": "You: Does it come with an additional box?",
      "time": "9:03 AM",
    },
    {
      "image": "assets/images/ellipse.png",
      "titleName": "DJI Mavic Mini 2",
      "chat": "You: Does it come with an additional box?",
      "time": "9:03 AM",
    },
    {
      "image": "assets/images/ellipse.png",
      "titleName": "DJI Mavic Mini 2",
      "chat": "You: Does it come with an additional box?",
      "time": "9:03 AM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getUserChatList(context);
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
                "Chats",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF000000)),
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(left: 10),
            //   child: Text(
            //     "Lorem Ipsum is simply dummy text of the",
            //     style: TextStyle(
            //         fontSize: 10,
            //         fontWeight: FontWeight.w400,
            //         color: Color(0xFF676767)),
            //   ),
            // ),
            const SizedBox(
              height: 20,
            ),
            ...commonProvider.getChatUserList.map(
              (e) => Container(
                height: 80,
                margin: commonProvider.isDrawerOpen
                    ? const EdgeInsets.symmetric(horizontal: 5, vertical: 2)
                    : const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                width: commonProvider.isDrawerOpen
                    ? MediaQuery.of(context).size.width - 75
                    : MediaQuery.of(context).size.width - 15,
                child: InkWell(
                  onTap: () {
                    Map requestData = {
                      "roomid": e["_id"],
                    };
                    commonProvider.getChatDataById(
                      context,
                      requestData,
                      e,
                      true,
                    );
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Image.asset("assets/images/ellipse.png",
                              width: 50),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                e["userid"]['userName'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF3C3C3C),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            e["gigId"]['title'],
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF828282),
                            ),
                          ),
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
