// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:internship_app/screens/home_screen.dart';
import 'package:internship_app/screens/sign_In_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _userName = TextEditingController();
  bool _isAuthenticating = false;

  void _submit() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _email.text, password: _password.text);
      //storing In firestore
      await FirebaseFirestore.instance
          .collection('internAppUsers')
          .doc(userCredential.user!.uid)
          .set({
        'email': _email.text,
        'password': _password.text,
        'username': _userName.text,
      });
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
      _isAuthenticating = false;
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', _email.text);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HomeScreen(currentUser: _userName.text),
      ),
    );
  }

  void _changeToSignIn() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignIn(),
    ));
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _userName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Alleaze InternApp'),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  const Text(
                    "SIGN UP",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  TextField(
                    controller: _userName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Username',
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
                  IconButton(
                    icon: _isAuthenticating
                        ? const CircularProgressIndicator()
                        : const Text('Submit'),
                    onPressed: _submit,
                  ),
                  TextButton(
                    onPressed: _changeToSignIn,
                    child: const Text('Already A User ? Sign in'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
