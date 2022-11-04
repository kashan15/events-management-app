import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel();

  String? UserId;
  //
  String? userId;
  //
  String? email;
  String? password;
  String? ConfirmPassword;
  String? NewPassword;
  String? country_code;
  String? phone_no;
  String? code;
  String? createdDtm;
  String? fname;
  String? gender;
  String? DOB;
  String? mobile_no;
  String? department;
  String? province;
  String? district;
  String? OldPassword;
  String? ConfirmNewPassword;
  String? updatedDtm;
  String? ProfileImage;
  String? FirebaseUserId;



  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

}
