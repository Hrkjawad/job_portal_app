import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_portal/presentation/job_list_screen/job_detail_screen.dart';
import '../../core/sate_handle.dart';
import '../../utils/responsive_size.dart';
import '../../view_model/job_list_viewmodel.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobData = ref.watch(jobListNotifierProvider);

    return Scaffold(
      backgroundColor: Color(0xfff5f6f8),
      body: RefreshIndicator(
        onRefresh: () => ref.read(jobListNotifierProvider.notifier).fetchNews(),
        child: jobData.status == Status.loading
            ? const Center(child: CircularProgressIndicator())
            : jobData.status == Status.error
            ? Center(child: Text(jobData.message ?? "Error"))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: jobData.data!.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: Responsive.sizeH(20)),
                itemBuilder: (_, index) {
                  final jobList = jobData.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailScreen(
                            currentJob: jobList,
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: Responsive.sizeH(220),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(Responsive.sizeW(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: Responsive.sizeH(8),
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                jobList.thumbnail!,
                                width: double.infinity,
                                height: Responsive.sizeH(50),
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              "Job Title: ${jobList.title}",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text("Company: ${jobList.brand}"),
                            Text("Salary: ${jobList.price} \$"),
                            Text("Location: ${jobList.tags}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
