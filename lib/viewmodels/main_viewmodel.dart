import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:democratic_unity/Model/attendee.dart';
import 'package:democratic_unity/Model/events_model.dart';
import 'package:democratic_unity/Model/get_departments.dart';
import 'package:democratic_unity/Model/get_districts.dart';
import 'package:democratic_unity/Model/get_provinces.dart';
import 'package:democratic_unity/Model/my_attending_events.dart';
import 'package:democratic_unity/Model/news_feed.dart';
import 'package:democratic_unity/Model/survey_model.dart';
import 'package:democratic_unity/Model/survey_question_of_model.dart';
import 'package:democratic_unity/Model/survey_questions_model.dart';
import 'package:democratic_unity/Model/user_model.dart' as userModel;
import 'package:democratic_unity/Model/user_model.dart';
import 'package:democratic_unity/Services/attending_event.dart';
import 'package:democratic_unity/Model/volunteer_events_model.dart';
import 'package:democratic_unity/Services/add_survey_result.dart';
import 'package:democratic_unity/Services/add_volunteer.dart';
import 'package:democratic_unity/Services/all_search_events.dart';
import 'package:democratic_unity/Services/all_search_people.dart';
import 'package:democratic_unity/Services/attending_event.dart';
import 'package:democratic_unity/Services/check_survey_result.dart';
import 'package:democratic_unity/Services/check_user.dart';
import 'package:democratic_unity/Services/create_event_service.dart';
import 'package:democratic_unity/Services/delete_event.dart';
import 'package:democratic_unity/Services/donate_service.dart';
import 'package:democratic_unity/Services/firebase_chat.dart';
import 'package:democratic_unity/Services/get_attendee.dart';
import 'package:democratic_unity/Services/get_attending_events.dart';
import 'package:democratic_unity/Services/get_my_events.dart';
import 'package:democratic_unity/Services/get_news_feed.dart';
import 'package:democratic_unity/Services/get_survey.dart';
import 'package:democratic_unity/Services/get_user_details.dart';
import 'package:democratic_unity/Services/get_volunteer_events.dart';
import 'package:democratic_unity/Services/get_volunteers_by_uid.dart';
import 'package:democratic_unity/Services/get_voluntree_users.dart';
import 'package:democratic_unity/Services/multiple_app_users.dart';
import 'package:democratic_unity/Services/nearby_event.dart';
import 'package:democratic_unity/Services/post_status.dart';
import 'package:democratic_unity/Services/reset_password.dart';
import 'package:democratic_unity/Services/create_new_password.dart';
import 'package:democratic_unity/Services/forgot_password_email.dart';
import 'package:democratic_unity/Services/get_all_departs_details.dart';
import 'package:democratic_unity/Services/get_all_districts_detail.dart';
import 'package:democratic_unity/Services/get_all_provinces_detail.dart';
import 'package:democratic_unity/Services/get_upcoming_events.dart';
import 'package:democratic_unity/Services/login.dart';
import 'package:democratic_unity/Services/search_events_by_date.dart';
import 'package:democratic_unity/Services/search_events_by_filter.dart';
import 'package:democratic_unity/Services/search_users_by_district.dart';
import 'package:democratic_unity/Services/signup.dart';
import 'package:democratic_unity/Services/add_user_details.dart';
import 'package:democratic_unity/Services/update_user_profile.dart';
import 'package:democratic_unity/Services/user_feedback.dart';
import 'package:democratic_unity/Services/verify_forget_pass_code.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/modules/navigation_service.dart'
    as my_nav_service;
import 'package:democratic_unity/utils/check_box_list.dart';
import 'package:democratic_unity/utils/color_utils.dart';
import 'package:democratic_unity/utils/common_functions.dart';
import 'package:democratic_unity/utils/constants.dart';
import 'package:democratic_unity/utils/dialog_utils.dart';
import 'package:democratic_unity/utils/extensions.dart';
import 'package:democratic_unity/utils/font_utils.dart';
import 'package:democratic_unity/utils/image_utils.dart';
import 'package:democratic_unity/views/ActionButton/create_event.dart';
import 'package:democratic_unity/views/AllEvents/all_events.dart';
import 'package:democratic_unity/views/AllEvents/all_events_detail.dart';
import 'package:democratic_unity/views/EventDetails/event_details.dart';
import 'package:democratic_unity/views/NearBy/near_by_events.dart';
import 'package:democratic_unity/views/Search/search_events.dart';
import 'package:democratic_unity/views/Search/searched_events_by_location.dart';
import 'package:democratic_unity/views/Survey/survey_preview.dart';
import 'package:democratic_unity/views/Volunteer/upcoming_volunteer_details.dart';
import 'package:democratic_unity/views/Volunteer/volunteer.dart';
import 'package:democratic_unity/views/chat_list_screen.dart';
import 'package:democratic_unity/views/check_email.dart';
import 'package:democratic_unity/views/enter_login_otp.dart';
import 'package:democratic_unity/views/reset_password.dart';
import 'package:democratic_unity/views/enter_details.dart';
import 'package:democratic_unity/views/enter_signup_otp.dart';
import 'package:democratic_unity/views/forgot_password_otp.dart';
import 'package:democratic_unity/views/home_screen.dart';
import 'package:democratic_unity/views/login.dart';
import 'package:democratic_unity/views/main_view.dart';
import 'package:democratic_unity/widgets/app_language.dart';
import 'package:democratic_unity/widgets/error_check.dart';
import 'package:democratic_unity/widgets/error_widget.dart';
import 'package:democratic_unity/widgets/firebase_otp.dart';
import 'package:democratic_unity/widgets/list_item.dart';
import 'package:democratic_unity/widgets/question.dart';
import 'package:dio/dio.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:google_place/google_place.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pubnub/pubnub.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:pubnub/core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:url_launcher/url_launcher.dart';

enum SortCharacter {
  Comas,
  Ate,
  //San Martín de Porres,
}
enum DatesCharacter {
  Today,
  Tomorrow,
  ThisWeek,
  ThisWeekend,
  NextWeek,
  AllUpcoming,
  CustomDate
}

class MainViewModel extends BaseViewModel {
  var navigationService = my_nav_service.NavigationService();
  TextEditingController signupPhoneController =
      TextEditingController(text: '123456789');
  String? signupCountryCode;
  TextEditingController completeSignupPhoneNumber = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  bool signupPasswordVisible = true;
  TextEditingController signupConfirmPasswordController =
      TextEditingController();
  bool signupConfirmPasswordVisible = true;
  final signupCodeController = TextEditingController();
  Timer? signupTimer;
  int SignupStart = 30;
  TextEditingController emailCodeController = TextEditingController();
  TextEditingController loginPhoneController =
      TextEditingController(text: '123456789');
  TextEditingController completeLoginPhoneNumber = TextEditingController();
  String? loginCountryCode;
  TextEditingController loginPasswordController = TextEditingController();
  bool loginPasswordVisible = true;
  TextEditingController forgotPasswordEmailController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  bool oldPasswordVisible = true;
  TextEditingController resetNewPasswordController = TextEditingController();
  bool createNewPasswordVisible = true;
  TextEditingController resetConfirmNewPasswordController =
      TextEditingController();
  bool createConfirmPasswordVisible = true;
  TextEditingController enterDetailsNameController = TextEditingController();
  TextEditingController enterDetailsEmailController = TextEditingController();
  DateTime selectedDOB = DateTime.now();
  bool dateOfBirthSelected = false;
  TextEditingController enterDetailsPhoneController = TextEditingController();
  bool departSelected = false;
  bool provinceSelected = false;
  bool districtSelected = false;
  bool myProfileSelected = false;
  bool donateSelected = false;
  bool volunteerSelected = false;
  bool eventsSelected = false;
  bool surveySelected = false;
  bool settingsSelected = false;
  bool contactUsSelected = false;
  bool feedbackSelected = false;
  bool signOutSelected = false;
  bool attendingEvent = false;
  XFile? _pickedFile;
  File? profileFileImage;
  bool loggedIn = false;
  TextEditingController searchEventsController = TextEditingController();

  //SortCharacter? characterValue = SortCharacter.LeastNumberOfPeople;
  String groupsValue = "Comas";
  bool sortByBottomSheet1 = true;
  bool sortByBottomSheet2 = false;
  bool sortByBottomSheet3 = false;
  bool sortByBottomSheet4 = false;
  DatesCharacter? datesCharacterValue = DatesCharacter.Today;
  bool today = true;
  bool tomorrow = false;
  bool thisWeek = false;
  bool thisWeekend = false;
  bool nextWeek = false;
  bool allUpcoming = false;
  bool customDate = false;
  DateTime customDOB = DateTime.now();
  FocusNode searchUserFocus = new FocusNode();
  bool isSearchUserInFocus = false;
  TextEditingController searchUserController = TextEditingController();
  String? lowValue = "50";
  String? highValue = "180";
  double lowerValue = 50;
  double upperValue = 180;
  TextEditingController profilePhoneController = TextEditingController();
  XFile? _profilePickedFile;
  File? userProfileImage;
  bool editPressed = false;

  /// Create Event
  List<String> eventTypes = [
    "Small Meeting",
    "Small Gathering",
    "Big Meeting",
    "Big Gathering",
  ];
  TextEditingController createEventName = TextEditingController();
  TextEditingController createEventDescription = TextEditingController();
  TextEditingController createEventLocation = TextEditingController();
  bool eventDateSelected = false;

  //DateTime eventDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  XFile? _createEventPickedFile;
  File? createEventImage;
  bool bannerImageSelected = false;
  List createEventImages = [];
  bool eventDepartSelected = false;
  bool eventProvinceSelected = false;
  bool eventDistrictSelected = false;
  DateTime dateTime = DateTime.now();
  String? openingTimeFrom;
  String? openingTimeTo;
  bool showCreateEventDialog = false;
  TextEditingController createEventCashController = TextEditingController();
  String? selectedEvent;
  bool eventTypeSelected = false;
  String? selectedEventType;

  var createEventService = CreateEventService();
  bool creatingEvent = false;

  String? eventSelectedDepart;
  String? eventSelectedProv;
  String? eventSelectedDist;

  bool volunteerEvent = false;
  int volunteerValue = 0;

  /// ****** ////

  String? selectDepart;
  String? selectProvince;
  String? selectDistrict;
  FocusNode enterCardNumberFocus = new FocusNode();
  bool isEnterCardNumberInFocus = false;
  TextEditingController enterCardNumber = TextEditingController();
  FocusNode enterCardExpiryFocus = new FocusNode();
  bool isEnterCardExpiryInFocus = false;
  TextEditingController enterExpiry = TextEditingController();
  FocusNode enterCardCvvFocus = new FocusNode();
  bool isEnterCardCvvInFocus = false;
  TextEditingController enterCvv = TextEditingController();
  FocusNode enterCardHolderFocus = new FocusNode();
  bool isEnterCardHolderInFocus = false;
  TextEditingController enterAmount = TextEditingController();
  TextEditingController searchController = TextEditingController();
  bool eventSelected = true;
  bool userSelected = false;
  XFile? myProfilePickedFile;
  File? myProfileImage;
  String? errorMessage;
  List allQuestions = [
    {
      'questionNumber': '1.',
      'question': 'Question Number One',
      'choice1': 'John1',
      'choice2': 'John2',
      'choice3': 'John3',
      'choice4': 'John4',
    },
    {
      'questionNumber': '2.',
      'question': 'Question Number Two',
      'choice1': 'Harry1',
      'choice2': 'Harry2',
      'choice3': 'Harry3',
      'choice4': 'Harry4',
    },
  ];

