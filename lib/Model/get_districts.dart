import 'package:json_annotation/json_annotation.dart';

part 'get_districts.g.dart';

@JsonSerializable()
class GetDistrictsModel {
  GetDistrictsModel();

  String? id;
  String? districtName;


  factory GetDistrictsModel.fromJson(Map<String, dynamic> json) => _$GetDistrictsModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetDistrictsModelToJson(this);

}
