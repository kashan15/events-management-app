import 'dart:io';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/modules/dio_service.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;


MainViewModel mainViewModel = locator<MainViewModel>();

class CreateEventService {
  var _dioService = DioService.getInstance();

  Future createEvent(
      String userId,
      String eventType,
      String eventName,
      String eventDescription,
      String department,
      String province,
      String district,
      String location,
      String eventDate,
      String timeFrom,
      String timeTo,
      File? eventBanner,
      int isVolunteer,
      ) async {
    try {
      // mainViewModel.creatingEvent = true;
      // mainViewModel.notifyListeners();

       var eventParams =  FormData.fromMap(
        {
          'UserId': userId,
          'eventType' : eventType,
          'eventName': eventName,
          'eventDescription' : eventDescription,
          'department' : department,
          'province' : province,
          'district' : district,
          'location' : location,
          'eventDate' : eventDate,
          'timeFrom' : timeFrom,
          'timeTo' : timeTo,
          if(eventBanner!= null)'eventBanner' : await MultipartFile.fromFile(eventBanner.path, filename: path.basename(eventBanner.path)),
          'isVolunteer' : isVolunteer
        },
      );

       print(eventParams);

      final response = await _dioService.post(
        'addEvent',data: eventParams

        // {
        //   'UserId': userId,
        //   'fname' : fName,
        //   'gender': gender,
        //   'DOB' : dob,
        //   'department' : department,
        //   'province' : province,
        //   'district' : district,
        //   'ProfileImage' : await MultipartFile.fromFile(profileImage!.path, filename: path.basename(profileImage.path)).toString(),
        //   'email' : email,
        // }
      );
      print(response);
      if(response.statusCode == 200){
        if(response.data["status"] == 200){
          mainViewModel.creatingEvent = false;
          mainViewModel.notifyListeners();
          return true;
        }
        else {
          mainViewModel.creatingEvent = false;
          mainViewModel.notifyListeners();
          return response.data['message'];
        }
      }
    }
    catch (e) {
      mainViewModel.creatingEvent = false;
      mainViewModel.notifyListeners();
      dynamic exception = e;
      return exception.message;
    }
  }
}