// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map<String, dynamic> json) => SurveyModel()
  ..surveyId = json['surveyId'] as String?
  ..Title = json['Title'] as String?
  ..Description = json['Description'] as String?
  ..createdDtm = json['createdDtm'] as String?
  ..Questions = (json['Questions'] as List<dynamic>?)
      ?.map((e) => SurveyQuestionsModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) =>
    <String, dynamic>{
      'surveyId': instance.surveyId,
      'Title': instance.Title,
      'Description': instance.Description,
      'createdDtm': instance.createdDtm,
      'Questions': instance.Questions,
    };
