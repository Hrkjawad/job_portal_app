import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:job_portal/presentation/job_list_screen/job_list_screen.dart';
import 'package:job_portal/presentation/job_list_screen/save_job_screen.dart';
import 'package:job_portal/presentation/profile_drawer.dart';
import '../utils/constents.dart';
import '../view_model/auth_viewmodel.dart';
import 'auth_screen/signup_screen.dart';

final _selectBottomIndex = StateProvider<int>((ref) => 0);

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final logout = ref.watch(authProvider.notifier);
    final bottomIndex = ref.watch(_selectBottomIndex);

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Job List"),
        leading: IconButton(
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
          icon: Icon(Icons.person),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logout.logout();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('logout successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => SignupScreen()),
              );
              ref.read(_selectBottomIndex.notifier).state = 0;
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      drawer: profileDrawer(context, ref),
      body: SafeArea(
        child: IndexedStack(
          index: bottomIndex,
          children: [JobListScreen(), SaveJobScreen()],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: bottomIndex,
        indicatorColor: AppMainColor.primaryColor,
        onDestinationSelected: (int index) => ref.read(_selectBottomIndex.notifier).state = index,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: bottomIndex == 0 ? Colors.white : Colors.grey,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.save,
              color: bottomIndex == 1 ? Colors.white : Colors.grey,
            ),
            label: "Saved Jobs",
          ),
        ],
      ),
    );
  }
}
