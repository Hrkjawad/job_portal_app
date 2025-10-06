import 'package:flutter/material.dart';
import 'package:job_portal/utils/responsive_size.dart';
import '../view_model/auth_viewmodel.dart';
import '../view_model/saved_jobs_viewmodel.dart';

Drawer profileDrawer(BuildContext context, ref) {
  final user = ref.watch(authProvider);
  final savedJobs = ref.read(savedJobsProvider);
  return Drawer(
    child: Column(
      spacing: Responsive.sizeH(30),
      children: [
        SizedBox(height: Responsive.sizeH(40),),
        Icon(Icons.person, size: 100,),
        Text('Full Name: ${user?.fullName}'),
        Text('Email: ${user?.email}'),
        Text('Saved Jobs: ${savedJobs.length}'),
        Text("Developed By Hrk Jawad")
      ],
    ),
  );
}
