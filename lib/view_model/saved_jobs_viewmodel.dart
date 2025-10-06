import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:sqflite/sqflite.dart';
import '../core/database_helper.dart';
import '../data/models/save_job_model.dart';

final savedJobsProvider = StateNotifierProvider<SavedJobsViewModel, List<SavedJobsModel>>(
      (ref) => SavedJobsViewModel(),
    );

class SavedJobsViewModel extends StateNotifier<List<SavedJobsModel>> {
  SavedJobsViewModel() : super([]);

  Future<void> fetchSavedJobs(String email) async {
    try {
      final Database db = await DatabaseHelper.database;
      final data = await db.query(
        'applied_jobs',
        where: 'email = ?',
        whereArgs: [email],
      );
      state = data.map((e) => SavedJobsModel.fromMap(e)).toList();
      if (kDebugMode) print("Fetched ${state.length} saved jobs for $email");
    } catch (e) {
      if (kDebugMode) print("Fetch error: $e");
    }
  }

  Future<void> saveJob(SavedJobsModel job) async {
    try {
      final Database db = await DatabaseHelper.database;
      await db.insert(
        'applied_jobs',
        job.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await fetchSavedJobs(job.email);
    } catch (e) {
      if (kDebugMode) print("Save error: $e");
    }
  }

  Future<void> deleteJob(int id, String email) async {
    try {
      final Database db = await DatabaseHelper.database;
      await db.delete('applied_jobs', where: 'id = ?', whereArgs: [id]);
      await fetchSavedJobs(email);
    } catch (e) {
      if (kDebugMode) print("Delete error: $e");
    }
  }
}
