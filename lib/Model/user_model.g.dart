// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..UserId = json['UserId'] as String?
  //
  ..userId = json['userId'] as String?
  //
  ..email = json['email'] as String?
  ..password = json['password'] as String?
  ..ConfirmPassword = json['ConfirmPassword'] as String?
  ..NewPassword = json['NewPassword'] as String?
  ..country_code = json['country_code'] as String?
  ..phone_no = json['phone_no'] as String?
  ..code = json['code'] as String?
  ..createdDtm = json['createdDtm'] as String?
  ..fname = json['fname'] as String?
  ..gender = json['gender'] as String?
  ..DOB = json['DOB'] as String?
  ..mobile_no = json['mobile_no'] as String?
  ..department = json['department'] as String?
  ..province = json['province'] as String?
  ..district = json['district'] as String?
  ..OldPassword = json['OldPassword'] as String?
  ..ConfirmNewPassword = json['ConfirmNewPassword'] as String?
  ..updatedDtm = json['updatedDtm'] as String?
  ..ProfileImage = json['ProfileImage'] as String?
  ..FirebaseUserId = json['FirebaseUserId'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'UserId': instance.UserId,
  //
  'userId': instance.userId,
  //
      'email': instance.email,
      'password': instance.password,
      'ConfirmPassword': instance.ConfirmPassword,
      'NewPassword': instance.NewPassword,
      'country_code': instance.country_code,
      'phone_no': instance.phone_no,
      'code': instance.code,
      'createdDtm': instance.createdDtm,
      'fname': instance.fname,
      'gender': instance.gender,
      'DOB': instance.DOB,
      'mobile_no': instance.mobile_no,
      'department': instance.department,
      'province': instance.province,
      'district': instance.district,
      'OldPassword': instance.OldPassword,
      'ConfirmNewPassword': instance.ConfirmNewPassword,
      'updatedDtm': instance.updatedDtm,
      'ProfileImage': instance.ProfileImage,
      'FirebaseUserId': instance.FirebaseUserId,
    };
