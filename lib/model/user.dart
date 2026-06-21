import 'package:json_annotation/json_annotation.dart';

// هذا السطر يخبر فلتر أن هناك ملفاً سيتم توليده يحتوي على المنطق البرمجي للـ JSON
part 'user.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;

  // كلمة السر لا تذهب للسيرفر (إلا عند التسجيل) ولا تعود منه لأسباب أمنية
  // لذا قمنا باستثنائها من القراءة من السيرفر (fromJson)
  @JsonKey(includeFromJson: false, includeToJson: true)
  final String? password;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.password,
  });

  // هذه الدوال هي التي ستربط تطبيقك بالباك إند (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}