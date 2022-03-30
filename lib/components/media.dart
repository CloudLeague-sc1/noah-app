import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

import '../models/domain/media.dart' as dom_media;

Widget renderMedia(dom_media.Media model) {
  if (model is dom_media.Image) {
    return Image.asset('contents/media/' + model.src);
  } else if (model is dom_media.Audio) {
    return Audio(src: model.src);
  } else if (model is dom_media.YouTube) {
    return Text('[Not yet implemented] YouTube Media');
  }

  throw Exception("Unknown media type " + model.type.toString());
}

class Audio extends StatefulWidget {
  final String src;
  const Audio({Key? key, required this.src}) : super(key: key);

  @override
  createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  final player = AudioPlayer();
  AudioCache? cache;

  bool isStarted = false;
  bool isPlaying = false;
  Duration duration = const Duration(milliseconds: 0);
  Duration position = const Duration(milliseconds: 0);

  void updateDuration(Duration pos) {
    setState(() => duration = pos);
  }

  void updatePosition(Duration pos) {
    setState(() => position = pos);
  }

  void updatePlayerState(Duration) {}

  @override
  Widget build(BuildContext context) {
    cache = AudioCache(prefix: 'contents/media/', fixedPlayer: player);
    cache!.load(widget.src);

    player.onAudioPositionChanged.listen(updatePosition);
    player.onDurationChanged.listen(updateDuration);
    player.onPlayerStateChanged.listen(updatePlayerState);

    return Column(
      children: [
        // Seekbar
        ProgressBar(
          progress: position,
          total: duration,
          onSeek: (duration) {
            player.seek(duration);
          },
        ),
// Buttons
        Row(
          children: [
            TextButton(
                onPressed: playAndPause,
                child: isPlaying ? const Text('||') : const Text('>'))
          ],
        )
      ],
    );
  }

  void playAndPause() {
    if (isPlaying) {
      player.pause();
    } else {
      if (isStarted) {
        player.resume();
      } else {
        cache!.play(widget.src);
        isStarted = true;
      }
    }

    setState(() => {isPlaying = !isPlaying});
  }
}
