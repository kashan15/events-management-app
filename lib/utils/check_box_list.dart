class CheckBoxListTileModel {
  int? volunteerId;
  String? title;
  bool? isCheck;

  CheckBoxListTileModel({this.volunteerId, this.title, this.isCheck});

  static List<CheckBoxListTileModel> getUsers() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          volunteerId: 1,
          title: "Making calls",
          isCheck: false),
      CheckBoxListTileModel(
          volunteerId: 2,
          title: "Knocking on doors",
          isCheck: false),
      CheckBoxListTileModel(
          volunteerId: 3,
          title: "Collecting Signatures",
          isCheck: false),
      CheckBoxListTileModel(
          volunteerId: 4,
          title: "Organizing Fundraising Activities",
          isCheck: false),
      CheckBoxListTileModel(
          volunteerId: 5,
          title: "Other forms",
          isCheck: false),
    ];
  }
}