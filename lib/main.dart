import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_portal/presentation/auth_screen/signup_screen.dart';
import 'package:job_portal/utils/constents.dart';
import 'utils/responsive_size.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const JobPortalApp());
}

class JobPortalApp extends StatelessWidget {
  const JobPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: AppMainColor.primaryColor,
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
            backgroundColor: AppMainColor.primaryColor,
            foregroundColor: Colors.white,
            centerTitle: true,
          ),
        ),
        home: SignupScreen(),
      ),
    );
  }
}
