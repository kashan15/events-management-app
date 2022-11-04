import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:democratic_unity/app/locator.dart';
import 'package:democratic_unity/viewmodels/main_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseChat {
  final fireStoreInstance = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;



  String getConversationID(String userID, String peerID) {
    return userID.hashCode <= peerID.hashCode
        ? userID + '_' + peerID
        : peerID + '_' + userID;
  }
  
  onChatPressed(String attendeeFirebaseId, String otherUserId) {

    MainViewModel model = locator<MainViewModel>();
    var currentFirebaseUserId = model.currentUserFbId;
    //model.chatMessagesList = [];
    

    // adding chat
    fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId!,attendeeFirebaseId )).collection(getConversationID(currentFirebaseUserId,attendeeFirebaseId )).doc().set({
      "content" : model.chatController.text,
      "type" : "text",
      //model.chatController.text.length > 0 ? "text" : "image",
      "userId" : model.currentUserFbId,
      "createdAt" : FieldValue.serverTimestamp(),
      "dateTime" : DateTime.now(),
    })
    .catchError((error){
      print(error);
    });

    // doc Fields
    List userIds = getConversationID(model.userId!, otherUserId).split("_");
    List firebaseChannelID = getConversationID(currentFirebaseUserId,attendeeFirebaseId).split("_");
    List users = [];
    users.addAll(firebaseChannelID);
    users.addAll(userIds);
    fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId,attendeeFirebaseId)).set(
        {
          "docId" : getConversationID(currentFirebaseUserId,attendeeFirebaseId),
          "users" : users,
          "blockedUsers" : [""],
        });

    model.chatController.clear();
  }

   loadChat(String attendeeFirebaseId){
    MainViewModel model = locator<MainViewModel>();
    model.chatMessagesList = [];
    //model.notifyListeners();
    var currentFirebaseUserId = model.currentUserFbId;
    String getConversationID(String userID, String peerID) {
      return userID.hashCode <= peerID.hashCode
          ? userID + '_' + peerID
          : peerID + '_' + userID;
    }

    model.subscription = fireStoreInstance
        .collection("chatCollection")
        .doc(getConversationID(currentFirebaseUserId!,attendeeFirebaseId ))
        .collection(getConversationID(currentFirebaseUserId,attendeeFirebaseId ))
        .orderBy("createdAt",descending: false)
        .snapshots()
    .listen((event) {
      for (DocumentChange doc in event.docChanges){
        if (doc.type==DocumentChangeType.added){
          model.chatMessagesList.add({
            "content" : doc.doc.get("content"),
            "id" : doc.doc.get("userId"),
            "createdAt" : doc.doc.get("createdAt"),
            "type" : doc.doc.get("type"),
            "dateTime" : doc.doc.get("dateTime"),
          });
        }
      }
      model.scrollToEnd();
      model.notifyListeners();
    });
  }

  Future<void> friendList() async{
    MainViewModel model = locator<MainViewModel>();
    //model.chatUsersList = [];
    model.friendsList = [];
    model.friendListFbId = [];
    model.LastMessages = [];
    model.allBlockedUsers = [];

    //  fireStoreInstance.collection("chatCollection").doc("lYFTY0BuGqe014TKdGNLZR3mOnY2_daO1CXMw4MXIuXJZrjXCzKsh6B52").get()
    // .then((value) => print(value));
        //.where('docId', isEqualTo: "lYFTY0BuGqe014TKdGNLZR3mOnY2_daO1CXMw4MXIuXJZrjXCzKsh6B52");
    //query.snapshots().map((list) => list.docs.map((doc) => doc.data));
    //print(query);
    List users = [];
    model.isLoading = true;
     await fireStoreInstance
        .collection('chatCollection')
        .where("users", arrayContains: model.currentUserFbId)
        .get()
        .then((chats)async{
        for (QueryDocumentSnapshot doc in chats.docs){
          model.chatIds.add(((doc["docId"])));
          model.allBlockedUsers.add(((doc["blockedUsers"])));
          print(model.allBlockedUsers);
          // if((doc["blockedUsers"]) != null){
          //   model.allBlockedUsers.add(((doc["blockedUsers"])));
          // }
          String friendId = doc["users"][2]!=model.userId!?doc["users"][2]:doc["users"][3];
          String friendFbId = doc["users"][1]!=model.currentUserFbId!?doc["users"][1]:doc["users"][0];
          model.friendsList.add(friendId);
          model.friendListFbId.add(friendFbId);
          if(!model.allBlockedUsers[0].contains(friendFbId)) {
            await fireStoreInstance.collection("chatCollection").doc(doc.id)
                .collection(doc.id).orderBy("createdAt", descending: true).get()
                .then((messages) {
              model.LastMessages.add(messages.docs.first.data()["content"]);
            });
          }
          model.notifyListeners();
        }
     })
    .catchError((error){

     });
     model.isLoading = false;
  }

  uploadPic(String attendeeFirebaseId, String otherUserId) async {

    MainViewModel model = locator<MainViewModel>();
    var currentFirebaseUserId = model.currentUserFbId;

    //Get the file from the image picker and store it
    Reference ref = storage.ref().child( "image" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(model.chatImage!);
    // print('aaa');
    // print(uploadTask);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    String url = imageUrl.toString();
    model.firebaseImageUrl = url;
    print(url);
    fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId!,attendeeFirebaseId )).collection(getConversationID(currentFirebaseUserId,attendeeFirebaseId )).doc().set({
      "content" : url,
      "type" :  "image",
      "userId" : model.currentUserFbId,
      "createdAt" : FieldValue.serverTimestamp(),
      "dateTime" : DateTime.now(),
    });


    // // doc Fields
    // List userIds = getConversationID(model.userId!, otherUserId).split("_");
    // List firebaseChannelID = getConversationID(currentFirebaseUserId,attendeeFirebaseId).split("_");
    // List users = [];
    // users.addAll(firebaseChannelID);
    // users.addAll(userIds);
    // fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId,attendeeFirebaseId)).set(
    //     {
    //       "docId" : getConversationID(currentFirebaseUserId,attendeeFirebaseId),
    //       "users" : users,
    //     });
    //
    // model.chatController.clear();

   }

  uploadRecording(String attendeeFirebaseId, String otherUserId) async {

    MainViewModel model = locator<MainViewModel>();
    var currentFirebaseUserId = model.currentUserFbId;

    //Get the file from the image picker and store it
    Reference ref = storage.ref().child( "record" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(model.file!);
    // print('aaa');
    // print(uploadTask);
    var recordingUrl = await (await uploadTask).ref.getDownloadURL();
    String url = recordingUrl.toString();
    model.firebaseRecordingUrl = url;
    model.notifyListeners();
    print(url);
    fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId!,attendeeFirebaseId )).collection(getConversationID(currentFirebaseUserId,attendeeFirebaseId )).doc().set({
      "content" : url,
      "type" :  "record",
      "userId" : model.currentUserFbId,
      "createdAt" : FieldValue.serverTimestamp(),
      "dateTime" : DateTime.now(),
    });


    // // doc Fields
    // List userIds = getConversationID(model.userId!, otherUserId).split("_");
    // List firebaseChannelID = getConversationID(currentFirebaseUserId,attendeeFirebaseId).split("_");
    // List users = [];
    // users.addAll(firebaseChannelID);
    // users.addAll(userIds);
    // fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId,attendeeFirebaseId)).set(
    //     {
    //       "docId" : getConversationID(currentFirebaseUserId,attendeeFirebaseId),
    //       "users" : users,
    //     });
    //
    // model.chatController.clear();

  }

   blockUser(String attendeeFirebaseId, String otherUserId) async{

     MainViewModel model = locator<MainViewModel>();
    var currentFirebaseUserId = model.currentUserFbId;

     List userIds = getConversationID(model.userId!, otherUserId).split("_");
     List firebaseChannelID = getConversationID(currentFirebaseUserId!,attendeeFirebaseId).split("_");
     List users = [];
     users.addAll(firebaseChannelID);
     users.addAll(userIds);
     List blockedUsers = [];
     //blockedUsers.add(currentFirebaseUserId);
     blockedUsers.add(attendeeFirebaseId);
     blockedUsers.add(otherUserId);

     await fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId,attendeeFirebaseId)).set(
         {
           "docId" : getConversationID(currentFirebaseUserId,attendeeFirebaseId),
           "users" : users,
           "blockedUsers" : blockedUsers,
         });
   }

   unblockUser() async{
     MainViewModel model = locator<MainViewModel>();
     var currentFirebaseUserId = model.currentUserFbId;
     var unblockingId = model.unblockUserFbId;

     var doc = await fireStoreInstance.collection("chatCollection")
         .doc(getConversationID(currentFirebaseUserId!, unblockingId!))
         .get();

     if(doc.exists){
       Map<String, dynamic>? map = doc.data();
       if(map!.containsKey('blockedUsers')){
         List valueOfField = map['blockedUsers'];
         valueOfField[0] = "";
         valueOfField.remove(valueOfField[1]);
         await fireStoreInstance.collection('chatCollection').doc(getConversationID(currentFirebaseUserId,unblockingId)).update(
             {
               "blockedUsers" : valueOfField,
             });
       }
     }

   }

  changeStatus(String userId, bool online) {

    MainViewModel model = locator<MainViewModel>();
    //var currentFirebaseUserId = model.currentUserFbId;
    //model.chatMessagesList = [];
    
    fireStoreInstance.collection('Users').doc(userId).set({
      "status" : online,
    }).then((value){
      model.userStatus = online;
    }
    )
        .catchError((error){
      print(error);
    });
  }

}
