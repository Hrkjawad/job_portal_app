import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_portal/presentation/auth_screen/signup_screen.dart';
import 'package:job_portal/presentation/auth_screen/widgets/custom_buttons.dart';
import 'package:job_portal/presentation/auth_screen/widgets/custom_textformfield.dart';
import 'package:job_portal/presentation/homepage.dart';
import '../../utils/responsive_size.dart';
import '../../view_model/auth_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey2 = GlobalKey<FormState>();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey2.currentState!.validate()) return;

    final auth = ref.read(authProvider.notifier);
    final success = await auth.login(
      _emailTEController.text.trim(),
      _passwordTEController.text.trim(),
    );

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('login successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Homepage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed, Try again'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mini Job Portal")),
      body: Form(
        key: _formKey2,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: Responsive.sizeH(20),
              children: [
                SizedBox(height: Responsive.sizeH(40)),
                Text("Login into your account"),
                CustomTextFormField(
                  controller: _emailTEController,
                  hintText: "Email",
                  textInputType: TextInputType.emailAddress,
                  isPasswordField: false,
                  textInputAction: TextInputAction.next,
                  requiredField: true,
                ),
                CustomTextFormField(
                  controller: _passwordTEController,
                  hintText: "Password",
                  textInputType: TextInputType.text,
                  isPasswordField: true,
                  textInputAction: TextInputAction.done,
                  requiredField: true,
                ),
                CustomElevatedButton(onPressed: _login, text: "Login"),
                Row(
                  spacing: Responsive.sizeW(5),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No account?"),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                        _emailTEController.clear();
                        _passwordTEController.clear();
                      },
                      text: "Signup",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
