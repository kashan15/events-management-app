import 'package:json_annotation/json_annotation.dart';

part 'survey_questions_model.g.dart';

@JsonSerializable()
class SurveyQuestionsModel {
  SurveyQuestionsModel();

  String? QuestionId;
  String? surveyId;
  String? Question;
  String? Option1;
  String? Option2;
  String? Option3;
  String? Option4;



  factory SurveyQuestionsModel.fromJson(Map<String, dynamic> json) => _$SurveyQuestionsModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyQuestionsModelToJson(this);

}
