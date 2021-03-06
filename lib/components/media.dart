import 'package:flutter/material.dart';
import 'audio.dart';
import 'youtube.dart';
import '../models/domain/media.dart' as dom_media;

Widget renderMedia(dom_media.Media model) {
  if (model is dom_media.Image) {
    return Image.asset('contents/media/' + model.src);
  } else if (model is dom_media.Audio) {
    return Audio(src: model.src);
  } else if (model is dom_media.YouTube) {
    return YouTube(
      videoId: model.videoId,
    );
  }

  throw Exception("Unknown media type " + model.type.toString());
}
