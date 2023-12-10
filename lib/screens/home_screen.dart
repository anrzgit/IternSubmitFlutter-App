// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:internship_app/pages/call_users.dart';
// import 'package:internship_app/pages/home.dart';
// import 'package:internship_app/pages/profile.dart';
// import 'package:internship_app/screens/auth_screen.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     super.key,
//   });

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     getUser();
//     super.initState();
//   }

//   int _currentIndex = 0;
//   final List<Widget> _children = [
//     const Home(),
//     const Profile(),
//   ];

//   void onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   var currentUser = 'Not Present';

//   void getUser() async {
//     // SharedPreferences preferences = await SharedPreferences.getInstance();
//     // var obtainedEmail = preferences.getString('email');
//     final user = FirebaseAuth.instance.currentUser!;
//     setState(() {
//       currentUser = user.email!;
//     });
//   }

//   // void logout() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   preferences.remove('email');
//   //   await FirebaseAuth.instance.signOut();

//   //   ZegoUIKitPrebuiltCallInvitationService().uninit();

//   //   //google sign out
//   //   await GoogleSignIn().signOut();
//   //   if (context.mounted) {
//   //     Navigator.pushReplacement(
//   //       context,
//   //       MaterialPageRoute(
//   //         builder: (context) => const AuthScreen(),
//   //       ),
//   //     );
//   //   }
//   // }

//   //To display WebPage

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   automaticallyImplyLeading: false,
//       //   title: Text(
//       //     'Hello $currentUser',
//       //     style: const TextStyle(fontSize: 18),
//       //   ),
//       //   actions: [
//       //     TextButton.icon(
//       //         label: const Text('Logout'),
//       //         onPressed: logout,
//       //         icon: const Icon(Icons.logout))
//       //   ],
//       // ),
//       body: _children[_currentIndex],
//       bottomNavigationBar: CupertinoTabBar(
//         onTap: onTabTapped,
//         currentIndex: _currentIndex,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'Profile',
//           ),
//         ],
//       ),
//     );
//   }
// }
