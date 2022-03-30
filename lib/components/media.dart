import 'package:flutter/material.dart';
import '../models/domain/media.dart' as dom_media;


Widget renderMedia(dom_media.Media model){

  if (model is dom_media.Image) {
    return Image.asset('contents/media/'+ model.src);
  }else if (model is dom_media.Audio) {
    return Text('[Not yet implemented] Audio Media');
  }else if(model is dom_media.YouTube){
    return Text('[Not yet implemented] YouTube Media');
  }

  throw Exception("Unknown media type "+ model.type.toString());
}
