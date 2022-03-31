import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTube extends StatefulWidget {
  final String videoId;
  const YouTube({Key? key, required this.videoId}) : super(key: key);
  @override
  State<YouTube> createState() => _YouTubeState();
}

class _YouTubeState extends State<YouTube> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller!,
      showVideoProgressIndicator: true,
    );
  }
}
