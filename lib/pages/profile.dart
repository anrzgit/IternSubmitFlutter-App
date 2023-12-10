import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internship_app/pages/call_users.dart';
import 'package:internship_app/pages/home.dart';
import 'package:internship_app/pages/profile.dart';
import 'package:internship_app/screens/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //

  final user = FirebaseAuth.instance.currentUser!;
  //
  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    await FirebaseAuth.instance.signOut();

    ZegoUIKitPrebuiltCallInvitationService().uninit();

    //google sign out
    await GoogleSignIn().signOut();
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  user.photoURL ?? 'https://via.placeholder.com/150'),
            ),
            const SizedBox(height: 10),
            Text(
              user.displayName ?? 'John Doe',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              user.email ?? 'johndoe@example.com',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Card(
            //   child: ListTile(
            //     leading: Icon(Icons.phone),
            //     title: Text('Phone'),
            //     subtitle: Text(user.phoneNumber ?? 'Not Provided'),
            //   ),
            // ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                subtitle: Text(
                  user.email ?? 'johndoe@example.com',
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () => logout(),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
