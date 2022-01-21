class GenresModel {
  GenresModel({
    required this.data,
  });
  late final List<GenresData> data;
  
  GenresModel.fromJson(Map<String, dynamic> json){
    data = List.from(json['data']).map((e)=>GenresData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class GenresData {
  GenresData({
    required this.malId,
    required this.name,
    required this.url,
    required this.count,
  });
  late final int malId;
  late final String name;
  late final String url;
  late final int count;
  
  GenresData.fromJson(Map<String, dynamic> json){
    malId = json['mal_id'];
    name = json['name'];
    url = json['url'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mal_id'] = malId;
    _data['name'] = name;
    _data['url'] = url;
    _data['count'] = count;
    return _data;
  }
}