import 'package:cht/controllers/app_controller.dart';
import 'package:cht/data/post_api_service.dart';
import 'package:cht/models/user.dart';
import 'package:cht/util/AppConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cht/data/post_api_service.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: ['profile', 'email', 'openid'],
  hostedDomain: 'itbhu.ac.in',
);

Future<UserData> signInWithGoogle() async {
  Get.find<AppStateController>().authState.value = AuthState.Loading;
  GoogleSignInAccount googleSignInAccount;
  googleSignInAccount = await _googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  User user;
  user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  String idToken = (await user.getIdToken());
  print(idToken);
  UserData finalUser = await getUserDataFromIdToken(idToken);
  AppConstants.curUser = finalUser;
  Get.find<AppStateController>().authState.value = AuthState.LoggedIn;
  GetStorage authData = GetStorage();
  authData.write("uid", finalUser.uid);
  return finalUser;
}

getUserDataFromIdToken(String idToken) async {
  UserData user;
  try {
    user = await PostApiService().loginPost(idToken);
  } catch (e) {
    print(e.printError());
    Get.find<AppStateController>().authState.value = AuthState.LoggedOut;
    signInWithGoogle();
    return;
  }

  print(user.name);
  AppConstants.curUser = user;
  return user;
}

void loadUser() async {
  GetStorage box = GetStorage();
  String uid = box.read("uid");
  AppConstants.curUser = await PostApiService().userGet(uid);
}

Future<void> signOutGoogle() async {
  if (_googleSignIn != null) {
    await _googleSignIn.signOut();
  }
  AppConstants.curUser = null;
  FirebaseAuth.instance.signOut();
  print("User Sign Out");
}

// class AuthService extends ChangeNotifier {
//   final googleSignIn = GoogleSignIn();
//   bool _isSigningIn;
//   AuthService() {
//     _isSigningIn = false;
//   }
//   FirebaseFirestore db = FirebaseFirestore.instance;
//   FirebaseAuth auth = FirebaseAuth.instance;

//   Widget checkAuth(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot == null) {
//           return CircularProgressIndicator();
//         } else if (snapshot.hasData) {
//           return FetchPage();
//         } else {
//           return SignIn();
//         }
//       },
//     );
//   }

//   signOut() async {
//     await googleSignIn.disconnect();
//     FirebaseAuth.instance.signOut();
//   }

//   signInWithGoogle() async {
//     final user = await googleSignIn.signIn();
//     if (user == null) {
//       _isSigningIn = false;
//       return;
//     } else {
//       final googleAuth = await user.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await FirebaseAuth.instance.signInWithCredential(credential);

//       _isSigningIn = false;
//     }
//   }

//   getCurrentUser() {
//     return FirebaseAuth.instance.currentUser;
//   }

//   Future<bool> registryCheck() async {
//     //return true;
//     var user = await db.collection("registry").doc(auth.currentUser.uid).get();
//     if (user.exists) {
//       Constants.currentUser = UserData(
//           name: user.data()["Name"],
//           branch: user.data()["Branch"],
//           rollNo: user.data()["Roll"]);
//       return true;
//     }
//     return false;
//   }

//   register(UserData user) {
//     db
//         .collection("registry")
//         .doc(auth.currentUser.uid)
//         .set({"Name": user.name, "Roll": user.rollNo, "Branch": user.branch});
//     db.collection("users").doc(user.rollNo).set({"Name": user.name});
//   }
// }
