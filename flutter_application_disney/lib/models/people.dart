class People {
  People({
    required this.pagination,
    required this.data,
  });
  late final Pagination pagination;
  late final List<CharactersData> data;
  
  People.fromJson(Map<String, dynamic> json){
    pagination = Pagination.fromJson(json['pagination']);
    data = List.from(json['data']).map((e)=>CharactersData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pagination'] = pagination.toJson();
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Pagination {
  Pagination({
    required this.lastVisiblePage,
    required this.hasNextPage,
  });
  late final int lastVisiblePage;
  late final bool hasNextPage;
  
  Pagination.fromJson(Map<String, dynamic> json){
    lastVisiblePage = json['last_visible_page'];
    hasNextPage = json['has_next_page'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['last_visible_page'] = lastVisiblePage;
    _data['has_next_page'] = hasNextPage;
    return _data;
  }
}

class CharactersData {
  CharactersData({
    required this.malId,
    required this.url,
    required this.images,
    required this.name,
    required this.nicknames,
    required this.favorites,
    required this.about,
  });
  late final int malId;
  late final String url;
  late final Images images;
  late final String name;
  late final List<String> nicknames;
  late final int favorites;
  late final String about;
  
  CharactersData.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    url = json['url'];
    images = Images.fromJson(json['images']);
    name = json['name'];
    nicknames = List.castFrom<dynamic, String>(json['nicknames']);
    favorites = json['favorites'];
    about = json['about'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['url'] = url;
    _data['images'] = images.toJson();
    _data['name'] = name;
    _data['nicknames'] = nicknames;
    _data['favorites'] = favorites;
    _data['about'] = about;
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