import 'package:json_annotation/json_annotation.dart';

part 'volunteer_events_model.g.dart';

@JsonSerializable()
class VolunteerEventsModel {
  VolunteerEventsModel();

  String? Id;
  String? EventId;
  String? volunteerId;
  String? volunteertypes;
  String? fname;
  String? eventName;
  String? eventType;
  String? eventBanner;
  String? UserId;
  //
  String? userId;
  //
  String? district;
  String? department;
  String? province;
  String? eventDescription;
  String? eventDate;
  String? location;
  String? timeFrom;
  String? timeTo;
  String? status;
  String? ProfileImage;
  String? createdDtm;




  factory VolunteerEventsModel.fromJson(Map<String, dynamic> json) => _$VolunteerEventsModelFromJson(json);
  Map<String, dynamic> toJson() => _$VolunteerEventsModelToJson(this);

}