  bool question1Done = false;
  bool question2Done = false;

  var questionIndex = 0;
  bool choice1Selected = false;
  bool choice2Selected = false;
  bool choice3Selected = false;
  bool choice4Selected = false;

  int? surveyCurrentIndex;
  bool notificationSwitchValue = true;
  bool receivingMessagesSwitchValue = true;
  bool newEventsSwitchValue = true;
  List questionsList = [];

  bool searchUserEmojiShowing = false;
  bool searchUserEmojiSelected = false;
  final searchUserChatController = TextEditingController();
  final searchUserScrollController = ScrollController();

  bool adminEmojiShowing = false;
  bool adminEmojiSelected = false;
  TextEditingController adminChatController = TextEditingController();
  final adminScrollController = ScrollController();

  var donateCardController = MaskedTextController(mask: '00000 0000 0000 0000');
  var donateCardExpiryController = MaskedTextController(mask: '00/00');
  var donateCardCvvController = MaskedTextController(mask: '000');

  /// Enter Details
  List<String> genderDetails = [
    'Male',
    'Female',
  ];

  List<GetDepartmentsModel> departList = [];
  List<String> allDepartmentsList = [];
  String? selectedDepart;
  bool enterDetailsDepartSelected = false;
  List<GetProvincesModel> provinceList = [];
  List<String> allProvincesList = [];
  String? selectedProv;
  bool enterDetailsProvinceSelected = false;
  List<GetDistrictsModel> districtList = [];
  List<String> allDistrictsList = [];
  String? selectedDist;
  bool enterDetailsDistrictSelected = false;
  String? detailsSelectGender;

  /// ***** ///

  String? loginCodeVerificationId = "";
  Timer? loginTimer;
  int loginStart = 30;
  final loginCodeController = TextEditingController();

  // List volunteerServicesSelected = [];
  // List allVolunteerServices = [
  //   "Making calls",
  //   "Knocking on doors",
  //   "Collecting Signatures",
  //   "Organizing Fundraising Activities",
  //   "Other forms",
  // ];
  // bool volunteerServiceIsChecked = false;

  XFile? enterDetailsPickedFile;
  File? enterDetailsProfileFileImage;

  //= File(ImageUtils.profilePicture);
  String? enterDetailsProfilePic;

  List places = [];
  var risult;
  bool placeSelected = false;

  /// For SharedPreferences
  SharedPreferences? prefs;
  String? userIdPref;
  String? countryCodePref;
  String? country_code;
  String? emailPref;
  String? passwordPref;
  String? phoneNoPref;
  String? mobileNoPref;
  String? fNamePref;
  String? genderPref;
  String? dobPref;
  String? departmentPref;
  String? provincePref;
  String? districtPref;
  String? createdDtmPref;
  String? updatedDtmPref;
  String? profilePic;

  /// User Details
  String? userId;
  String? email;
  String? password;
  String? phoneNo;
  String? mobileNo;

  // String? fName;
  String? fName;
  String? gender;
  String? dob;
  String? getUserDepartment;
  String? getUserProvince;
  String? getUserDistrict;
  String? createdDtm;
  String? updatedDtm;
  String? getUserprofilePic;
  bool userStatus = false;

  /// For API's
  bool loggingIn = false;
  var logInTheUser = LoginUser();

  bool signingIn = false;
  var signIn = SignupUser();
  String signupError = "";

  bool addingDetails = false;
  var adduserDetails = UserDetailsService();

  bool readyingAllDepartments = false;
  var gettingAllTheDepartments = GetAllDepartments();

  var gettingAllTheProvinces = GetAllProvinces();

  var gettingAllTheDistricts = GetAllDistricts();

  var gettingUserEmail = ForgetPassword();
  bool checkingUserEmail = false;

  var creatingNewPassword = CreatingNewPassword();
  bool settingNewPassword = false;

  var checkIfUserExists = CheckUser();
  bool checkUser = false;

  var verifyForgetPassCode = VerifyForgetPassCode();
  bool verifyEmailCode = false;

  var getAllEvents = GetAllEvents();
  bool gettingAllEvents = false;

  var resetThePassword = ResetThePassword();
  bool resettingPassword = false;

  var userDetails = GetUserDetails();
  bool gettingUserDetails = false;

  List<EventsModel> upComingeventsList = [];

  //String? currentUserId;

  /// Attending Event
  var attendEvent = AttendEvent();
  bool attendingTheEvents = false;
  bool justAdded = false;
  bool volunteerJustAdded = false;

  /// getting Attendee
  var getAttendee = GetAttendee();
  List<AttendeeModel> attendeesDetails = [];

  // String? attendeeEventId;
  String? attendeeId;
  String? attendeeName;
  String? attendeeProfilePic;
  dynamic attendeeLength = 0;
  List<dynamic>? attendeesUserId;
  List<dynamic>? attendeesProfilePics;

  // List<String>? attendeesProfilePics;
  bool containsId = false;

  /// Getting Voluntree
  var getVoluntree = GetVoluntree();
  List<AttendeeModel> voluntreeDetails = [];
  String? voluntreeEventId;
  String? voluntreeId;
  String? voluntreeName;
  String? voluntreeProfilePic;
  int? voluntreeLength;
  List<dynamic>? voluntreesUserId;
  List<dynamic>? voluntreesProfilePics;

  // List<String>? voluntreesProfilePics;
  bool volunteerContainsId = false;

  /// My List
  bool myEventsSelected = false;

  //bool gettingMyAttendeeDetails = false;
  List myTheEventsList = [];
  int? myEventsAttendeeLength;

  /// My Events
  //bool myEventsSelected = false;
  List<EventsModel> myEventsList = [];
  int myTotalEvents = 0;

  /// Get Created Event Details
  var gettingTheEvents = GetMyEvents();
  int? totalAttendee;

  /// Events User Attending
  var getAttendingEvents = GetAttendingEvents();
  String? Id;

  // String? userId;

  //bool gettingEventsByUser = false;
  List<MyAttendeeModel> myAttendingEventsList = [];

  bool isLoading = false;

  /// App Language
  AppLanguage appLanguage = locator<AppLanguage>();
  int? languageSelected;

  /// Delete Event
  var deleteTheEvent = DeleteEventService();
  // bool isloading1 = false;

  /// Edit Profile
  var updateUserDetails = UpdateProfileService();
  TextEditingController editProfileNameController = TextEditingController();
  String? editProfileGender;
  DateTime editProfileSelectedDOB = DateTime.now();
  String? editProfileDate;
  String? editProfileSelectedDepart;
  String? editProfileSelectedProv;
  String? editProfileSelectedDist;
  String? editProfilePic;
  File? editProfileFileImage;

  /// NearBy You
  var nearByEvents = GetNearByEvents();
  List<EventsModel> nearByList = [];
  int? totalNearByList;

  /// Volunteer Event
  bool volunteeringEvent = false;
  bool volunteerEventSelected = false;
  bool goingToVolunteer = false;
  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();
  List<String> selectedJob = [];
  String? titleValue;
  var addVolunteer = AddVolunteer();

  /// All Search Events
  var allSearch = AllSearch();
  bool eventButtonPressed = false;
  List<EventsModel> allSearchedEventsList = [];

  /// Search By Date
  var searchDateEvents = SearchDateEvents();
  bool doneDatePressed = false;
  List<EventsModel> searchedDateEvents = [];
  DateTime customDateValue = DateTime.now();

  /// Search By Filter with Location
  var searchEventsByFilter = SearchEventsByFilter();
  bool filterSearchSelected = false;
  List<EventsModel> filteredEventsWithLocation = [];

  /// All Search People
  var allSearchedPeople = AllSearchPeople();
  bool peopleButtonPressed = false;
  List<userModel.UserModel> allSearchedPeopleList = [];

  /// Get People By District
  var searchUsersByDistrict = SearchUsersByDistrict();

  //bool peopleButtonPressed = false;
  List<userModel.UserModel> allSearchedDistrictPeople = [];
  TextEditingController districtSearchController = TextEditingController();
  bool radioSelected = false;
  String radioValue = "";
  bool districtsRadioSelected = false;

  /// District Location
  String? changeLocationDist;

  /// NewsFeed
  var newsFeed = GetNewsFeed();
  List<NewsFeedModel> newsFeedList = [];

  /// chatScreen
  final chatController = TextEditingController();
  bool emojiShowing = false;
  bool emojiSelected = false;
  final scrollController = ScrollController();
  XFile? chatPickedFile;
  File? chatImage;
  String? chatPic;

  /// Firebase
  FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? subscription;
  FirebaseOTP firebasefirebaseOTP = FirebaseOTP();
  String? signupCodeVerificationId = "";
  String? loggedInFirebaseUserId;
  FirebaseChat firebaseChat = FirebaseChat();
  String? currentUserFbId;
  List chatMessagesList = [];
  var date;
  List chatUsersList = [];
  String? testing;
  List<String> friendsList = [];
  List friendListFbId = [];
  List chatIds = [];
  List LastMessages = [];
  String firebaseImageUrl = "";
  String firebaseRecordingUrl = "";
  List allBlockedUsers = [];
  List usersBlocked = [];
  String? unblockUserFbId;

  /// Pubnub
  PubNub? pubnub;
  String? otherPubNubUserId;
  Channel? myChannel;
  Subscription? subscribe;
  var channel;
  List chats = [];
  List<String> channels = [];
  String channelID = "";

  /// Payment
  String? paymentId = "";
  String? paymentType = "";
  String? amount = "";

  /// Feedback
  var feedBack = UserFeedback();
  TextEditingController feedbackTitle = TextEditingController();
  TextEditingController feedbackDescription = TextEditingController();

  /// Volunteer Events API
  var getVolunteerEvents = GetVolunteerEvents();
  List<EventsModel> volunteerEventsList = [];

  /// Getting Volunteer Events By Id
  var getVolunteerEventsByUserId = GetVolunteerEventsByUserId();
  List<VolunteerEventsModel> volunteerEventsByUserId = [];

  /// Getting The survey
  var getSurvey = GetSurvey();
  List<SurveyModel> allSurveys = [];
  List<SurveyQuestionsModel> currentSurveyQuestions = [];
  Question question = Question();
  List<SurveyQuestionsOfModel>? questions = [];
  AddSurveyService addSurveyService = AddSurveyService();
  SurveyModel? selectedSurvey;
  bool oneOptionChosen = false;

  /// Check Survey User
  var checkSurvey = CheckSurveyResult();
  bool surveyResponse = true;

  /// Get Multiple Users
  var multipleAppUsers = MultipleAppUsers();
  List<UserModel> chatUsers = [];
  List<UserModel> blockedUsers = [];

  /// Scrolling to end
  ScrollController myController = ScrollController();

  /// Record Audio
  bool isRecording = false;
  bool isPaused = false;
  int recordDuration = 0;
  Timer? timer;
  Timer? ampTimer;
  final audioRecorder = Record();
  String? sdPath;
  File? file;
  Amplitude? amplitude;
  bool recordPressed = false;

  /// bottom Navigation
  bool actionPressed = false;
  bool showButtons = false;

  /// share
  final Uri myUrl = Uri.parse(
      'https://drive.google.com/file/d/1z8B7Z7ACTaKca1z9K_5MYoWYwKzt6d2U/view?usp=sharing');

