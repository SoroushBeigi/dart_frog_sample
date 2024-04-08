import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tasklist_backend/hash_extension.dart';

@visibleForTesting
Map<String, User> userDatabase = {};

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.userName,
    required this.password,
  });
  final String id;
  final String name;
  final String userName;
  final String password;

  @override
  List<Object?> get props => [id, name, userName, password];
}

class UserRepository {
  User? userFromCredentials(String username, String password) {
    final hashedPassword = password.hashValue;
    final users = userDatabase.values.where((element) =>
        element.userName == username && element.password == hashedPassword);
    if (users.isNotEmpty) {
      return users.first;
    } else {
      return null;
    }
  }

  User? userFromId(String id) => userDatabase[id];

  String createUser({
    required String name,
    required String userName,
    required String password,
  }) {
    final id = userName.hashValue;
    final user = User(
      id: id,
      name: name,
      userName: userName,
      password: password.hashValue,
    );
    userDatabase[id] = user;
    return id;
  }

  void deleteUser(String id) => userDatabase.remove(id);

  Future<void> updateUser({
    required String id,
    required String? name,
    required String? userName,
    required String? password,
  }) async {
    final currentUser = userDatabase[id];
    if (currentUser == null) {
      return Future.error(Exception('User not found!'));
    }
    final user = User(
      id: id,
      name: name ?? currentUser.name,
      userName: userName ?? currentUser.userName,
      password: password ?? currentUser.password,
    );
    userDatabase[id] = user;
  }
}
