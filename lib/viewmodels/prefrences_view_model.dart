import 'dart:convert';
import 'package:democratic_unity/Model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class PreferencesViewModel extends BaseViewModel{

  UserModel? userDetail;
  var data;


  Future updateUserData(UserModel userData) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userData", jsonEncode(userData));
    userDetail = userData;
    //isVerified = value;
    notifyListeners();
  }

  Future saveUserData(UserModel userData) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userData", jsonEncode(userData));
    userDetail = userData;
    notifyListeners();
  }

  Future saveData(var userData) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("data", jsonEncode(data));
    data = userData;
    notifyListeners();
  }

  Future removeUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    userDetail = null;
    notifyListeners();
  }
  Future getUserData() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get("userData")!=null) {
      userDetail =
          UserModel.fromJson(jsonDecode(sharedPreferences.getString("userData")!));
      notifyListeners();
    }
  }

}