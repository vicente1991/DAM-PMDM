class PostResponse {
  PostResponse({
    required this.id,
    required this.titulo,
    required this.texto,
    required this.file,
    required this.fechaPublicacion,
    required this.visibilidad,
    required this.nick,
  });
  late final int id;
  late final String titulo;
  late final String texto;
  late final String file;
  late final String fechaPublicacion;
  late final String visibilidad;
  late final String nick;
  
  PostResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    titulo = json['titulo'];
    texto = json['texto'];
    file = json['file'];
    fechaPublicacion = json['fechaPublicacion'];
    visibilidad = json['visibilidad'];
    nick = json['nick'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['titulo'] = titulo;
    _data['texto'] = texto;
    _data['file'] = file;
    _data['fechaPublicacion'] = fechaPublicacion;
    _data['visibilidad'] = visibilidad;
    _data['nick'] = nick;
    return _data;
  }
}