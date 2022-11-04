import 'package:democratic_unity/modules/dio_service.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:stacked/stacked.dart';
import 'package:democratic_unity/modules/navigation_service.dart'
as my_nav_service;


// class DeleteEventService {
//   var _dioService = DioService.getInstance();
//
//   Future deleteEvent(
//       // String EventId,
//       String id,
//       // String UserId,
//       String userId,
//       ) async {
//     try {
//       final response = await _dioService.post(
//         'deleteEvent',
//         data: FormData.fromMap(
//           {
//             // 'EventId' : EventId,
//             'EventId' : id,
//             // 'UserId' : UserId,
//             'UserId' : userId,
//           },
//         ),
//       );
//       if(response.statusCode == 200){
//         if(response.data["status"] == true){
//           return true;
//         }
//         else {
//           return response.data['message'];
//         }
//       }
//     }
//     catch (e) {
//       dynamic exception = e;
//       return exception.message;
//     }
//   }
// }

class DeleteEventService extends BaseViewModel {
  var _dioService = DioService.getInstance();

  var navigationService = my_nav_service.NavigationService();
  bool isLoading1 = false;

  Future deleteEvent(// String EventId,
      String id,
      // String UserId,
      String userId,) async {
    // isLoading1 = true;

    try {
      var eventParams = FormData.fromMap({
        // 'EventId' : EventId,
        'EventId': id,
        // 'UserId' : UserId,
        'UserId': userId,
      },
      );
      print(eventParams);

      final response = await _dioService.post('deleteEvent', data: eventParams);
      print(response);

      // if(response.statusCode == 200){
      //   if(response.data["status"] == true){
      //     return true;
      //   }
      //   else {
      //     return response.data['message'];
      //   }
      // }

      if (response is String) {
        isLoading1 = false;
        notifyListeners();
      }

      if (response.statusCode == 200) {
        if (response.data["status"] == true) {
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