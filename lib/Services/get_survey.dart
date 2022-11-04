import 'package:democratic_unity/Model/survey_model.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetSurvey {
  var _dioService = DioService.getInstance();

  Future getSurveyQuestions() async{
    try{
      final response = await _dioService.get('getAppSurveyData');
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          List<dynamic> survey = response.data['data'];
          List gettingSurvey = survey.map((e) => SurveyModel.fromJson(e)).toList();
          return gettingSurvey;
        }
        else{
          return response.data['message'];
        }
      }
      else{
        return response.data['message'];
      }
    }
    catch(e){
      return e.toString();
      print(e);
    }
  }

}