import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/Model/news_feed.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetNewsFeed {
  var _dioService = DioService.getInstance();

  Future gettingNewsFeed(NewsFeedModel newsFeedModel) async{
    try{
      final response = await _dioService.get('getNewsFeed');
      if(response.statusCode == 200){
        if(response.data['status'] == 200){
          List<dynamic> newsDetails = response.data['data'];
          List gettingAllNews = newsDetails.map((e) => NewsFeedModel.fromJson(e)).toList();
          return gettingAllNews;
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
      print(e);
    }
  }

}