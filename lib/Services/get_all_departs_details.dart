import 'package:democratic_unity/Model/get_departments.dart';
import 'package:democratic_unity/modules/dio_service.dart';

class GetAllDepartments {
  var _dioService = DioService.getInstance();

  Future getDepartDetails() async{
    try{
      final response = await _dioService.get('allRegionDetails');
      if(response.statusCode == 200){
        if(response.data['status'] == true){
          Map<String, dynamic> regionalDetails = response.data['data'];
          List regionalDepartments = regionalDetails["departments"];
          var gettingAllDepartments = regionalDepartments.map((e) => GetDepartmentsModel.fromJson(e)).toList();
          // List<GetRegionalDetailsModel> gettingAllRegionalDetails =
          // regionalDetails.map((e) => GetRegionalDetailsModel.fromJson(e)).toList();
          // return gettingAllRegionalDetails;
          return gettingAllDepartments;
        }
        else{
          print("something went wrong");
          return [];
        }
      }
      else{
        print("something went wrong");
        return [];
      }
    }
    catch(e){
      print(e);
    }
  }

}