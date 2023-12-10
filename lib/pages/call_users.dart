import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship_app/core/zego_card.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallUsers extends StatefulWidget {
  const CallUsers({super.key});

  @override
  State<CallUsers> createState() => _CallUsers();
}

class _CallUsers extends State<CallUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call Users"),
      ),
      body: Center(
        child: Column(
          children: [
            const ZegoCard(
                displayName: 'anrz',
                name: 'anrz',
                id: 'xKR377Z3nCUdDbKipSlcPzVPLuF2'),
            const ZegoCard(
                displayName: 'Thaiseva App',
                name: 'thaiseva@gmail.com',
                id: '2ty3HuPHqTfVr7su5vnX7EJGnJb2'),
            Row(
              children: [
                const Text(
                  "call anrz",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ZegoSendCallInvitationButton(
                  isVideoCall: true,
                  resourceID:
                      "anrz_zego", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                  invitees: [
                    ZegoUIKitUser(
                      id: 'eXpXfxtoFTU6NMmDqeqKVlCcqQ72',
                      name: "anrz.test@gmail.com",
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "call Thaiseva",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ZegoSendCallInvitationButton(
                  isVideoCall: true,
                  resourceID:
                      "anrz_zego", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                  invitees: [
                    ZegoUIKitUser(
                      id: '2ty3HuPHqTfVr7su5vnX7EJGnJb2',
                      name: "thaiseva@gmail.com",
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
