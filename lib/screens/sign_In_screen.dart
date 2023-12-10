import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/screens/home_screen.dart';
import 'package:internship_app/user_data/navigation_bar.dart';
import 'package:internship_app/widget/sign_In_google.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  var _userName = '';
  bool _isLoading = false;

  void _submit() async {
    setState(() {
      _isLoading = true;
    });
    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _email.text, password: _password.text);
    try {
      //get data from firestore
      final docRef = await FirebaseFirestore.instance
          .collection('internAppUsers')
          .doc(userCredential.user!.uid)
          .get();
      final data = docRef.data() as Map<String, dynamic>;
      print(data.entries.toList());
      _userName = data.entries.toList()[2].value;
      //=========================================================
      try {
        await ZegoUIKitPrebuiltCallInvitationService().init(
          appID: yourAppID /*input your AppID*/,
          appSign: yourAppSign /*input your AppSign*/,
          userID: userCredential.user!.uid,
          userName: userCredential.user!.email!,
          plugins: [ZegoUIKitSignalingPlugin()],
        );
        print("zedo initialisation done");
      } catch (e) {
        print("error in zego initialisation");
        print(e.toString());
      }
      //=================================================
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
      return;
    }
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', _email.text);
    preferences.setString('userId', userCredential.user!.uid);

    if (context.mounted) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MyNavigationBar(),
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              obscureText: true,
              controller: _password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: _submit,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Sign In")),
            const SizedBox(
              height: 12,
            ),
            const SignInGoogle()
          ],
        ),
      ),
    );
  }
}
