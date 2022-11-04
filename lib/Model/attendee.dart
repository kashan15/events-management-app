import 'package:json_annotation/json_annotation.dart';

part 'attendee.g.dart';

@JsonSerializable()
class AttendeeModel {
  AttendeeModel();


  String? UserId;
  String? eventId;
  //
  String? Id;
  //
  String? fname;
  String? ProfileImage;
  String? FirebaseUserId;

  // String? UserId;
  // String? fname;
  // String? Id;
  //
  // String? ProfileImage;
  // String? FirebaseUserId;





  factory AttendeeModel.fromJson(Map<String, dynamic> json) => _$AttendeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$AttendeeModelToJson(this);

  // factory AttendeeModel.fromJson(Map<String, dynamic> map) => _$AttendeeModelFromJson(map);
  // Map<String, dynamic> toJson() => _$AttendeeModelToJson(this);

}
