import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_plo_vendor/controllers/provider_controller.dart';
import 'package:my_plo_vendor/views/introduction/video_item.dart';
import 'package:provider/provider.dart';
import '../../theme/media_query.dart';
import 'package:video_player/video_player.dart';

class IntroductionImage extends StatelessWidget {
  const IntroductionImage({super.key});

  @override
  Widget build(BuildContext context) {
    CommonProvider commonProvider = Provider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      commonProvider.getIntroductionData(context);
    });

    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    var size = Sizess();
    return Consumer<CommonProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Introduction",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(
                        0xFF000000,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  width: commonProvider.isDrawerOpen
                      ? MediaQuery.of(context).size.width - 80
                      : MediaQuery.of(context).size.width - 25,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        width: commonProvider.isDrawerOpen
                            ? MediaQuery.of(context).size.width - 80
                            : MediaQuery.of(context).size.width - 25,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const Text(
                                "Introduction Content or Video",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                commonProvider.introTitle,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              commonProvider.videoTitle == ""
                                  ? const SizedBox()
                                  : SizedBox(
                                      height: 150,
                                      child: VideoItems(
                                        videoPlayerController:
                                            VideoPlayerController.networkUrl(
                                          Uri.parse(
                                              "${commonProvider.baseUrlForImagesAndVideo}${commonProvider.videoTitle}"),
                                        ),

                                        // VideoPlayerController.network(commonProvider.videoUrl),
                                        looping: true,
                                        autoplay: false,
                                      ),
                                    ),
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ));
  }
}
