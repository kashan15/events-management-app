import 'package:democratic_unity/modules/dio_service.dart';

class CheckSurveyResult {
  var _dioService = DioService.getInstance();

  Future checkSurvey(String userId, String surveyId) async {
    try {
      final response = await _dioService.post('checkSurveyResult', data: {
        'UserId': userId,
        'SurveyId': surveyId,
      });
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          return true;
        }
        else if(response.data["status"] == 400) {
          return response.data['message'];
        }
      }
      else{
        return ("some thing went wrong");
      }
    }
    catch (e) {
      dynamic exception = e;
      return exception.message;
    }
  }

}