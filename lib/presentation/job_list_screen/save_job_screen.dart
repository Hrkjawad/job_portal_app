import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_portal/view_model/saved_jobs_viewmodel.dart';
import '../../utils/constents.dart';
import '../../utils/responsive_size.dart';
import '../../view_model/auth_viewmodel.dart';

class SaveJobScreen extends ConsumerStatefulWidget {
  const SaveJobScreen({super.key});

  @override
  ConsumerState<SaveJobScreen> createState() => _SaveJobScreenState();
}

class _SaveJobScreenState extends ConsumerState<SaveJobScreen> {
  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider);
    if (user != null) {
      Future(() {
        ref.read(savedJobsProvider.notifier).fetchSavedJobs(user.email);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final savedJobs = ref.watch(savedJobsProvider);
    final user = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: const Color(0xfff5f6f8),
      body: savedJobs.isEmpty
          ? const Center(child: Text("No saved jobs found"))
          : RefreshIndicator(
              onRefresh: () => ref
                  .read(savedJobsProvider.notifier)
                  .fetchSavedJobs(user!.email),
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: savedJobs.length,
                separatorBuilder: (_, _) =>
                    SizedBox(height: Responsive.sizeH(20)),
                itemBuilder: (_, index) {
                  final job = savedJobs[index];
                  return ListTile(
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: AppMainColor.primaryColor,
                      foregroundColor: Colors.white,
                      child: Text('${index + 1}'),
                    ),
                    title: Text("Job Tile: ${job.title}"),
                    subtitle: Text(
                      'Company: ${job.brand}\nSalary: ${job.price}\$',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () => ref.read(savedJobsProvider.notifier).deleteJob(job.id ?? 0, user!.email),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
