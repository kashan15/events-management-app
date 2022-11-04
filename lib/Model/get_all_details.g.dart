// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRegionalDetailsModel _$GetRegionalDetailsModelFromJson(
        Map<String, dynamic> json) =>
    GetRegionalDetailsModel()
      ..departments = (json['departments'] as List<dynamic>?)
          ?.map((e) => GetDepartmentsModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..provinces = (json['provinces'] as List<dynamic>?)
          ?.map((e) => GetProvincesModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..districts = (json['districts'] as List<dynamic>?)
          ?.map((e) => GetDistrictsModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetRegionalDetailsModelToJson(
        GetRegionalDetailsModel instance) =>
    <String, dynamic>{
      'departments': instance.departments,
      'provinces': instance.provinces,
      'districts': instance.districts,
    };
