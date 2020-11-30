import 'dart:convert';

class User {
  String name;
  String dateOfBirth;
  String userName;
  String pass; 
  User({
    this.name,
    this.dateOfBirth,
    this.userName,
    this.pass,
  });


  Map<String, dynamic> toMap() {
    return {
      'NOME': name,
      'DTA_NASCIMENTO': dateOfBirth,
      'USUARIO': userName,
      'SENHA': pass,
    };
  }

    Map<String, dynamic> userToMap() {
    return {
      'username': userName,
      'password': pass,
    };
  }


  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return User(
      name: map['name'],
      dateOfBirth: map['dateOfBirth'],
      userName: map['userName'],
      pass: map['pass'],
    );
  }

  String userToJson() => json.encode(userToMap());

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(name: $name, dateOfBirth: $dateOfBirth, userName: $userName, pass: $pass)';
  }

}
