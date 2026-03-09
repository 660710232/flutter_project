class User {
  final String username;
  final String password;
  final String name;
  final String lastname;
  final String email;

  User(this.username, this.password, this.name, this.lastname, this.email);

  User.fromJson(Map<String, dynamic> json)
    : username = json['username'],
      password = json['password'],
      name = json['name'],
      lastname = json['lastname'],
      email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'name': name,
      'lastname': lastname,
      'email': email,
    };
  }
}
