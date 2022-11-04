import 'package:json_annotation/json_annotation.dart';

part 'get_provinces.g.dart';

@JsonSerializable()
class GetProvincesModel {
  GetProvincesModel();

  String? id;
  String? provinceName;


  factory GetProvincesModel.fromJson(Map<String, dynamic> json) => _$GetProvincesModelFromJson(json);
  Map<String, dynamic> toJson() => _$GetProvincesModelToJson(this);

}
