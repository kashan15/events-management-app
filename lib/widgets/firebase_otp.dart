
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseOTP{
  Future firebaseOTP(String phoneNumber, String error, String codeVerificationId) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (error) async {
        error;
      },
      codeSent: (String verificationId, int? resendToken) {
        codeVerificationId =verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
   bool verifyCode(PhoneAuthCredential phoneAuthCredential, String codeController, String verifyId){
    codeController = phoneAuthCredential.smsCode!;
    verifyId = phoneAuthCredential.verificationId!;
    return true;
  }
}