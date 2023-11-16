import 'package:flutter/cupertino.dart';
import 'package:internship_app/screens/auth_screen.dart';
import 'package:internship_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Decision extends StatefulWidget {
  const Decision({super.key});

  @override
  State<Decision> createState() => _DecisionState();
}

var finalEmail;

class _DecisionState extends State<Decision> {
  @override
  void initState() {
    getvaldatonData();
    super.initState();
  }

  void getvaldatonData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var obtainedEmail = preferences.getString('email');

    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  Widget build(BuildContext context) {
    return finalEmail != null ? const HomeScreen() : const AuthScreen();
  }
}
