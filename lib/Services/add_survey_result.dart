import 'dart:convert';

import 'package:democratic_unity/Model/survey_question_of_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:dio/dio.dart';

class AddSurveyService {
  var _dioService = DioService.getInstance();

  Future addSurveyDetail(
      List<SurveyQuestionsOfModel> surveyList,
      ) async {
    try {
      var data = surveyList.map((e) => e.toJson()).toList();
      //var datas = jsonEncode(data);
      var mappedData = {
        "resultdata" : data
      };
      // var mapData = jsonEncode(mappedData);
      final response = await _dioService.post(
        'addSurveyResult',
        data: mappedData,
      );

      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          return true;
        }
        else {
          return response.data['message'];
        }
      }
    }
    catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }
}