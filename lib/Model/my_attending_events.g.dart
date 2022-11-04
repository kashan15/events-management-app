// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_attending_events.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyAttendeeModel _$MyAttendeeModelFromJson(Map<String, dynamic> json) =>
    MyAttendeeModel()
      ..attendeeUser = json['attendeeUser'] as String?
      ..organizerName = json['organizerName'] as String?
      ..organizerImage = json['organizerImage'] as String?
      ..id = json['id'] as String?
      ..UserId = json['UserId'] as String?
      ..eventType = json['eventType'] as String?
      ..eventName = json['eventName'] as String?
      ..eventDescription = json['eventDescription'] as String?
      ..eventBanner = json['eventBanner'] as String?
      ..department = json['department'] as String?
      ..province = json['province'] as String?
      ..district = json['district'] as String?
      ..location = json['location'] as String?
      ..eventDate = json['eventDate'] as String?
      ..timeFrom = json['timeFrom'] as String?
      ..timeTo = json['timeTo'] as String?
      ..status = json['status'] as String?
      ..createdDtm = json['createdDtm'] as String?;

Map<String, dynamic> _$MyAttendeeModelToJson(MyAttendeeModel instance) =>
    <String, dynamic>{
      'attendeeUser': instance.attendeeUser,
      'organizerName': instance.organizerName,
      'organizerImage': instance.organizerImage,
      'id': instance.id,
      'UserId': instance.UserId,
      'eventType': instance.eventType,
      'eventName': instance.eventName,
      'eventDescription': instance.eventDescription,
      'eventBanner': instance.eventBanner,
      'department': instance.department,
      'province': instance.province,
      'district': instance.district,
      'location': instance.location,
      'eventDate': instance.eventDate,
      'timeFrom': instance.timeFrom,
      'timeTo': instance.timeTo,
      'status': instance.status,
      'createdDtm': instance.createdDtm,
    };
