import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../core/api.dart';
import '../core/joblist_repository.dart';
import '../core/sate_handle.dart';
import '../data/models/job_list_model.dart';
import '../utils/constents.dart';

final apiKeyProvider = Provider<String>((ref) {
  return BaseUrl.baseUrl;
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref.watch(apiKeyProvider));
});

final jobListRepositoryProvider = Provider<JobListRepository>((ref) {
  return JobListRepository(ref.watch(apiServiceProvider));
});

final jobListNotifierProvider = StateNotifierProvider<JobListNotifier, StateHandle<List<JobListModel>>>((ref,){
      return JobListNotifier(ref.watch(jobListRepositoryProvider));
    });

class JobListNotifier extends StateNotifier<StateHandle<List<JobListModel>>> {
  final JobListRepository repository;
  JobListNotifier(this.repository) : super(StateHandle.loading()) {
    if (state.data == null || state.data!.isEmpty) {
      fetchNews();
    }
  }
  Future<void> fetchNews() async {
    state = StateHandle.loading();
    try {
      if (kDebugMode) {
        print("Fetching job list from API");
      }
      final jobsList = await repository.getNews();
      if (jobsList.isEmpty) {
        state = StateHandle.error("No job available");
      } else {
        state = StateHandle.success(jobsList.cast<JobListModel>());
      }
    } catch (e) {
      state = StateHandle.error(e.toString());
    }
  }
}
