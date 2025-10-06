import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sqflite/sqflite.dart';
import '../core/database_helper.dart';
import '../data/models/user_model.dart';

final authProvider = StateNotifierProvider<AuthViewModel, UserModel?>(
  (ref) => AuthViewModel(),
);

class AuthViewModel extends StateNotifier<UserModel?> {
  AuthViewModel() : super(null);

  Future<bool> register(UserModel user) async {
    try {
      final Database db = await DatabaseHelper.database;

      // I check this for duplicate email
      final List<Map<String, Object?>> alreadyUserExist = await db.query(
        'users',
        where: 'email = ?',
        whereArgs: [user.email],
      );
      if (alreadyUserExist.isNotEmpty) {
        return false;
      }

      await db.insert(
        'users',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      state = user;

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final Database db = await DatabaseHelper.database;

      final foundUser = await db.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (foundUser.isNotEmpty) {
        final user = UserModel.fromMap(foundUser.first);
        state = user;
        return true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  void logout() {
    state = null;
  }
}
