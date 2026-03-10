import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/users.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    User? user = await getUser(username);
    // print(user?.name);
    if (user != null && user.password == password) {
      return true;
    }

    return false;
  }

  Future<User?> getUser(String username) async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (result.docs.isNotEmpty) {
      var data = result.docs.first.data();
      return User.fromJson(data);
    }

    return null;
  }

  Future<void> setUser(
    String username,
    String password,
    String name,
    String lastname,
    String email,
  ) async {
    User user = User(username, password, name, lastname, email);
    await FirebaseFirestore.instance.collection('users').add(user.toJson());
    print('register success');
  }

  Future<bool> checkUserAvailable(String username) async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (result.docs.isNotEmpty) {
      return false;
    }

    return true;
  }
}
