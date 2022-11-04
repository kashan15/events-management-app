// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_questions_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyQuestionsModel _$SurveyQuestionsModelFromJson(
        Map<String, dynamic> json) =>
    SurveyQuestionsModel()
      ..QuestionId = json['QuestionId'] as String?
      ..surveyId = json['surveyId'] as String?
      ..Question = json['Question'] as String?
      ..Option1 = json['Option1'] as String?
      ..Option2 = json['Option2'] as String?
      ..Option3 = json['Option3'] as String?
      ..Option4 = json['Option4'] as String?;

Map<String, dynamic> _$SurveyQuestionsModelToJson(
        SurveyQuestionsModel instance) =>
    <String, dynamic>{
      'QuestionId': instance.QuestionId,
      'surveyId': instance.surveyId,
      'Question': instance.Question,
      'Option1': instance.Option1,
      'Option2': instance.Option2,
      'Option3': instance.Option3,
      'Option4': instance.Option4,
    };
