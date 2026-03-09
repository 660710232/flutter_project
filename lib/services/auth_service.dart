import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_project/model/users.dart';

class AuthService {
  Future<bool> login(String username, String password) async {
    User? user = await getUser(username);
    print(user?.name);
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
}
