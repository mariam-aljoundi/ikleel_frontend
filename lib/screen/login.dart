import 'package:eklil/AppColors.dart';
import 'package:eklil/screen/signup.dart';
 // تأكدي من مسار هذا الملف
import 'package:flutter/material.dart';

import 'forgotpassword.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(() => setState(() {}));
    _passFocus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.08),

                  // الشعار
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    width: double.infinity,
                    child: Image.asset('images/slogan.png', fit: BoxFit.contain),
                  ),

                  SizedBox(height: constraints.maxHeight * 0.03),
                  const Text(
                    "أهلاً بكِ في إكليل",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryPurple),
                  ),

                  SizedBox(height: constraints.maxHeight * 0.04),

                  // حقل البريد الإلكتروني
                  _buildTextField("البريد الإلكتروني", Icons.email_outlined, _emailFocus,
                      keyboardType: TextInputType.emailAddress),

                  SizedBox(height: screenHeight * 0.02),

                  // حقل كلمة المرور
                  _buildTextField("كلمة المرور", Icons.lock_outline, _passFocus,
                      isPassword: true),

                  // رابط نسيت كلمة المرور
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()),
                        );
                      },
                      child: const Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                  SizedBox(height: constraints.maxHeight * 0.02),

                  // زر الدخول
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        // منطق تسجيل الدخول هنا
                      },
                      child: const Text("تسجيل الدخول", style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // رابط إنشاء حساب
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("ليس لديكِ حساب؟ "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupPage()));
                        },
                        child: const Text(
                          "إنشاء حساب",
                          style: TextStyle(color: AppColors.primaryPurple, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, FocusNode node,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      focusNode: node,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: node.hasFocus ? AppColors.primaryPurple : AppColors.lighterPurple),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.lighterPurple, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2.0),
        ),
      ),
    );
  }
}