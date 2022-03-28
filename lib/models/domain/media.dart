enum MediaType { image, audio, youTube }

class Media {
  MediaType type = MediaType.image;
  Media(this.type);
}

class YouTube extends Media {
  String videoId = '';
  YouTube(this.videoId) : super(MediaType.youTube);
}

class Image extends Media {
  String src = "";
  Image(this.src) : super(MediaType.image);
}

class Audio extends Media {
  String src = "";
  Audio(this.src) : super(MediaType.audio);
}

Media parseMedia(Map<String, dynamic> json) {
  if (json['type'] is! String) {
    throw Exception("Media type is not string");
  }

  final type = json['type'];
  switch (type) {
    case 'image':
      return Image(json['src']);
    case 'audio':
      return Audio(json['src']);
    case 'youtube':
      return YouTube(json['videoid']);
    default:
      throw Exception("Unknown media type `$type`");
  }
}
