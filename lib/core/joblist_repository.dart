import '../data/models/job_list_model.dart';
import 'api.dart';

class JobListRepository {
  final ApiService apiService;

  JobListRepository(this.apiService);

  Future<List<JobListModel>> getNews() async {
    final data = await apiService.fetchData();
    return data
        .map<JobListModel>((json) => JobListModel.fromJson(json))
        .toList();
  }
}
