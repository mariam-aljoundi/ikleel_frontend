import 'package:eklil/AppColors.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  bool _isCodeVerified = false;
  // متغيرات للتحكم في إظهار/إخفاء كلمة المرور
  bool _isObscurePass = true;
  bool _isObscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        title: Text(_isCodeVerified ? "تعيين كلمة مرور جديدة" : "استعادة كلمة المرور"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primaryPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text(
                _isCodeVerified ? "أدخلي كلمة المرور الجديدة" : "أدخلي رمز التحقق المكون من 4 أرقام",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryPurple),
              ),
              const SizedBox(height: 40),

              _isCodeVerified ? _buildNewPasswordFields() : _buildOtpFields(),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Text(_isCodeVerified ? "حفظ" : "تحقق", style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleButtonPress() {
    setState(() {
      if (!_isCodeVerified) {
        _isCodeVerified = true;
      } else {
        String pass = _passController.text;
        if (pass.length < 8) {
          _showError("كلمة المرور يجب أن تكون 8 محارف على الأقل");
        } else if (pass != _confirmPassController.text) {
          _showError("كلمتا المرور غير متطابقتين");
        } else if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(pass)) {
          _showError("يجب أن تحتوي كلمة المرور على أحرف وأرقام");
        } else {
          _showSuccess("تم تغيير كلمة المرور بنجاح");
        }
      }
    });
  }

  Widget _buildOtpFields() {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      controller: _otpController,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(15),
        fieldHeight: 65,
        fieldWidth: 65,
        activeFillColor: Colors.white,
        selectedFillColor: Colors.white,
        inactiveFillColor: AppColors.lighterPurple.withOpacity(0.2),
        activeColor: AppColors.primaryPurple,
        selectedColor: AppColors.primaryPurple,
        inactiveColor: AppColors.lighterPurple,
        borderWidth: 2,
      ),
      enableActiveFill: true,
      onChanged: (value) => setState(() {}),
    );
  }

  Widget _buildNewPasswordFields() {
    return Column(
      children: [
        _buildTextField("كلمة المرور الجديدة", Icons.lock_outline, _isObscurePass, () {
          setState(() => _isObscurePass = !_isObscurePass);
        }, _passController),
        const SizedBox(height: 20),
        _buildTextField("تأكيد كلمة المرور", Icons.lock_outline, _isObscureConfirm, () {
          setState(() => _isObscureConfirm = !_isObscureConfirm);
        }, _confirmPassController),
      ],
    );
  }

  Widget _buildTextField(String hint, IconData icon, bool isObscure, VoidCallback onToggle, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppColors.primaryPurple),
        // إضافة أيقونة العين
        suffixIcon: IconButton(
          icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility, color: AppColors.primaryPurple),
          onPressed: onToggle,
        ),
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

  void _showError(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
  void _showSuccess(String message) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.green));
}