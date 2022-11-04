import 'package:json_annotation/json_annotation.dart';

part 'my_attending_events.g.dart';

@JsonSerializable()
class MyAttendeeModel {
  MyAttendeeModel();

  String? attendeeUser;
  String? organizerName;
  String? organizerImage;
  String? id;
  String? UserId;
  String? eventType;
  String? eventName;
  String? eventDescription;
  String? eventBanner;
  String? department;
  String? province;
  String? district;
  String? location;
  String? eventDate;
  String? timeFrom;
  String? timeTo;
  String? status;
  String? createdDtm;




  factory MyAttendeeModel.fromJson(Map<String, dynamic> json) => _$MyAttendeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyAttendeeModelToJson(this);

}
