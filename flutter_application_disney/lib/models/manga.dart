class MangasModel {
  MangasModel({
    required this.data,
  });
  late final List<MangasData> data;
  
  MangasModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>MangasData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class MangasData {
  MangasData({
    required this.malId,
    required this.url,
    required this.images,
    required this.title,
    required this.titleJapanese,
  
    
  });
  late final int malId;
  late final String url;
  late final Images images;
  late final String title;
  late final String titleJapanese;
 
  
  MangasData.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    url = json['url'];
    images = Images.fromJson(json['images']);
    title = json['title'];
   
    titleJapanese = json['title_japanese'];
    
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['url'] = url;
    _data['images'] = images.toJson();
    _data['title'] = title;
    
    _data['title_japanese'] = titleJapanese;
    
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
    required this.smallImageUrl,
    required this.largeImageUrl,
  });
  late final String imageUrl;
  late final String smallImageUrl;
  late final String largeImageUrl;
  
  Jpg.fromJson(Map<String, dynamic> json){
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['small_image_url'] = smallImageUrl;
    _data['large_image_url'] = largeImageUrl;
    return _data;
  }
}

class Webp {
  Webp({
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });
  late final String imageUrl;
  late final String smallImageUrl;
  late final String largeImageUrl;
  
  Webp.fromJson(Map<String, dynamic> json){
    imageUrl = json['image_url'];
    smallImageUrl = json['small_image_url'];
    largeImageUrl = json['large_image_url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['image_url'] = imageUrl;
    _data['small_image_url'] = smallImageUrl;
    _data['large_image_url'] = largeImageUrl;
    return _data;
  }
}

class Published {
  Published({
    required this.from,
     this.to,
    required this.prop,
    required this.string,
  });
  late final String from;
  late final String? to;
  late final Prop prop;
  late final String string;
  
  Published.fromJson(Map<String, dynamic> json){
    from = json['from'];
    to = null;
    prop = Prop.fromJson(json['prop']);
    string = json['string'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from'] = from;
    _data['to'] = to;
    _data['prop'] = prop.toJson();
    _data['string'] = string;
    return _data;
  }
}

class Prop {
  Prop({
    required this.from,
    required this.to,
  });
  late final From from;
  late final To to;
  
  Prop.fromJson(Map<String, dynamic> json){
    from = From.fromJson(json['from']);
    to = To.fromJson(json['to']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['from'] = from.toJson();
    _data['to'] = to.toJson();
    return _data;
  }
}

class From {
  From({
    required this.day,
    required this.month,
    required this.year,
  });
  late final int day;
  late final int month;
  late final int year;
  
  From.fromJson(Map<String, dynamic> json){
    day = json['day'];
    month = json['month'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}

class To {
  To({
     this.day,
     this.month,
     this.year,
  });
  late final int? day;
  late final int? month;
  late final int? year;
  
  To.fromJson(Map<String, dynamic> json){
    day = null;
    month = null;
    year = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['month'] = month;
    _data['year'] = year;
    return _data;
  }
}

class Authors {
  Authors({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });
  late final int malId;
  late final String type;
  late final String name;
  late final String url;
  
  Authors.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['type'] = type;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class Serializations {
  Serializations({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });
  late final int malId;
  late final String type;
  late final String name;
  late final String url;
  
  Serializations.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['type'] = type;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}



 

class Themes {
  Themes({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });
  late final int malId;
  late final String type;
  late final String name;
  late final String url;
  
  Themes.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['type'] = type;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}

class Demographics {
  Demographics({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });
  late final int malId;
  late final String type;
  late final String name;
  late final String url;
  
  Demographics.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    type = json['type'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['type'] = type;
    _data['name'] = name;
    _data['url'] = url;
    return _data;
  }
}