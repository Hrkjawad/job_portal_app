import '../core/database_helper.dart';
import 'models/save_job_model.dart';
import 'models/user_model.dart';

class LocalDatabase {
  static Future<int> signUp(UserModel user) async {
    final db = await DatabaseHelper.database;
    return await db.insert('users', user.toMap());
  }

  static Future<UserModel?> login(String email, String password) async {
    final db = await DatabaseHelper.database;
    final data = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return data.isNotEmpty ? UserModel.fromMap(data.first) : null;
  }

  static Future<List<UserModel>> getUserData() async {
    final db = await DatabaseHelper.database;
    final data = await db.query('users');
    return data
        .map(
          (e) => UserModel(
            fullName: e['fullName'] as String,
            email: e['email'] as String,
            password: "",
          ),
        )
        .toList();
  }

  static Future<void> saveJob(SavedJobsModel job) async {
    final db = await DatabaseHelper.database;
    await db.insert('applied_jobs', {
      'id': job.id,
      'email': job.email,
      'title': job.title,
      'brand': job.brand,
      'price': job.price,
    });
  }

  static Future<List<SavedJobsModel>> getSavedJobs() async {
    final db = await DatabaseHelper.database;
    final data = await db.query('applied_jobs');
    return data
        .map(
          (e) => SavedJobsModel(
            id: e['id'] as int,
            email: e['email'] as String,
            title: e['title'] as String,
            brand: e['brand'] as String,
            price: e['price'] as String,
          ),
        )
        .toList();
  }
}
