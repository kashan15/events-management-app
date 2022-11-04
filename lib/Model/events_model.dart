import 'package:json_annotation/json_annotation.dart';

part 'events_model.g.dart';

@JsonSerializable()
class EventsModel {
  EventsModel();

  String? fname;
  String? ProfileImage;
  String? FirebaseUserId;
  //
  String? id;
  //
  String? Id;
  //
  String? eventId;
  String? UserId;
  //
  // String? userId;
  //
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
  String? isVolunteer;



  factory EventsModel.fromJson(Map<String, dynamic> json) => _$EventsModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventsModelToJson(this);

}
