import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_portal/data/models/job_list_model.dart';
import '../../data/models/save_job_model.dart';
import '../../utils/responsive_size.dart';
import '../../view_model/auth_viewmodel.dart';
import '../../view_model/saved_jobs_viewmodel.dart';

class JobDetailScreen extends ConsumerWidget {
  final JobListModel currentJob;
  final int index;
  const JobDetailScreen({
    super.key,
    required this.currentJob,
    required this.index,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: const BackButton(color: Colors.white),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: Responsive.sizeW(20)),
                child: Icon(Icons.bookmark_border_rounded, color: Colors.white),
              ),
            ],
            expandedHeight: Responsive.sizeH(250),
            pinned: true,
            backgroundColor: Colors.grey,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(currentJob.thumbnail!, fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(Responsive.sizeW(16)),
                      color: Colors.black54,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: Responsive.sizeH(5),
                        children: [
                          Text(
                            "Job Title: ${currentJob.title}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Open : ${currentJob.availabilityStatus}",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(Responsive.sizeW(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Company: ${currentJob.category}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text("Salary: ${currentJob.price} \$"),
                  SizedBox(height: Responsive.sizeH(20)),
                  Text("Job Description: \n\n${currentJob.description}"),
                  SizedBox(height: Responsive.sizeH(12)),
                  Text("Vacancy: ${currentJob.stock}"),
                  SizedBox(height: Responsive.sizeH(20)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final user = ref.watch(authProvider);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Applied successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        ref.read(savedJobsProvider.notifier).saveJob(
                              SavedJobsModel(
                                id: index,
                                email: user!.email,
                                title: currentJob.title.toString(),
                                brand: currentJob.brand.toString(),
                                price: currentJob.price.toString(),
                              ),
                            );
                      },
                      child: Text("Apply"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
