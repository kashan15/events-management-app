import 'package:democratic_unity/Model/survey_questions_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'survey_model.g.dart';

@JsonSerializable()
class SurveyModel {
  SurveyModel();

  String? surveyId;
  String? Title;
  String? Description;
  String? createdDtm;
  List<SurveyQuestionsModel>? Questions;



  factory SurveyModel.fromJson(Map<String, dynamic> json) => _$SurveyModelFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

}
