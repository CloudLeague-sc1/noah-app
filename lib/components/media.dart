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

  PlayerState playerState = PlayerState.STOPPED;
  Duration duration = const Duration(milliseconds: 0);
  Duration position = const Duration(milliseconds: 0);

  void updateDuration(Duration pos) {
    setState(() => duration = pos);
  }

  void updatePosition(Duration pos) {
    setState(() => position = pos);
  }

  void updatePlayerState(s) {
    setState(() => playerState = s);
  }

  @override
  void initState() {
    cache = AudioCache(prefix: 'contents/media/', fixedPlayer: player);
    cache!.load(widget.src);

    player.onAudioPositionChanged.listen(updatePosition);
    player.onDurationChanged.listen(updateDuration);
    player.onPlayerStateChanged.listen(updatePlayerState);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        IconButton(onPressed: playOrPause, icon: Icon(getButtonIcon())),
      ],
    );
  }

  void playOrPause() {
    switch (playerState) {
      case PlayerState.STOPPED:
        cache!.play(widget.src);
        break;
      case PlayerState.PLAYING:
        player.pause();
        break;
      case PlayerState.PAUSED:
        player.resume();
        break;
      case PlayerState.COMPLETED:
        cache!.play(widget.src);
        break;
    }
  }

  IconData getButtonIcon() {
    switch (playerState) {
      case PlayerState.STOPPED:
        return Icons.play_arrow;
      case PlayerState.PLAYING:
        return Icons.pause;
      case PlayerState.PAUSED:
        return Icons.play_arrow;
      case PlayerState.COMPLETED:
        return Icons.replay;
    }
  }
}
