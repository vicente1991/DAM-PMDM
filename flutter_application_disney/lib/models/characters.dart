class CharactersModel {
  CharactersModel({
    required this.data,
  });
  late final List<CharactersData> data;
  
  CharactersModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>CharactersData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CharactersData {
  CharactersData({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
    required this.favorites,
  
  });
  late final int malId;
  late final String url;
  late final Images images;
  late final String name;
  late final int favorites;
 
  
  CharactersData.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    url = json['url'];
    images = Images.fromJson(json['images']);
    name = json['name'];
    favorites = json['favorites'];
   
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['url'] = url;
    _data['images'] = images.toJson();
    _data['name'] = name;
    _data['favorites'] = favorites;
 
    return _data;
  }
}

class Images {
  Images({
    required this.jpg,
    required this.webp,
  });
  late final Jpg jpg;
  late final Webp webp;
  
  Images.fromJson(Map<String, dynamic> json){
    jpg = Jpg.fromJson(json['jpg']);
    webp = Webp.fromJson(json['webp']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['jpg'] = jpg.toJson();
    _data['webp'] = webp.toJson();
    return _data;
  }
}

class Jpg {
  Jpg({
    required this.imageUrl,
  });
  late final String imageUrl;
  
  Jpg.fromJson(Map<String, dynamic> json){
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    return _data;
  }
}

class Webp {
  Webp({
    required this.imageUrl,
    required this.smallImageUrl,
  });
  late final String imageUrl;
  late final String smallImageUrl;
  
  Webp.fromJson(Map<String, dynamic> json){
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['small_image_url'] = smallImageUrl;
    return _data;
  }
}