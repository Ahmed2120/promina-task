class User{
  final int? id;
  final String name;
  final String email;
  final String token;

  User(this.name, this.email, this.token, {this.id});

  User.fromJson(Map<String, dynamic> json)
      : id = json['user']['id'],
        name = json['user']['name'],
        email = json['user']['email'],
        token = json['token'];

  Map<String, dynamic> toJson(){
    return {
      'name' : name,
      'email' : email,
    };
  }
}