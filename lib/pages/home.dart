import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/pages/call_users.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    const _kFontFam = 'MyFlutterApp';
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThaiSeva Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const Card(
              child: ListTile(
                leading: Icon(Icons.call),
                title: Text('Active Calls'),
                trailing: Text('5'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.people),
                title: Text('Online Users'),
                trailing: Text('120'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.history),
                title: const Text('Call Users'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => const CallUsers(),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
