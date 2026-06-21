import 'package:flutter/material.dart';
import 'model/user.dart'; // تأكدي من أن اسم الملف هو user_model.dart

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  // دالة لتسجيل المستخدم محلياً (يمكنك لاحقاً استدعاء السيرفر من هنا)
  void registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    // نقوم بإنشاء المستخدم
    // ملاحظة: الـ id يتم تركه فارغاً هنا، أو يمكنك تعيين قيمة افتراضية
    _user = UserModel(
      id: "1", // مستقبلاً ستأتي هذه القيمة من السيرفر بعد نجاح التسجيل
      name: name,
      email: email,
      phone: phone,
      password: password,
    );

    // إشعار الواجهات (UI) بأن المستخدم قد تم تسجيله
    notifyListeners();
  }

  // دالة إضافية لتسجيل الخروج (مفيدة جداً مستقبلاً)
  void logout() {
    _user = null;
    notifyListeners();
  }
}