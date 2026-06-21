import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:eklil/AppColors.dart';

import '../provider.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: const Text("إنشاء حساب"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryPurple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // الشعار مباشرة بدون كارد
                const SizedBox(height: 20),
                SizedBox(
                  height: 120,
                  child: Image.asset('images/slogan.png', fit: BoxFit.contain),
                ),
                const SizedBox(height: 30),

                // حقل الاسم: أحرف فقط
                _buildFormField("الاسم الكامل", Icons.person_outline, _nameController,
                    formatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\u0600-\u06FF\s]'))],
                    validator: (val) => val!.isEmpty ? 'يرجى إدخال الاسم' : null),

                const SizedBox(height: 15),

                // حقل البريد
                _buildFormField("البريد الإلكتروني", Icons.email_outlined, _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val!) ? 'أدخلي بريداً صحيحاً' : null),

                const SizedBox(height: 15),

                // حقل الهاتف: أرقام فقط
                _buildFormField("رقم الهاتف", Icons.phone_android, _phoneController,
                    keyboardType: TextInputType.phone,
                    formatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (val) => val!.isEmpty ? 'يرجى إدخال رقم الهاتف' : null),

                const SizedBox(height: 15),

                // حقل كلمة السر: مع العين
                _buildFormField("كلمة المرور", Icons.lock_outline, _passController,
                    isPassword: !_isPasswordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: AppColors.primaryPurple),
                      onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                    ),
                    validator: (val) => !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(val!)
                        ? '8 محارف (أحرف وأرقام معاً)' : null),

                const SizedBox(height: 30),

                // زر الإنشاء
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<AuthProvider>(context, listen: false).registerUser(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          password: _passController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تم إنشاء الحساب بنجاح!")));
                      }
                    },
                    child: const Text("إنشاء الحساب", style: TextStyle(fontSize: 18)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField(String hint, IconData icon, TextEditingController controller, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    List<TextInputFormatter>? formatters,
    Widget? suffixIcon
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      validator: validator,
      inputFormatters: formatters,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryPurple),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.lighterPurple)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.red)),
      ),
    );
  }
}