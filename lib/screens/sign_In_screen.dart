import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _email.text, password: _password.text);
      //get data from firestore
      final docRef = await FirebaseFirestore.instance
          .collection('internAppUsers')
          .doc(userCredential.user!.uid)
          .get();
      final data = await docRef.data() as Map<String, dynamic>;
      print(data.entries.toList());
      _userName = data.entries.toList()[2].value;
    } catch (e) {
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

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(currentUser: _userName),
      ),
    );
    setState(() {
      _isLoading = true;
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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Sign In Page'),
        ),
        body: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              const Text(
                'Sign In',
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
                      : const Text("Sign In"))
            ],
          ),
        ));
  }
}