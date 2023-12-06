import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoItems extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final bool autoplay;

  const VideoItems({
    super.key,
    required this.videoPlayerController,
    required this.looping,
    required this.autoplay,
  });

  @override
  // ignore: library_private_types_in_public_api
  _VideoItemsState createState() => _VideoItemsState();
}

class _VideoItemsState extends State<VideoItems> {
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // allowFullScreen: true,
      // allowMuting: true,
      // fullScreenByDefault: true,
      autoInitialize: true,
      autoPlay: widget.autoplay,
      looping: widget.looping,
      materialProgressColors: ChewieProgressColors(
          backgroundColor: Colors.green,
          bufferedColor: Colors.yellow,
          playedColor: Colors.teal,
          handleColor: Colors.purple),
      placeholder: Container(color: Colors.red),

      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: _chewieController!,
    );
  }
}
