import 'package:json_annotation/json_annotation.dart';

part 'survey_question_of_model.g.dart';

@JsonSerializable()
class SurveyQuestionsOfModel {
  SurveyQuestionsOfModel();

  int? QuestionId;
  int? UserId;
  int? SurveyId;
  String? Answer;



  factory SurveyQuestionsOfModel.fromJson(Map<String, dynamic> json) => _$SurveyQuestionsOfModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyQuestionsOfModelToJson(this);

}
