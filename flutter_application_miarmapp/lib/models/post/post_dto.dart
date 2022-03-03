class PostDto {
  String? titulo;
  String? texto;
  bool? estadoPublicacion;

  PostDto(
      {this.titulo,
      this.texto,
      this.estadoPublicacion,
      });

  PostDto.fromJson(Map<String, dynamic> json) {
    titulo = json['titulo'];
    texto = json['texto'];
    estadoPublicacion = json['estadoPublicacion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['titulo'] = titulo;
    data['texto'] = texto;
    data['estadoPublicacion'] = estadoPublicacion;
    return data;
  }
}