  /// For status
  var postTheStatus = PostStatus();

  // get eventsList => null;

  onEmojiSelected(Emoji emoji) {
    chatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.text.length));
  }

  onBackspacePressed() {
    chatController
      ..text = chatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: chatController.text.length));
  }

  void chatDispose() {
    chatController.dispose();
    super.dispose();
  }

  void checkAllQuestions(BuildContext context) {
    if (question1Done == false) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Answer all questions",
      ));
      return;
    }
    if (question2Done == false) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Please Answer all questions",
      ));
      return;
    }
    // if(question1Done == false && question2Done == false){
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Please Answer all questions",
    //   ));
    //   return;
    // }
    else {
      showSurveyDialog(context);
    }
  }

  void populateData() {
    for (int i = 0; i < 4; i++) questionsList.add(ListItem<String>("item $i"));
  }

  void onEnterCardNumberFocus() {
    if (enterCardNumberFocus.hasFocus) {
      isEnterCardNumberInFocus = true;
    } else {
      isEnterCardNumberInFocus = false;
    }
    notifyListeners();
  }

  void onEnterCardExpiryFocus() {
    if (enterCardExpiryFocus.hasFocus) {
      isEnterCardExpiryInFocus = true;
    } else {
      isEnterCardExpiryInFocus = false;
    }
    notifyListeners();
  }

  void onEnterCardCvvFocus() {
    if (enterCardCvvFocus.hasFocus) {
      isEnterCardCvvInFocus = true;
    } else {
      isEnterCardCvvInFocus = false;
    }
    notifyListeners();
  }

  void onEnterCardHoldNameFocus() {
    if (enterCardHolderFocus.hasFocus) {
      isEnterCardHolderInFocus = true;
    } else {
      isEnterCardHolderInFocus = false;
    }
    notifyListeners();
  }

  searchUserOnEmojiSelected(Emoji emoji) {
    searchUserChatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: searchUserChatController.text.length),
      );
  }

  searchUserOnBackspacePressed() {
    searchUserChatController
      ..text = searchUserChatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: searchUserChatController.text.length));
  }

  adminOnEmojiSelected(Emoji emoji) {
    adminChatController
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
        TextPosition(offset: adminChatController.text.length),
      );
  }

  adminOnBackspacePressed() {
    adminChatController
      ..text = adminChatController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: adminChatController.text.length));
  }

  void onSearchUserFocus() {
    if (searchUserFocus.hasFocus) {
      isSearchUserInFocus = true;
    } else {
      isSearchUserInFocus = false;
    }
    notifyListeners();
  }

  Future<bool> getImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _pickedFile = image;
    profileFileImage = File(_pickedFile!.path);
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  Future<bool> createEventGetImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _createEventPickedFile = image;
    createEventImage = File(_createEventPickedFile!.path);
    if (createEventImage == null) {
      return false;
    } else {
      bannerImageSelected = true;
      //createEventImages.add(createEventImage);
      notifyListeners();
      return true;
    }
  }

  Future<bool> myProfileGetImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    myProfilePickedFile = image;
    myProfileImage = File(myProfilePickedFile!.path);
    if (myProfileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
      // createEventImages.add(createEventImage);
      // notifyListeners();
      // return true;
    }
  }

  void selectCustomDate(BuildContext context) async {
    customDOB = await CommonFunctions.showDateOfBirthPicker(context, customDOB);
    notifyListeners();
  }

  Future<bool> openCamera() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.camera);
    _pickedFile = image;
    profileFileImage = File(_pickedFile!.path);
    if (profileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  verifyingForgetPassCode() async {
    verifyEmailCode = true;
    notifyListeners();
    var response = await verifyForgetPassCode.checkUser(
        forgotPasswordEmailController.text, emailCodeController.text);
    if (response == true) {
      verifyEmailCode = false;
      notifyListeners();
      navigationService.navigateToUntil(to: ResetPassword());
    } else if (response is String) {
      verifyEmailCode = false;
      notifyListeners();
      return showErrorMessage(response);
    }
  }

  /// For Signup

  Future getSignupVerificationCode() async {
    _auth.verifyPhoneNumber(
      phoneNumber: completeSignupPhoneNumber.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (error) async {
        showErrorMessage(
          error.code == "too-many-requests"
              ? "Your number has been blocked temporarily. Please try again later"
              : error.code == "invalid-phone-number"
                  ? "Enter a valid phone number"
                  : "An Error has occured.Please try again Later",
        );
        //showErrorMessage(error.message!,);
      },
      codeSent: (String verificationId, int? resendToken) {
        signupCodeVerificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void signupOtpStartTimer() {
    const oneSec = const Duration(seconds: 1);
    signupTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (SignupStart == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          SignupStart--;
          notifyListeners();
        }
      },
    );
  }

  void doingSignupVerification() {
    PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: signupCodeVerificationId!,
        smsCode: signupCodeController.text);
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((value) async {
      // var usersDetails = userModel.UserModel();
      // var userDetailsResponse = await userDetails.getUsersDetails(
      //     usersDetails, currentUserId!);
      // if (userDetailsResponse is userModel.UserModel) {
      //   userIdPref = currentUserId;
      //   countryCodePref = userDetailsResponse.country_code;
      //   emailPref = userDetailsResponse.email;
      //   phoneNoPref = userDetailsResponse.phone_no;
      //   fNamePref = userDetailsResponse.fname;
      //   genderPref = userDetailsResponse.gender;
      //   dobPref = userDetailsResponse.DOB;
      //   departmentPref = userDetailsResponse.department;
      //   provincePref = userDetailsResponse.province;
      //   districtPref = userDetailsResponse.district;
      //   createdDtmPref = userDetailsResponse.createdDtm;
      //   updatedDtmPref = userDetailsResponse.updatedDtm;
      //   profilePic = userDetailsResponse.ProfileImage;
      //   prefs!.setString("user", jsonEncode(userDetailsResponse));
      //   userModel.UserModel user = userModel.UserModel.fromJson(
      //       jsonDecode(prefs!.getString("user") ?? ""));
      //   prefs!.setString("userId", userIdPref!);
      //   prefs!.setString("countryCode", countryCodePref!);
      //   prefs!.setString("email", emailPref!);
      //   prefs!.setString("phone", phoneNoPref!);
      //   prefs!.setString("fName", fNamePref!);
      //   prefs!.setString("gender", genderPref!);
      //   prefs!.setString("dob", dobPref!);
      //   prefs!.setString("department", departmentPref!);
      //   prefs!.setString("province", provincePref!);
      //   prefs!.setString("district", districtPref!);
      //   prefs!.setString("createdDtm", createdDtmPref!);
      //   prefs!.setString("updatedDtm", updatedDtmPref!);
      //   prefs!.setString("profilePic", profilePic!);
      // }
      SharedPreferences? prefs = await SharedPreferences.getInstance();
      User users = _auth.currentUser!;
      loggedInFirebaseUserId = users.uid;
      prefs.setString("currentFbId", loggedInFirebaseUserId!);
      notifyListeners();
      navigationService.navigateToUntil(to: EnterDetails());
    }).catchError((error) {
      showErrorMessage("Please Enter correct Code");
    });
  }

  Future resendSignupCode() async {
    SignupStart = 30;
    signupOtpStartTimer();
    notifyListeners();
    signupCodeController.clear();
    _auth.verifyPhoneNumber(
      phoneNumber: completeSignupPhoneNumber.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (error) async {
        showErrorMessage(
          error.code == "too-many-requests"
              ? "Your number has been blocked temporarily. Please try again later"
              : error.code == "invalid-phone-number"
                  ? "Enter a valid phone number"
                  : "An Error has occured.Please try again Later",
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        signupCodeVerificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// For Login

  Future getLoginVerificationCode() async {
    _auth.verifyPhoneNumber(
      phoneNumber: completeLoginPhoneNumber.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (error) async {
        showErrorMessage(
          error.code == "too-many-requests"
              ? "Your number has been blocked temporarily. Please try again later"
              : error.code == "invalid-phone-number"
                  ? "Enter a valid phone number"
                  : "An Error has occured.Please try again Later",
        );
        //showErrorMessage(error.message!,);
      },
      codeSent: (String verificationId, int? resendToken) {
        loginCodeVerificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void loginOtpStartTimer() {
    const oneSec = const Duration(seconds: 1);
    loginTimer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (loginStart == 0) {
          timer.cancel();
          notifyListeners();
        } else {
          loginStart--;
          notifyListeners();
        }
      },
    );
  }

  void doingLoginVerification() {
    PhoneAuthCredential authCredential = PhoneAuthProvider.credential(
        verificationId: loginCodeVerificationId!,
        smsCode: loginCodeController.text);
    FirebaseAuth.instance
        .signInWithCredential(authCredential)
        .then((value) async {
      var usersDetails = userModel.UserModel();
      var userDetailsResponse =
          await userDetails.getUsersDetails(usersDetails, userId!);
      if (userDetailsResponse is userModel.UserModel) {
        userIdPref = userId;
        countryCodePref = userDetailsResponse.country_code;
        emailPref = userDetailsResponse.email;
        phoneNoPref = userDetailsResponse.phone_no;
        fNamePref = userDetailsResponse.fname;
        genderPref = userDetailsResponse.gender;
        dobPref = userDetailsResponse.DOB;
        departmentPref = userDetailsResponse.department;
        provincePref = userDetailsResponse.province;
        districtPref = userDetailsResponse.district;
        createdDtmPref = userDetailsResponse.createdDtm;
        updatedDtmPref = userDetailsResponse.updatedDtm;
        profilePic = userDetailsResponse.ProfileImage;
        prefs!.setString("user", jsonEncode(userDetailsResponse));
        userModel.UserModel user = userModel.UserModel.fromJson(
            jsonDecode(prefs!.getString("user") ?? ""));
        prefs!.setString("userId", userIdPref!);
        prefs!.setString("countryCode", countryCodePref!);
        prefs!.setString("email", emailPref!);
        prefs!.setString("phone", phoneNoPref!);
        prefs!.setString("fName", fNamePref!);
        prefs!.setString("gender", genderPref!);
        prefs!.setString("dob", dobPref!);
        prefs!.setString("department", departmentPref!);
        prefs!.setString("province", provincePref!);
        prefs!.setString("district", districtPref!);
        prefs!.setString("createdDtm", createdDtmPref!);
        prefs!.setString("updatedDtm", updatedDtmPref!);
        prefs!.setString("profilePic", profilePic!);
      }
      User users = _auth.currentUser!;
      loggedInFirebaseUserId = users.uid;
      prefs!.setString("currentFbId", loggedInFirebaseUserId!);
      notifyListeners();
      await uploadStatus(true);
      //await getUserData();
      navigationService.navigateToUntil(to: MainView(index: 0));
    }).catchError((error) {
      showErrorMessage("Please Enter correct Code");
    });
  }

  Future resendLoginCode() async {
    loginStart = 30;
    loginOtpStartTimer();
    notifyListeners();
    _auth.verifyPhoneNumber(
      phoneNumber: completeLoginPhoneNumber.text,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (error) async {
        showErrorMessage(
          error.code == "too-many-requests"
              ? "Your number has been blocked temporarily. Please try again later"
              : error.code == "invalid-phone-number"
                  ? "Enter a valid phone number"
                  : "An Error has occured.Please try again Later",
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        loginCodeVerificationId = verificationId;
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  /// Login Code Ends////////

  /// Check Signup

  signUpScreen() async {
    if (signupPhoneController.text.isEmpty) {
      showErrorMessage("Phone Number is Required");
    } else if (signupPhoneController.text.length < 9) {
      showErrorMessage("Please Enter Correct Phone Number");
    }

    /// Last Comments
    /*else if (signupEmailController.text.isEmpty) {
      showErrorMessage("Email is required");
    }
    else if (!signupEmailController.text.isEmail) {
      showErrorMessage("Email is invalid");
    }
    else if (signupPasswordController.text.isEmpty) {
      showErrorMessage("Password is required");
    }
    else if (signupPasswordController.text.length < 7) {
      showErrorMessage("Password must be at least 8 characters");
    }
    else if (!CommonFunctions.hasOneUpperCase(signupPasswordController.text.trim())){
      showErrorMessage("Password should contain at least one upper case");
    }
    else if (!CommonFunctions.hasOneLowerCase(signupPasswordController.text.trim())) {
      showErrorMessage("Password should contain at least one lower case");
    }
    else if (!CommonFunctions.hasOneDigit(signupPasswordController.text.trim())) {
      showErrorMessage("Password should contain at least one digit");
    }
    else if (!CommonFunctions.hasOneSpeicalCharacter(signupPasswordController.text.trim())) {
      showErrorMessage("Password should contain at least one special character");
    }*/
    else {
      checkUser = true;
      notifyListeners();
      var user = userModel.UserModel();
      var response = await logInTheUser.loginUser(
        user,
        signupCountryCode!,
        signupPhoneController.text,
      );
      if (response != null && response is userModel.UserModel) {
        checkUser = false;
        notifyListeners();
        return showErrorMessage("Phone Number already exists");
        navigationService.navigateTo(to: SignUpOTPScreen());
      } else if (response is String) {
        checkUser = false;
        notifyListeners();
        navigationService.navigateTo(to: SignUpOTPScreen());
        //return showErrorMessage("Phone Number already exists");
      }
    }
  }

  Future<bool> enterDetailsOpenCamera() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 75);
    enterDetailsPickedFile = image;
    enterDetailsProfileFileImage = File(enterDetailsPickedFile!.path);
    editProfileFileImage = enterDetailsProfileFileImage;
    enterDetailsProfilePic = enterDetailsProfileFileImage.toString();
    editProfilePic = enterDetailsProfilePic;
    notifyListeners();
    final bytes = (await enterDetailsPickedFile!.readAsBytes()).lengthInBytes;
    print(bytes);
    if (enterDetailsProfileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  Future<bool> enterDetailsGetImage() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 75);
    enterDetailsPickedFile = image;
    enterDetailsProfileFileImage = File(enterDetailsPickedFile!.path);
    editProfileFileImage = enterDetailsProfileFileImage;
    enterDetailsProfilePic = enterDetailsProfileFileImage.toString();
    editProfilePic = enterDetailsProfilePic;
    notifyListeners();
    if (enterDetailsProfileFileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
      // createEventImages.add(createEventImage);
      // notifyListeners();
      // return true;
    }
  }

  // getCurrentUserDetails() async {
  //   SharedPreferences? prefs = await SharedPreferences.getInstance();
  //   var usersDetails = userModel.UserModel();
  //   var userDetailsResponse = await userDetails.getUsersDetails(
  //       usersDetails, userId!);
  //   if (userDetailsResponse is userModel.UserModel) {
  //     userIdPref = userId;
  //     countryCodePref = userDetailsResponse.country_code;
  //     emailPref = userDetailsResponse.email;
  //     phoneNoPref = userDetailsResponse.phone_no;
  //     fNamePref = userDetailsResponse.fname;
  //     genderPref = userDetailsResponse.gender;
  //     dobPref = userDetailsResponse.DOB;
  //     departmentPref = userDetailsResponse.department;
  //     provincePref = userDetailsResponse.province;
  //     districtPref = userDetailsResponse.district;
  //     createdDtmPref = userDetailsResponse.createdDtm;
  //     updatedDtmPref = userDetailsResponse.updatedDtm;
  //     profilePic = userDetailsResponse.ProfileImage;
  //     prefs.setString("userId", userIdPref!);
  //     prefs.setString("countryCode", countryCodePref!);
  //     prefs.setString("email", emailPref!);
  //     prefs.setString("phone", phoneNoPref!);
  //     prefs.setString("fName", fNamePref!);
  //     prefs.setString("gender", genderPref!);
  //     prefs.setString("dob", dobPref!);
  //     prefs.setString("department", departmentPref!);
  //     prefs.setString("province", provincePref!);
  //     prefs.setString("district", districtPref!);
  //     prefs.setString("createdDtm", createdDtmPref!);
  //     prefs.setString("updatedDtm", updatedDtmPref!);
  //     prefs.setString("profilePic", profilePic!);
  //     getUserData();
  //   }
  // }

  signupWithDetails() async {
    if (enterDetailsNameController.text.isEmpty) {
      showErrorMessage("Full Name is required");
    } else if (enterDetailsEmailController.text.isEmpty) {
      showErrorMessage("Email is required");
    } else if (!enterDetailsEmailController.text.isEmail) {
      showErrorMessage("Please Enter Correct Email");
    } else if (dateOfBirthSelected == false) {
      showErrorMessage("Please select date of birth");
    } else if (selectedDOB.year > 2005) {
      showErrorMessage("Please Enter Correct Date of Birth");
    } else if (enterDetailsDepartSelected == false) {
      showErrorMessage("Please Select Department");
    } else if (enterDetailsProvinceSelected == false) {
      showErrorMessage("Please Select Province");
    } else if (enterDetailsProfileFileImage == null) {
      showErrorMessage("Please upload picture");
    } else if (enterDetailsDistrictSelected == false) {
      showErrorMessage("Please Select District");
    } else {
      addingDetails = true;
      notifyListeners();
      var user = userModel.UserModel();
      var signupResponse = await signIn.signupUser(
          user,
          signupCountryCode!.toString(),
          signupPhoneController.text,
          loggedInFirebaseUserId!);
      if (signupResponse != null && signupResponse is userModel.UserModel) {
        user.UserId = signupResponse.UserId;
        user.email = signupResponse.email;
        user.phone_no = signupResponse.phone_no;
        user.createdDtm = signupResponse.createdDtm;
        user.FirebaseUserId = signupResponse.FirebaseUserId;
        //signupEmailController.clear();
        //signupPasswordController.clear();
        var addDetailsResponse = await adduserDetails.addUserDetail(
            user.UserId!,
            enterDetailsNameController.text,
            detailsSelectGender!,
            selectedDOB.toString(),
            selectedDepart!,
            selectedProv!,
            selectedDist!,
            enterDetailsProfileFileImage ?? null,
            //.fromFile(enterDetailsProfileFileImage!.path,filename: basename(enterDetailsProfileFileImage!.path)):"",
            enterDetailsEmailController.text);
        if (addDetailsResponse == true) {
          var usersDetails = userModel.UserModel();
          var userDetailsResponse =
              await userDetails.getUsersDetails(usersDetails, user.UserId!);
          if (userDetailsResponse is userModel.UserModel) {
            userIdPref = userDetailsResponse.UserId;
            countryCodePref = userDetailsResponse.country_code;
            emailPref = userDetailsResponse.email;
            phoneNoPref = userDetailsResponse.phone_no;
            fNamePref = userDetailsResponse.fname;
            genderPref = userDetailsResponse.gender;
            dobPref = userDetailsResponse.DOB;
            departmentPref = userDetailsResponse.department;
            provincePref = userDetailsResponse.province;
            districtPref = userDetailsResponse.district;
            createdDtmPref = userDetailsResponse.createdDtm;
            updatedDtmPref = userDetailsResponse.updatedDtm;
            profilePic =
                userDetailsResponse.ProfileImage ?? ImageUtils.profilePicture;
            prefs = await SharedPreferences.getInstance();
            prefs!.setString("userId", userIdPref!);
            prefs!.setString("countryCode", countryCodePref!);
            prefs!.setString("email", emailPref!);
            prefs!.setString("phone", phoneNoPref!);
            prefs!.setString("fName", fNamePref!);
            prefs!.setString("gender", genderPref!);
            prefs!.setString("dob", dobPref!);
            prefs!.setString("department", departmentPref!);
            prefs!.setString("district", districtPref!);
            prefs!.setString("province", provincePref!);
            prefs!.setString("createdDtm", createdDtmPref!);
            prefs!.setString("updatedDtm", updatedDtmPref!);
            prefs!.setString("profilePic", profilePic!);
            signupPhoneController.clear();
            signupCountryCode = "";
          }
          addingDetails = false;
          getUserData();
          navigationService.navigateToUntil(to: MainView(index: 0));
        } else if (addDetailsResponse is String) {
          addingDetails = false;
          showErrorMessage(addDetailsResponse);
        }
      } else if (signupResponse is String) {
        addingDetails = false;
        showErrorMessage(signupResponse);
      }
    }
  }

  regionalDepartment() async {
    readyingAllDepartments = true;
    //notifyListeners();
    var response = await gettingAllTheDepartments.getDepartDetails();
    if (response != null && response is List<GetDepartmentsModel>)
      departList = response;
    allDepartmentsList = departList.map((e) => e.deptName!).toList();
    readyingAllDepartments = false;
    //notifyListeners();
  }

  regionalProvinces() async {
    readyingAllDepartments = true;
    //notifyListeners();
    var response = await gettingAllTheProvinces.getProvDetails();
    if (response != null && response is List<GetProvincesModel>)
      provinceList = response;
    allProvincesList = provinceList.map((e) => e.provinceName!).toList();
    readyingAllDepartments = false;
    //notifyListeners();
  }

  regionalDistricts() async {
    readyingAllDepartments = true;
    //notifyListeners();
    var response = await gettingAllTheDistricts.getDistDetails();
    if (response != null && response is List<GetDistrictsModel>)
      districtList = response;
    allDistrictsList = districtList.map((e) => e.districtName!).toList();
    readyingAllDepartments = false;
    //notifyListeners();
  }

  /// Signup Ends ///

  Future<bool> getProfilePic() async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);
    _profilePickedFile = image;
    userProfileImage = File(_profilePickedFile!.path);
    if (userProfileImage == null) {
      return false;
    } else {
      notifyListeners();
      return true;
    }
  }

  loginUser() async {
    if (completeLoginPhoneNumber.text.isEmpty) {
      showErrorMessage("Phone Number is Required");
    } else if (completeLoginPhoneNumber.text.length < 6) {
      showErrorMessage("Please Enter Correct Phone Number");
      return;
    } else {
      prefs = await SharedPreferences.getInstance();
      loggingIn = true;
      notifyListeners();
      var user = userModel.UserModel();
      var loginResponse = await logInTheUser.loginUser(
        user,
        loginCountryCode!,
        loginPhoneController.text,
      );
      if (loginResponse != null && loginResponse is userModel.UserModel) {
        userId = loginResponse.UserId;
        //notifyListeners();
        loggingIn = false;
        navigationService.navigateToUntil(to: LoginOTPScreen());
        notifyListeners();
      } else if (loginResponse is String) {
        showErrorMessage("Something went wrong");
        loggingIn = false;
        notifyListeners();
      }
    }
  }

  getUserData() async {
    prefs = await SharedPreferences.getInstance();
    //userModel.UserModel user = userModel.UserModel();
    userId = prefs!.getString("userId");
    country_code = prefs!.getString("countryCode");
    email = prefs!.getString("email");
    phoneNo = prefs!.getString("phone");
    fName = prefs!.getString("fName") ?? "";
    gender = prefs!.getString("gender") ?? "";
    dob = prefs!.getString(
      "dob",
    );
    getUserDepartment = prefs!.getString("department");
    getUserProvince = prefs!.getString("province");
    getUserDistrict = prefs!.getString("district");
    createdDtm = prefs!.getString("createdDtm");
    updatedDtm = prefs!.getString("updatedDtm");
    getUserprofilePic = prefs!.getString("profilePic");
    currentUserFbId = prefs!.getString("currentFbId");
    editProfileNameController.text = fName!;
    editProfileGender = gender;
    //editProfileSelectedDOB = selectedDOB;
    getEvents();
    notifyListeners();
  }

  removeData(BuildContext context) async {
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(child: Login(), type: PageTransitionType.fade),
        (route) => false);
    prefs = await SharedPreferences.getInstance();
    prefs!.remove("userId");
    prefs!.remove("email");
    prefs!.remove("phone");
    prefs!.remove("fName");
    prefs!.remove("gender");
    prefs!.remove("dob");
    prefs!.remove("department");
    prefs!.remove("province");
    prefs!.remove("createdDtm");
    prefs!.remove("updatedDtm");
    prefs!.remove("currentFbId");
    userId = "";
    email = "";
    phoneNo = "";
    fName = "";
    //gender = null;
    dob = null;
    getUserDepartment = "";
    getUserProvince = "";
    getUserDistrict = "";
    createdDtm = "";
    updatedDtm = "";
    getUserprofilePic = "";
    currentUserFbId = "";
    notifyListeners();
  }

  forgotPassword() async {
    checkingUserEmail = true;
    notifyListeners();
    if (forgotPasswordEmailController.text.isEmpty) {
      showErrorMessage("Email is Required");
      return;
    } else if (!forgotPasswordEmailController.text.isEmail) {
      showErrorMessage("Email is Invalid");
      return;
    } else {
      var response = await gettingUserEmail
          .forgetPasswordEmail(forgotPasswordEmailController.text);
      if (response == true) {
        checkingUserEmail = false;
        navigationService.navigateTo(to: CheckEmail());
      } else if (response is String) {
        checkingUserEmail = false;
        showErrorMessage(response);
      }
    }
  }

  resendEmailCode() async {
    checkingUserEmail = true;
    notifyListeners();
    var response = await gettingUserEmail
        .forgetPasswordEmail(forgotPasswordEmailController.text);
    if (response == true) {
      checkingUserEmail = false;
      notifyListeners();
    } else if (response is String) {
      checkingUserEmail = false;
      notifyListeners();
      showErrorMessage(response);
    }
  }

  resetNewPassword() async {
    if (resetNewPasswordController.text.isEmpty) {
      showErrorMessage("New Password is Required");
      return;
    } else if (resetNewPasswordController.text.length < 7) {
      showErrorMessage("New Password must be at least 8 characters");
      return;
    } else if (!CommonFunctions.hasOneUpperCase(
        resetNewPasswordController.text.trim())) {
      showErrorMessage("Password Should Contain at least one upper case ");
      return;
    } else if (!CommonFunctions.hasOneLowerCase(
        resetNewPasswordController.text.trim())) {
      showErrorMessage("Password Should Contain at least one lower case ");
      return;
    } else if (!CommonFunctions.hasOneDigit(
        resetNewPasswordController.text.trim())) {
      showErrorMessage("Password Should Contain at least one digit");
      return;
    } else if (!CommonFunctions.hasOneSpeicalCharacter(
        resetNewPasswordController.text.trim())) {
      showErrorMessage(
          "Password Should Contain at least one special character");
      return;
    } else if (resetConfirmNewPasswordController.text.isEmpty) {
      showErrorMessage("Confirm Password is Required");
      return;
    } else if (resetNewPasswordController.text !=
        resetConfirmNewPasswordController.text) {
      showErrorMessage("Passwords don't match");
      return;
    } else {
      resettingPassword = true;
      notifyListeners();
      var response = await resetThePassword.confirmPassword(
          forgotPasswordEmailController.text, resetNewPasswordController.text);
      if (response == true) {
        resettingPassword = false;
        notifyListeners();
        navigationService.navigateToUntil(to: Login());
      } else if (response is String) {
        settingNewPassword = false;
        notifyListeners();
        showErrorMessage(response);
      }
    }
  }

  void openAndSelectDob(BuildContext context) async {
    selectedDOB =
        await CommonFunctions.showDateOfBirthPicker(context, selectedDOB);
    editProfileSelectedDOB = selectedDOB;
    notifyListeners();
  }

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    notifyListeners();
  }

  void selectTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    selectedTime = (await showTimePicker(
      context: context,
      initialTime: initialTime,
    ))!;
  }

  showSurveyDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.only(bottom: 3.h, top: 2.h),
      insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.i))),
      title: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorUtils.blueColor,
            boxShadow: [
              BoxShadow(
                color: ColorUtils.blueColor,
                blurRadius: 4.0,
                spreadRadius: 0.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(ImageUtils.alertDialogCheck),
          )),
      content: Text(
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit sed do eiusmod tempor. ",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: FontUtils.avertaSemiBold,
          fontSize: 2.2.t,
          color: ColorUtils.darkBlue,
          height: 0.16.h,
        ),
      ),
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void donate(BuildContext context) {
    if (donateCardController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Card Number is Required",
      ));
      return;
    } else if (donateCardController.text.length != 20) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Enter Correct Card Number",
      ));
    } else if (donateCardExpiryController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Card Expiry is Required",
      ));
    }
    // else if (donateCardExpiryController.text.substring(0) != 0 || donateCardExpiryController.text.substring(0) != 1) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Enter Correct Expiry",
    //   ));
    // }
    // else if (int.parse(donateCardExpiryController.text.substring(3)) >=2 ) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Enter Correct Expiry",
    //   ));
    // }
    else if (donateCardCvvController.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Cvv is Required",
      ));
    } else if (enterAmount.text.isEmpty) {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Card Holder Name is Required",
      ));
    } else {
      showSurveyDialog(context);
    }
  }

  void createEvent(BuildContext context) async {
    if (eventTypeSelected == false) {
      showErrorMessage("Please Select Event");
      return;
    } else if (createEventName.text.isEmpty) {
      showErrorMessage("Event Name is Required");
      return;
    } else if (createEventDescription.text.isEmpty) {
      showErrorMessage("Event Description is Required");
      return;
    } else if (bannerImageSelected == false) {
      showErrorMessage("Banner Image is Required");
      return;
    } else if (eventDepartSelected == false) {
      showErrorMessage("Please Select Department");
      return;
    } else if (eventProvinceSelected == false) {
      showErrorMessage("Please Select Province");
      return;
    } else if (eventDistrictSelected == false) {
      showErrorMessage("Please Select District");
      return;
    }
    // else if (selectedEventType == "Fundraising" &&
    //     createEventCashController.text.isEmpty) {
    //   DialogUtils().showDialog(MyErrorWidget(
    //     error: "Enter Amount",
    //   ));
    //   return;
    // }
    else if (createEventLocation.text.isEmpty) {
      showErrorMessage("Please Enter Location");
      return;
    } else if (eventDateSelected == false) {
      showErrorMessage("Date is Required");
      return;
    } else if (selectedDate.year < DateTime.now().year &&
        selectedDate.month < DateTime.now().month &&
        selectedDate.day < DateTime.now().day) {
      showErrorMessage("Enter Correct Date");
      return;
    }
    // else if (selectedDate.month < DateTime
    //     .now()
    //     .month) {
    //   showErrorMessage("Enter Correct Date");
    //   return;
    // }
    // else if (selectedDate.day < DateTime
    //     .now()
    //     .day) {
    //   showErrorMessage("Enter Correct Date");
    //   return;
    // }
    else if (openingTimeFrom == openingTimeTo) {
      showErrorMessage("Enter Correct Time");
      return;
    } else {
      creatingEvent = true;

      notifyListeners();
      var createEventResponse = await createEventService.createEvent(
        userId!,
        selectedEvent!,
        createEventName.text,
        createEventDescription.text,
        eventSelectedDepart!,
        eventSelectedProv!,
        eventSelectedDist!,
        createEventLocation.text,
        selectedDate.toString(),
        openingTimeFrom!,
        openingTimeTo!,
        //
        // DateFormat('EEEE').format(DateFormat("MMMM").parse(openingTimeFrom!)),

        // DateFormat('EEEE').format(DateFormat("MMMM").parse(openingTimeFrom!)),

        // DateFormat('EEEE').format(DateTime(0,int.parse(openingTimeFrom!.split(' ')[0]))).toString(),

        //openingTimeFrom!,
        // DateFormat('EEEE').format(DateFormat("MMMM").parse(openingTimeTo!)),
        //DateFormat('EEEE').format(DateFormat("LLLL").parse(openingTimeTo!)),

        // DateFormat('EEEE').format(DateTime(0,int.parse(openingTimeFrom!.split(' ')[0]))).toString(),

        //openingTimeTo!,
        createEventImage,
        volunteerValue,
      );
      print(createEventResponse);
      if (createEventResponse == true) {
        creatingEvent = false;
        await showAlertDialog(context);
      } else if (createEventResponse is String) {
        creatingEvent = false;
        showErrorMessage(createEventResponse);
      }
      //showAlertDialog(context);
    }
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return ColorUtils.blueColor;
    }
    return ColorUtils.blueColor;
  }

  void didChangeDependencies(BuildContext context) {
    openingTimeFrom = TimeOfDay.now().format(context);
    openingTimeTo = TimeOfDay.now().format(context);
    // TODO: implement didChangeDependencies
  }

  void showErrorMessage(String error) async {
    errorMessage = error;
    notifyListeners();
    await Future.delayed(Duration(seconds: 3));
    errorMessage = null;
    notifyListeners();
  }

  Future<void> showAlertDialog(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.only(bottom: 3.h, top: 2.h),
            insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.i))),
            title: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.blueColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.blueColor,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(ImageUtils.alertDialogCheck),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Event Created",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontUtils.avertaSemiBold,
                    fontSize: 2.2.t,
                    color: ColorUtils.darkText,
                    height: 0.16.h,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          );
        })) {
      case null:
        getEvents();
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: MainView(
                  index: 0,
                ),
                type: PageTransitionType.fade),
            (route) => false);
        selectedEvent = null;
        createEventName.clear();
        createEventDescription.clear();
        createEventImage = null;
        bannerImageSelected = false;
        selectedDepart = null;
        selectedProv = null;
        selectedDist = null;
        createEventLocation.clear();
        selectedDate = DateTime.now();
        openingTimeFrom = TimeOfDay.now().format(context);
        openingTimeTo = TimeOfDay.now().format(context);
        notifyListeners();
        // dialog dismissed
        break;
    }
  }

  getEvents() async {
    isLoading = true;
    //notifyListeners();
    var response = await getAllEvents.getAllEventsDetails();
    // dynamic response = await getAllEvents.getAllEventsDetails();
    print(response);
    if (response is List<EventsModel>) {
      upComingeventsList = response;
    } else if (response is String) {
      upComingeventsList = [];
      showErrorMessage(response.toString());
    }
    isLoading = false;
    notifyListeners();
  }

  eventLocation() async {
    var googlePlace = GooglePlace(Constants.kGoogleApiKey);
    risult = await googlePlace.autocomplete.get(createEventLocation.text);
    places = risult!.predictions!.map((e) => e.description).toList();
    print(places);
    notifyListeners();
  }

  attendingTheEvent(String Id, String fname, int index) async {
    attendingTheEvents = true;
    notifyListeners();
    var response = await attendEvent.attendingTheEvents(userId!, fname, Id);
    print(response);
    if (response == true) {
      //eventsList = response;
      attendingEvent = true;
      justAdded = true;
      notifyListeners();
      // await gettingAttendeeDetails(eventId, index);
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response.toString());
    }
    attendingTheEvents = false;
    justAdded = false;
    notifyListeners();
  }

  attenddEvent(BuildContext context) async {
    var attenddEventResponse =
        await attendEvent.attendingTheEvents(userId!, fName!, Id!);
    print(attenddEventResponse);
  }

  // gettingAttendeeDetails(String eventId, int index) async {
  gettingAttendeeDetails(String Id, int index) async {
    isLoading = true;
    notifyListeners();
    attendeesUserId = [];
    attendeesDetails = [];
    //attendeeLength = 0;
    containsId = false;
    var attendeeModel = AttendeeModel();
    var response = await getAttendee.getAllEventsDetails(
        // attendeeModel, eventId);
        attendeeModel,
        Id);

    //
    // if(response == null){
    //   navigationService.navigateTo(to: ErrorCheck());
    // }

    if (response is String) {
      navigationService.navigateTo(
        to: EventDetails(index: index),
      );
      attendeeLength = 0;
      isLoading = false;
      notifyListeners();
    } else {
      attendeesUserId = response.map((e) => e.UserId).toList();
      // response.removeWhere((element) => element.UserId == userId! );
      response.removeWhere((element) => element.UserId == userId);
      attendeesDetails = response;
      //attendeesDetails.removeWhere((element) => element.UserId == userId);
      attendeeLength = response.length;
      attendeesProfilePics = response.map((e) => e.ProfileImage).toList();
      notifyListeners();
      if (attendeesUserId!.contains(userId)) {
        containsId = true;
        attendeeLength = response.length;
        if (justAdded == false) {
          navigationService.navigateTo(to: EventDetails(index: index));
        }
        notifyListeners();
      } else {
        navigationService.navigateTo(to: EventDetails(index: index));
      }
      isLoading = false;
      notifyListeners();
    }
  }

  gettingVolunteerAttendeeDetails(
      // String eventId,
      String Id,
      int index) async {
    isLoading = true;
    notifyListeners();
    voluntreesUserId = [];
    voluntreeDetails = [];
    voluntreeLength = 0;
    volunteerContainsId = false;
    var attendeeModel = AttendeeModel();
    var response = await getVoluntree.getAllVoluntreeDetails(
        attendeeModel,
        // eventId
        Id);
    print(response);
    if (response is String) {
      navigationService.navigateTo(
          to: VolunteerDetails(
        index: index,
        eventId: volunteerEventsList[index].id,
        // eventId: volunteerEventsList[index].eventId,
        // EventId: volunteerEventsList[index].eventId,
        // Id: volunteerEventsList[index].Id,
        eventName: volunteerEventsList[index].eventName,
        userId: volunteerEventsList[index].UserId,
        volunteerList: [],
      ));
      voluntreeLength = 0;
      isLoading = false;
      notifyListeners();
    } else {
      voluntreesUserId = response.map((e) => e.UserId).toList();
      voluntreeDetails = response;
      //attendeesDetails.removeWhere((element) => element.UserId == userId);
      voluntreeLength = response.length;
      voluntreesProfilePics = response.map((e) => e.ProfileImage).toList();
      notifyListeners();
      if (voluntreesUserId!.contains(userId)) {
        volunteerContainsId = true;
        voluntreeLength = response.length;
        if (volunteerJustAdded == false) {
          navigationService.navigateTo(
              to: VolunteerDetails(
            index: index,
            eventId: volunteerEventsList[index].id,
            // eventId: volunteerEventsList[index].eventId,
            // EventId: volunteerEventsList[index].eventId,
            // Id: volunteerEventsList[index].Id,
            // EventId: volunteerEventsList[index].Id,
            eventName: volunteerEventsList[index].eventName,
            userId: volunteerEventsList[index].UserId,
            volunteerList: [],
          ));
        }
        notifyListeners();
      } else {
        navigationService.navigateTo(
            to: VolunteerDetails(
          index: index,
          eventId: volunteerEventsList[index].id,
          // eventId: volunteerEventsList[index].eventId,
          // EventId: volunteerEventsList[index].eventId,
          // Id: volunteerEventsList[index].Id,
          // EventId: volunteerEventsList[index].Id,
          eventName: volunteerEventsList[index].eventName,
          userId: volunteerEventsList[index].UserId,
          volunteerList: [],
        ));
      }
      isLoading = false;
      notifyListeners();
    }
  }

  myEvents() async {
    isLoading = true;
    myEventsList = [];
    //notifyListeners();
    var eventsModel = EventsModel();
    var response =
        await gettingTheEvents.getMyEventsDetails(eventsModel, userId!);
    if (response is List<EventsModel>) {
      myTotalEvents = response.length;
      myEventsList = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  // numberOfAttendee(String eventId, int index) async {
  numberOfAttendee(String Id, int index) async {
    isLoading = true;
    notifyListeners();
    var attendeeModel = AttendeeModel();
    var response = await getAttendee.getAllEventsDetails(
        // attendeeModel, eventId);
        attendeeModel,
        Id);
    if (response is String) {
      totalAttendee = 0;
    } else {
      totalAttendee = response.length;
    }
    isLoading = false;
    notifyListeners();
  }

  eventsByTheUser() async {
    isLoading = true;
    //gettingEventsByUser = true;
    //notifyListeners();
    var attendeeModel = AttendeeModel();
    var response = await getAttendingEvents.getAttendingEventsDetails(
        attendeeModel, userId!);
    if (response is List<MyAttendeeModel>) {
      myAttendingEventsList = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  deletingTheEvent(
      // String EventId
      String id
      ) async {
    isLoading = true;
    // isloading1 = true;
    notifyListeners();
    var response = await deleteTheEvent.deleteEvent(
        // EventId,
        id,
        userId!
    );
    // if (response is String) {
    //   //await getEvents();
    //   // isLoading = false;
    //   isloading1 = false;
    //   notifyListeners();
    //   navigationService.navigateToUntil(
    //       to: MainView(
    //     index: 0,
    //   ));
    // }

    if (response is String) {
      navigationService.navigateTo(
          to: MainView(
            index: 0,
          ));
      isLoading = false;
      notifyListeners();
    }

    else {
      showErrorMessage(response);
    }
  }

  //
  deletingTheEvent1(){

  }

  updatingTheUserDetails(BuildContext context) async {
    if (editProfileSelectedDOB.year > 2005) {
      showErrorMessage("Please Enter Correct Date of Birth");
    } else {
      isLoading = true;
      notifyListeners();
      editProfileSelectedDepart = getUserDepartment!;
      editProfileSelectedProv = getUserProvince!;
      editProfileSelectedDist = getUserDistrict!;
      notifyListeners();
      var response = await updateUserDetails.updateDetail(
        userId!,
        editProfileNameController.text,
        editProfileGender!,
        editProfileSelectedDOB.toString(),
        editProfileSelectedDepart!,
        editProfileSelectedProv!,
        editProfileSelectedDist!,
        editProfileFileImage,
        //getUserprofilePic!,
      );
      if (response != null && response is userModel.UserModel) {
        userIdPref = userId;
        countryCodePref = response.country_code;
        emailPref = response.email;
        phoneNoPref = response.phone_no;
        fNamePref = response.fname;
        genderPref = response.gender;
        dobPref = response.DOB;
        departmentPref = response.department;
        provincePref = response.province;
        districtPref = response.district;
        createdDtmPref = response.createdDtm;
        updatedDtmPref = response.updatedDtm;
        profilePic = response.ProfileImage;
        prefs!.setString("user", jsonEncode(response));
        // userModel.UserModel user = userModel.UserModel.fromJson(
        //     jsonDecode(prefs!.getString("user") ?? ""));
        prefs!.setString("userId", userIdPref!);
        prefs!.setString("countryCode", countryCodePref!);
        prefs!.setString("email", emailPref!);
        prefs!.setString("phone", phoneNoPref!);
        prefs!.setString("fName", fNamePref!);
        prefs!.setString("gender", genderPref!);
        prefs!.setString("dob", dobPref!);
        prefs!.setString("department", departmentPref!);
        prefs!.setString("province", provincePref!);
        prefs!.setString("district", districtPref!);
        prefs!.setString("createdDtm", createdDtmPref!);
        prefs!.setString("updatedDtm", updatedDtmPref!);
        prefs!.setString("profilePic", profilePic!);

        // SharedPreferences? prefs = await SharedPreferences.getInstance();
        // prefs.remove("userId");
        // prefs.remove("email");
        // prefs.remove("phone");
        // prefs.remove("fName");
        // prefs.remove("gender");
        // prefs.remove("dob");
        // prefs.remove("department");
        // prefs.remove("province");
        // prefs.remove("createdDtm");
        // prefs.remove("updatedDtm");
        // userId = "";
        // email = "";
        // phoneNo = "";
        // fName = "";
        // //gender = null;
        // dob = null;
        // getUserDepartment = "";
        // getUserProvince = "";
        // getUserDistrict = "";
        // createdDtm = "";
        // updatedDtm = "";
        // getUserprofilePic = "";
        notifyListeners();

        //await getCurrentUserDetails();
        //getUserData();
        //print(response);
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: MainView(
                  index: 0,
                ),
                type: PageTransitionType.fade),
            (route) => false);
        isLoading = false;
        notifyListeners();
      } else if (response is String) {
        print(response);
        isLoading = false;
        notifyListeners();
      }
    }
  }

  gettingNearByEvents() async {
    isLoading = true;
    nearByList = [];
    //notifyListeners();
    var eventsModel = EventsModel();
    var response = await nearByEvents.getNearByEventsDetails(
        eventsModel, userId!, getUserDistrict!);
    if (response is List<EventsModel>) {
      totalNearByList = response.length;
      // response.removeWhere((element) => int.parse(element.eventDate!.substring(5,6)) < dateTime.month );
      response.removeWhere((element) =>
          int.parse(element.eventDate!.split(' ')[0].substring(5, 6)) <
          dateTime.month);

      nearByList = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  void itemChange(bool val, int index) {
    checkBoxListTileModel[index].isCheck = val;
    titleValue = checkBoxListTileModel[index].title;
    notifyListeners();
  }

  showVolunteerDialog(
      BuildContext context,
      String eventId,
      // String EventId,
      String eventName) {
    Widget okButton = TextButton(
      child: Column(
        children: [
          Center(
            child: Container(
              //margin: EdgeInsets.symmetric(horizontal: 5.w),
              width: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                color: ColorUtils.blueColor,
                shape: BoxShape.rectangle,
                border: Border.all(color: ColorUtils.blueColor),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                child: Text(
                  "Volunteer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontUtils.avertaSemiBold,
                    fontSize: 2.0.t,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
      onPressed: () async {
        if (selectedJob.length != 0) {
          await volunteeringTheEvents(
            eventId,
            // EventId,
            selectedJob.join(","),
            eventName,
          );
          Navigator.pop(context);
          //selectedJob.remove(selectedJob.length);
          //navigationService.navigateToUntil(to: MainView(index: 0,));
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                  child: MainView(
                    index: 0,
                  ),
                  type: PageTransitionType.fade),
              (route) => false);
        } else {
          Navigator.pop(context);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.i))),
      title: Column(
        children: [
          Container(
            child: Text(
              "Volunteer As",
              style: TextStyle(
                fontFamily: FontUtils.avertaSemiBold,
                fontSize: 2.2.t,
                color: ColorUtils.blueColor,
              ),
            ),
          ),
          SizedBox(
            height: 2.5.h,
          ),
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus varius dictum cursus.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: FontUtils.modernistRegular,
              fontSize: 1.8.t,
              color: ColorUtils.darkText,
            ),
          ),
        ],
      ),
      content: Container(
        //height: 20.h,
        width: 20.w,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: checkBoxListTileModel.length,
          itemBuilder: (context, index) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      activeColor: ColorUtils.blueColor,
                      value: checkBoxListTileModel[index].isCheck,
                      shape: CircleBorder(),
                      onChanged: (bool? val) {
                        setState(() {
                          itemChange(
                            val!,
                            index,
                          );
                          if (!selectedJob.contains(titleValue)) {
                            selectedJob
                                .add(checkBoxListTileModel[index].title!);
                            notifyListeners();
                          } else if (selectedJob.contains(titleValue)) {
                            selectedJob
                                .remove(checkBoxListTileModel[index].title!);
                            notifyListeners();
                          }
                        });
                        notifyListeners();
                      },
                    ),
                    Text(
                      checkBoxListTileModel[index].title!,
                      style: TextStyle(
                          fontFamily: FontUtils.modernistRegular,
                          fontSize: 1.8.t,
                          color: ColorUtils.darkText),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
      // Text(
      //   "Are you sure you want to remove yourself from volunteering?",
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     fontFamily: FontUtils.avertaSemiBold,
      //     fontSize: 2.2.t,
      //     color: ColorUtils.blueColor,
      //     height: 0.16.h,
      //   ),
      // ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  volunteerConfirmationDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      //margin: EdgeInsets.symmetric(horizontal: 5.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        border: Border.all(color: ColorUtils.blueColor),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.5.h),
                        child: Text(
                          "No",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FontUtils.avertaSemiBold,
                            fontSize: 1.8.t,
                            color: ColorUtils.blueColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 6.w,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      //margin: EdgeInsets.symmetric(horizontal: 5.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorUtils.blueColor,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.5.h),
                        child: Text(
                          "Yes",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FontUtils.avertaSemiBold,
                            fontSize: 1.8.t,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.i))),
      title: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ColorUtils.blueColor,
            boxShadow: [
              BoxShadow(
                color: ColorUtils.blueColor,
                blurRadius: 4.0,
                spreadRadius: 0.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(ImageUtils.alertDialogExclaim),
          )),
      content: Text(
        "Are you sure you want to remove yourself from volunteering?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: FontUtils.avertaSemiBold,
          fontSize: 2.2.t,
          color: ColorUtils.blueColor,
          height: 0.16.h,
        ),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  volunteeringTheEvents(
      String eventId,
      // String EventId,
      String volunteeringJobs,
      String eventName) async {
    isLoading = true;
    selectedJob = [];
    //notifyListeners();
    //var eventsModel = EventsModel();
    var response = await addVolunteer.volunteerTheEvent(
        userId!,
        eventId,
        // EventId,
        volunteeringJobs,
        eventName);
    if (response == true) {
      print(response);
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  allSearchedEvents(String keyword) async {
    //isLoading = true;
    //notifyListeners();
    //var eventsModel = EventsModel();
    allSearchedEventsList = [];
    peopleButtonPressed = false;
    eventButtonPressed = false;
    districtsRadioSelected = false;
    districtSearchController.clear();
    notifyListeners();
    var response = await allSearch.keywordEvents(keyword);
    if (response is List<EventsModel>) {
      allSearchedEventsList = response;
      print(response);
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  dateEvents(BuildContext context) async {
    searchEventsController.clear();
    isLoading = true;
    searchedDateEvents = [];
    allSearchedEventsList = [];
    notifyListeners();
    //var eventsModel = EventsModel();
    var response =
        await searchDateEvents.dateEvents(customDateValue.toString());
    if (response is List<EventsModel>) {
      searchedDateEvents = response;
      doneDatePressed = true;
      //navigationService.navigateTo(to: SearchEvents());
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  Future selectDateForCustomEvents(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: customDateValue,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != customDateValue) customDateValue = picked;
    Navigator.pop(context);
    await dateEvents(context);
    //  searchEventsController.clear();
    //doneDatePressed = false;
    notifyListeners();
  }

  filteringTheEventsByLocation(String type) async {
    isLoading = true;
    notifyListeners();
    filteredEventsWithLocation = [];
    //var eventsModel = EventsModel();
    var response = await searchEventsByFilter.filterSearchedEvents(
        type, changeLocationDist ?? getUserDistrict!);
    if (response is List<EventsModel>) {
      filteredEventsWithLocation = response;
      navigationService.navigateTo(to: SearchedEventsByLocation());
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      //showErrorMessage(response);
      navigationService.navigateTo(to: SearchedEventsByLocation());
      isLoading = false;
      notifyListeners();
    }
  }

  allSearchedUsers(String keyword) async {
    //isLoading = true;
    //notifyListeners();
    //var eventsModel = EventsModel();
    eventButtonPressed = false;
    districtsRadioSelected = false;
    doneDatePressed = false;
    notifyListeners();
    var response = await allSearchedPeople.peopleSearch(keyword);
    print(response);
    if (response is List<UserModel>) {
      allSearchedPeopleList = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  searchingPeopleByDistrict(String district, BuildContext context) async {
    //isLoading = true;
    //notifyListeners();
    //var eventsModel = EventsModel();
    allSearchedPeopleList = [];
    allSearchedDistrictPeople = [];
    peopleButtonPressed = false;
    doneDatePressed = false;
    searchEventsController.clear();
    notifyListeners();
    var response = await searchUsersByDistrict.filterSearchedEvents(district);
    print(response);
    if (response is List<UserModel>) {
      allSearchedDistrictPeople = response;
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
      Navigator.pop(context);
    }
  }

  gettingTheNewsFeed() async {
    isLoading = true;
    newsFeedList = [];
    //notifyListeners();
    var newsFeedModel = NewsFeedModel();
    var response = await newsFeed.gettingNewsFeed(newsFeedModel);
    if (response is List<NewsFeedModel>) {
      newsFeedList = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      showErrorMessage(response);
      isLoading = false;
      notifyListeners();
    }
  }

  pubnubMethod() {
    pubnub = PubNub(
        defaultKeyset: Keyset(
            subscribeKey: 'sub-c-e7663ff0-8d6f-11ec-b19d-ca42df2d7d16',
            publishKey: 'pub-c-826490e3-4c69-4266-acd8-833431c8f659',
            uuid: UUID(userId!)));
    //pubnubObj = PubNub(defaultKeyset: pubnub);
    //notifyListeners();
  }

  channeling() async {
    chats = [];
    myChannel = pubnub!.channel(channelID);
    var chat = await myChannel!.messages();
    //var data = await chat.count();
    await chat.fetch().whenComplete(() {
      print(chat.messages.length);
      for (var data in chat.messages) {
        chats.add(data.content);
      }
      notifyListeners();
    });
  }

  subscribeChannel() {
    subscribe = pubnub!.subscribe(
        channels: {channelID},
        keyset: Keyset(
            subscribeKey: 'sub-c-e7663ff0-8d6f-11ec-b19d-ca42df2d7d16',
            publishKey: 'pub-c-826490e3-4c69-4266-acd8-833431c8f659',
            uuid: UUID(userId!)));

    subscribe!.messages.listen((message) async {
      chats.add(message.content);
      notifyListeners();
    });
    //notifyListeners();
  }

  Future getChannels() async {
    Dio dio = Dio();
    dio
        .get(
            "https://ps.pndsn.com/v2/presence/sub-key/sub-c-e7663ff0-8d6f-11ec-b19d-ca42df2d7d16/uuid/${userId!}")
        .then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        channels = (jsonDecode(value.data)["payload"]["channels"] as List)
            .map((e) => e.toString())
            .toList();
        print(channels);
      }
    }).catchError((error) {});
    //List channels = pubnub!;
    //print(channels);
  }

  donation() async {
    if (enterAmount.text.isEmpty) {
      showErrorMessage("Enter The Amount Please");
    } else {
      /// retrieve data from the backend
      //final paymentSheetData = backend.fetchPaymentSheetData();

      //PaymentIntent intent = await Stripe.instance.retrievePaymentIntent("sk_test_51IQXHbC8nlB3iOSQsJ81juTtiMefwnY3PUH6lid4wQLg3iNo2F4jQ6e7Nnr48puIAn9WFtoZCV5Jg3x4TT9ogpVp00wcRPWNXd");
      await Dio()
          .post("https://api.stripe.com/v1/payment_intents",
              data: {
                "amount": int.parse(enterAmount.text + "00"),
                "currency": "sek",
              },
              options: Options(headers: {
                "Authorization":
                    "Bearer sk_test_51IQXHbC8nlB3iOSQsJ81juTtiMefwnY3PUH6lid4wQLg3iNo2F4jQ6e7Nnr48puIAn9WFtoZCV5Jg3x4TT9ogpVp00wcRPWNXd"
              }, contentType: "application/x-www-form-urlencoded"))
          .then((value) async {
        print(value);
        String clientSecret = value.data["client_secret"];
        await Stripe.instance.initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
          applePay: false,
          googlePay: false,
          style: ThemeMode.dark,
          testEnv: false,
          //setupIntentClientSecret: "sk_test_51IQXHbC8nlB3iOSQsJ81juTtiMefwnY3PUH6lid4wQLg3iNo2F4jQ6e7Nnr48puIAn9WFtoZCV5Jg3x4TT9ogpVp00wcRPWNXd",
          merchantCountryCode: 'SE',
          merchantDisplayName: 'Flutter Stripe Store Demo',
          customerId: userId,
          //_paymentSheetData!['customer'],
          paymentIntentClientSecret: clientSecret,
          //_paymentSheetData!['paymentIntent'],
          //customerEphemeralKeySecret: "12",
          //_paymentSheetData!['ephemeralKey'],
        ));

        await Stripe.instance.presentPaymentSheet().then((value) async {
          await Stripe.instance
              .retrievePaymentIntent(clientSecret)
              .then((intent) {
            //print(value);
            DonateAPI paymentAPI = DonateAPI();
            paymentAPI.doDonation(
              userId!,
              fName!,
              enterAmount.text,
              //intent.amount.toString()
            );
            //return value;
          }).catchError((error) {
            print(error);
          });
          // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          // await sharedPreferences.setString('paymentId', paymentId!);
          // await sharedPreferences.setString('paymentType', paymentType!);
          // await sharedPreferences.setString('amount', amount!);
        }).catchError((error) {
          print(error);
        });
      }).catchError((error) {
        print(error);
      });
    }
  }

  feedBacks(BuildContext context) async {
    if (feedbackTitle.text.isEmpty) {
      showErrorMessage("Title is required");
    } else if (feedbackDescription.text.isEmpty) {
      showErrorMessage("Description is required");
    } else {
      isLoading = true;
      notifyListeners();
      var response = await feedBack.usersFeedBack(
          userId!, feedbackTitle.text, feedbackDescription.text);
      if (response == true) {
        //creatingEvent = false;
        isLoading = false;
        notifyListeners();
        await showFeedbackDialog(context);
      } else if (response is String) {
        //creatingEvent = false;
        isLoading = false;
        notifyListeners();
        showErrorMessage(response);
      }
    }
  }

  Future<void> showFeedbackDialog(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.only(bottom: 3.h, top: 2.h),
            insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.i))),
            title: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.blueColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.blueColor,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(ImageUtils.alertDialogCheck),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Your feedback has been submitted successfully",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontUtils.avertaSemiBold,
                    fontSize: 2.2.t,
                    color: ColorUtils.darkText,
                    height: 0.16.h,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          );
        })) {
      case null:
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: MainView(
                  index: 0,
                ),
                type: PageTransitionType.fade),
            (route) => false);
        // dialog dismissed
        break;
    }
  }

  getAllVolunteerEvents() async {
    volunteerEventsList = [];
    isLoading = true;
    //notifyListeners();
    var response = await getVolunteerEvents.getAllVolunteerEventsDetails();
    if (response is List<EventsModel>) {
      volunteerEventsList = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      volunteerEventsList = [];
      showErrorMessage(response.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  volunteeringEventsById() async {
    volunteerEventsByUserId = [];
    isLoading = true;
    //notifyListeners();
    var response =
        await getVolunteerEventsByUserId.getAllVolunteerEventsByUserId(userId!);
    if (response is List<VolunteerEventsModel>) {
      volunteerEventsByUserId = response;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      volunteerEventsByUserId = [];
      showErrorMessage(response.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  getTheSurvey() async {
    allSurveys = [];
    isLoading = true;
    //notifyListeners();
    var response = await getSurvey.getSurveyQuestions();
    if (response is List<SurveyModel>) {
      allSurveys = response;
      //currentSurveyQuestions =  selectedSurvey!.Questions!;
      isLoading = false;
      notifyListeners();
    } else if (response is String) {
      allSurveys = [];
      DialogUtils().showDialog(MyErrorWidget(
        error: "Something Went Wrong",
      ));
      //showErrorMessage(response.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  questionData(BuildContext context) async {
    // print(questions!.map((e) => {
    //   "QuestionId" : e.QuestionId,
    //   "UserId" : e.UserId,
    //   "SurveyId" : e.SurveyId,
    //   "Answer" : e.Answer,
    // }));
    isLoading = true;
    notifyListeners();
    var response = await addSurveyService.addSurveyDetail(questions!);
    if (response == true) {
      await showSurveyCompletionDialog(context);
      isLoading = false;
      notifyListeners();
    } else {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Something Went Wrong",
      ));
      isLoading = false;
      notifyListeners();
    }
  }

  checkSurveyUser(BuildContext context, String surveyId, String title) async {
    isLoading = true;
    //notifyListeners();
    var response = await checkSurvey.checkSurvey(userId!, surveyId);
    if (response == true) {
      //surveyResponse = true;
      navigationService.navigateTo(
          to: SurveyPreview(
        title: title,
      ));
      // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SurveyPreview(
      //   title: title,
      // )));
      isLoading = false;
      notifyListeners();
    } else if (response == "Survey result already added ") {
      surveyResponse = false;
      DialogUtils().showDialog(MyErrorWidget(
        error: response,
      ));
      isLoading = false;
      notifyListeners();
    } else if (response is String &&
        response != "Survey result already added ") {
      DialogUtils().showDialog(MyErrorWidget(
        error: "Some thing went wrong",
      ));
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> showSurveyCompletionDialog(BuildContext context) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            contentPadding: EdgeInsets.only(bottom: 3.h, top: 2.h),
            insetPadding: EdgeInsets.symmetric(horizontal: 4.w),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(3.i))),
            title: Column(
              children: [
                Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.blueColor,
                      boxShadow: [
                        BoxShadow(
                          color: ColorUtils.blueColor,
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SvgPicture.asset(ImageUtils.alertDialogCheck),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  "Survey Completed",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: FontUtils.avertaSemiBold,
                    fontSize: 2.2.t,
                    color: ColorUtils.darkText,
                    height: 0.16.h,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          );
        })) {
      case null:
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
                child: MainView(
                  index: 0,
                ),
                type: PageTransitionType.fade),
            (route) => false);
        // dialog dismissed
        break;
    }
  }

  fireChat(String attendeeFbId, String otherUserId) {
    firebaseChat.onChatPressed(attendeeFbId, otherUserId);
  }

  loadingAllChat(String attendeeFbId) {
    firebaseChat.loadChat(attendeeFbId);
  }

  gettingFriendsIds() async {
    await firebaseChat.friendList();
  }

  gettingAllChatUsers() async {
    isLoading = true;
    //notifyListeners();
    var user = userModel.UserModel();
    if (friendsList.length != 0) {
      var response = await multipleAppUsers.chatsUsers(friendsList, user);
      if (response is List<UserModel>) {
        //surveyResponse = true;
        chatUsers = response.reversed.toList();
        for (final e in allBlockedUsers) {
          chatUsers.removeWhere((element) => element.FirebaseUserId == e[0]);
          notifyListeners();
        }
        var myList = [];
        myList = chatUsers.map((e) => e.FirebaseUserId).toList();
        //myList.add(chatUsers.map((e) => e.FirebaseUserId).toList());
        print(myList);
        for (var e in myList) {
          loadingAllChat(e);
          print(chatMessagesList.last);
          //print(chatMessagesList[index]["content"]);
        }
        // if(chatUsers.any((myElement) => allBlockedUsers.contains(myElement))){
        //   return chatUsers;
        // }
        //chatUsers.removeWhere((element) => element.FirebaseUserId == allBlockedUsers);
        // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SurveyPreview(
        //   title: title,
        // )));
        isLoading = false;
        notifyListeners();
      } else if (response is String) {
        DialogUtils().showDialog(MyErrorWidget(
          error: "Some thing went wrong",
        ));
        isLoading = false;
        notifyListeners();
      }
    }
    isLoading = false;
    notifyListeners();
  }

  blockingUsers(String attendeeFbId, String otherUsersFbId) async {
    await firebaseChat.blockUser(attendeeFbId, otherUsersFbId);
    navigationService.navigateTo(to: MainView(index: 1));
  }

  Future<bool> chatOpenCamera(String attendeeFbId, String otherUserId) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 75);
    chatPickedFile = image;
    chatImage = File(chatPickedFile!.path);
    // editProfileFileImage = enterDetailsProfileFileImage;
    chatPic = chatImage.toString();
    // editProfilePic = enterDetailsProfilePic;
    notifyListeners();
    // final bytes = (await enterDetailsPickedFile!.readAsBytes()).lengthInBytes;
    // print(bytes);
    if (chatPic == null) {
      return false;
    } else {
      await firebaseChat.uploadPic(attendeeFbId, otherUserId);
      notifyListeners();
      return true;
    }
  }

  Future<bool> chatGetImage(String attendeeFbId, String otherUserId) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 75);
    chatPickedFile = image;
    chatImage = File(chatPickedFile!.path);
    // editProfileFileImage = enterDetailsProfileFileImage;
    chatPic = chatImage.toString();
    notifyListeners();
    if (chatPic == null) {
      return false;
    } else {
      await firebaseChat.uploadPic(attendeeFbId, otherUserId);
      notifyListeners();
      return true;
      // createEventImages.add(createEventImage);
      // notifyListeners();
      // return true;
    }
  }

  scrollToEnd() {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      myController.animateTo(
        myController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
    });
    /*WidgetsBinding.instance?.addPostFrameCallback((_) {
      if(myController.hasClients){
        myController.animateTo(
          myController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });*/
    notifyListeners();
  }

  gettingAllBlockedUsers() async {
    usersBlocked = [];
    isLoading = true;
    //notifyListeners();
    var user = userModel.UserModel();
    if (allBlockedUsers.length != 0) {
      for (var blockedUsers in allBlockedUsers) {
        if (blockedUsers is List && blockedUsers.length == 2) {
          usersBlocked.add(blockedUsers[1]);
        }
      }
      var response = await multipleAppUsers.chatsUsers(usersBlocked, user);
      if (response is List<UserModel>) {
        //surveyResponse = true;
        blockedUsers = response.reversed.toList();
        // if(chatUsers.any((myElement) => allBlockedUsers.contains(myElement))){
        //   return chatUsers;
        // }
        //chatUsers.removeWhere((element) => element.FirebaseUserId == allBlockedUsers);
        print(blockedUsers);
        // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child:SurveyPreview(
        //   title: title,
        // )));
        isLoading = false;
        notifyListeners();
      }
      // else if(response is String){
      //   DialogUtils().showDialog(MyErrorWidget(
      //     error: "Some thing went wrong",
      //   ));
      //   isLoading = false;
      //   notifyListeners();
      // }
    }
    isLoading = false;
    notifyListeners();
  }

  unblockTheUser() async {
    await firebaseChat.unblockUser();
    navigationService.navigateTo(to: MainView(index: 1));
  }

  initializeRecording() {
    isRecording = false;
  }

  disposeRecording() {
    timer?.cancel();
    ampTimer?.cancel();
    audioRecorder.dispose();
  }

  start(String attendeeFbId, String otherUserId) async {
    try {
      if (await audioRecorder.hasPermission()) {
        // We don't do anything with this but printing
        final isSupported = await audioRecorder.isEncoderSupported(
          AudioEncoder.aacLc,
        );
        if (kDebugMode) {
          print('${AudioEncoder.aacLc.name} supported: $isSupported');
        }

        getFilePath();
        await audioRecorder.start(encoder: AudioEncoder.aacLc);

        // bool isRecording = await audioRecorder.isRecording();
        // await audioRecorder.stop();
        //isRecording = isRecording;
        //recordDuration = 0;
        notifyListeners();
        // setState(() {
        //   _isRecording = isRecording;
        //   _recordDuration = 0;
        // });

        //_startTimer();
      }
    } catch (e) {
      print(e);
    }
  }

  stop(String attendeeFbId, String otherUserId) async {
    timer?.cancel();
    ampTimer?.cancel();
    isRecording = false;
    file = await File((await audioRecorder.stop())!).create();
    // File test = await File(file!.path);
    // test.writeAsBytesSync(await file!.readAsBytesSync());
    // file = test;
    notifyListeners();
    await firebaseChat.uploadRecording(attendeeFbId, otherUserId);
    notifyListeners();
    //widget.onStop(path!);
    //setState(() => _isRecording = false);
  }

  int i = 0;

  getFilePath() async {
    var storageDirectory = await getExternalStorageDirectory();
    sdPath = await storageDirectory!.path + "/record/audio.mp4";
    notifyListeners();
    //var d = Directory(sdPath!);
    // if (!d.existsSync()) {
    //   d.createSync(recursive: true);
    // }
    //return sdPath! + "/test_${i++}.mp3";
  }

  void launchingUrl() async {
    if (!await launchUrl(myUrl)) throw 'Could not launch $myUrl';
  }

  uploadStatus(bool login) async {
    var response = await postTheStatus.postStatus(
        userId!, login ? 1.toString() : 0.toString());
    print(response);
  }
}
