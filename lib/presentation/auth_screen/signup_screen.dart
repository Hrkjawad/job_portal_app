import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_portal/presentation/auth_screen/widgets/custom_buttons.dart';
import 'package:job_portal/presentation/auth_screen/widgets/custom_textformfield.dart';

import '../../data/models/user_model.dart';
import '../../utils/responsive_size.dart';
import '../../view_model/auth_viewmodel.dart';
import 'login_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey1 = GlobalKey<FormState>();
  final _fullNameTEController = TextEditingController();
  final _emailTEController = TextEditingController();
  final _passwordTEController = TextEditingController();

  @override
  void dispose() {
    _fullNameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey1.currentState!.validate()) return;

    final user = UserModel(
      fullName: _fullNameTEController.text.trim(),
      email: _emailTEController.text.trim(),
      password: _passwordTEController.text.trim(),
    );

    final auth = ref.read(authProvider.notifier);
    final success = await auth.register(user);

    if (!mounted) return;
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registered successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
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
        key: _formKey1,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              spacing: Responsive.sizeH(20),
              children: [
                SizedBox(height: Responsive.sizeH(40)),
                Text("Fill your details"),
                CustomTextFormField(
                  controller: _fullNameTEController,
                  hintText: "Full Name",
                  textInputType: TextInputType.text,
                  isPasswordField: false,
                  textInputAction: TextInputAction.next,
                  requiredField: true,
                ),
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
                CustomElevatedButton(onPressed: _signup, text: "SignUp"),
                Row(
                  spacing: Responsive.sizeW(5),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    CustomTextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                        _fullNameTEController.clear();
                        _emailTEController.clear();
                        _passwordTEController.clear();
                      },
                      text: "Login",
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
