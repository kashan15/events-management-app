// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'volunteer_events_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VolunteerEventsModel _$VolunteerEventsModelFromJson(
        Map<String, dynamic> json) =>
    VolunteerEventsModel()
      ..Id = json['Id'] as String?
      ..EventId = json['EventId'] as String?
      ..volunteerId = json['volunteerId'] as String?
      ..volunteertypes = json['volunteertypes'] as String?
      ..fname = json['fname'] as String?
      ..eventName = json['eventName'] as String?
      ..eventType = json['eventType'] as String?
      ..eventBanner = json['eventBanner'] as String?
      ..UserId = json['UserId'] as String?
          //
          ..userId = json['userId'] as String?
          //
      ..district = json['district'] as String?
      ..department = json['department'] as String?
      ..province = json['province'] as String?
      ..eventDescription = json['eventDescription'] as String?
      ..eventDate = json['eventDate'] as String?
      ..location = json['location'] as String?
      ..timeFrom = json['timeFrom'] as String?
      ..timeTo = json['timeTo'] as String?
      ..status = json['status'] as String?
      ..ProfileImage = json['ProfileImage'] as String?
      ..createdDtm = json['createdDtm'] as String?;

Map<String, dynamic> _$VolunteerEventsModelToJson(
        VolunteerEventsModel instance) =>
    <String, dynamic>{
      'Id': instance.Id,
      'EventId': instance.EventId,
      'volunteerId': instance.volunteerId,
      'volunteertypes': instance.volunteertypes,
      'fname': instance.fname,
      'eventName': instance.eventName,
      'eventType': instance.eventType,
      'eventBanner': instance.eventBanner,
      'UserId': instance.UserId,
          //
          'userId': instance.userId,
          //
      'district': instance.district,
      'department': instance.department,
      'province': instance.province,
      'eventDescription': instance.eventDescription,
      'eventDate': instance.eventDate,
      'location': instance.location,
      'timeFrom': instance.timeFrom,
      'timeTo': instance.timeTo,
      'status': instance.status,
      'ProfileImage': instance.ProfileImage,
      'createdDtm': instance.createdDtm,
    };
