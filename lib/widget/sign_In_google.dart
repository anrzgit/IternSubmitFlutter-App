import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internship_app/screens/home_screen.dart';
import 'package:internship_app/user_data/navigation_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

final int yourAppID = 1345690377;
final String yourAppSign =
    '6739868f72d3616135b222cd9b7b993cd8676d10b59228e931320490bbe4d9d7';

class SignInGoogle extends StatefulWidget {
  const SignInGoogle({super.key});

  @override
  State<SignInGoogle> createState() => _SignInGoogleState();
}

class _SignInGoogleState extends State<SignInGoogle> {
  var _isAuthanticating = false;

  // Future<void> getUser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   _userEmail = preferences.getString('email') ?? "Dummy ";
  // }

  void signIn() async {
    setState(() {
      _isAuthanticating = true;
    });
    try {
      //google sign in
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken, idToken: gAuth.idToken);

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      //storing In firestore

      await FirebaseFirestore.instance
          .collection('internAppUsers')
          .doc(userCredential.user!.uid)
          .set({
        'email': userCredential.user!.email,
        'username': userCredential.user!.uid,
      });
      //=========================================================
      ZegoUIKitPrebuiltCallInvitationService().init(
        appID: yourAppID /*input your AppID*/,
        appSign: yourAppSign /*input your AppSign*/,
        userID: userCredential.user!.uid,
        userName: userCredential.user!.email!,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
      //=================================================

      //saving Locally
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', userCredential.user!.email ?? "Anon User");

      if (context.mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MyNavigationBar(),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      return;
    }
    setState(() {
      _isAuthanticating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: signIn,
      icon: SvgPicture.asset(
        'assets/svgs/g_logo.svg',
        width: 26,
      ),
      label: _isAuthanticating
          ? const CircularProgressIndicator()
          : const Text("Sign in with google "),
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
    );
  }
}
