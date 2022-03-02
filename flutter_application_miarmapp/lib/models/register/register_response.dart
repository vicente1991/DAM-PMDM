class RegisterResponse {
  RegisterResponse({
    required this.id,
    required this.nombre,
    required this.apellidos,
    required this.nick,
    required this.fechaNacimiento,
    required this.email,
    required this.avatar,
    required this.visibilidadUsuario,
  });
  late final String id;
  late final String nombre;
  late final String apellidos;
  late final String nick;
  late final String fechaNacimiento;
  late final String email;
  late final String avatar;
  late final String visibilidadUsuario;
  
  RegisterResponse.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nombre = json['nombre'];
    apellidos = json['apellidos'];
    nick = json['nick'];
    fechaNacimiento = json['fechaNacimiento'];
    email = json['email'];
    avatar = json['avatar'];
    visibilidadUsuario = json['visibilidadUsuario'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nombre'] = nombre;
    _data['apellidos'] = apellidos;
    _data['nick'] = nick;
    _data['fechaNacimiento'] = fechaNacimiento;
    _data['email'] = email;
    _data['avatar'] = avatar;
    _data['visibilidadUsuario'] = visibilidadUsuario;
    return _data;
  }
}