// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_question_of_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyQuestionsOfModel _$SurveyQuestionsOfModelFromJson(
        Map<String, dynamic> json) =>
    SurveyQuestionsOfModel()
      ..QuestionId = json['QuestionId'] as int?
      ..UserId = json['UserId'] as int?
      ..SurveyId = json['SurveyId'] as int?
      ..Answer = json['Answer'] as String?;

Map<String, dynamic> _$SurveyQuestionsOfModelToJson(
        SurveyQuestionsOfModel instance) =>
    <String, dynamic>{
      'QuestionId': instance.QuestionId,
      'UserId': instance.UserId,
      'SurveyId': instance.SurveyId,
      'Answer': instance.Answer,
    };
