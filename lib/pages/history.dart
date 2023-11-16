import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Call History"),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "call raaz",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ZegoSendCallInvitationButton(
                  isVideoCall: false,
                  resourceID:
                      "anrz_zego", //You need to use the resourceID that you created in the subsequent steps. Please continue reading this document.
                  invitees: [
                    ZegoUIKitUser(
                      id: 'eJlfAGSdiCbgFZNCgKWvwCL6FZd2',
                      name: 'raaz4995azh@gmail.com',
                    )
                  ],
                ),
              ],
            ),
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
                      id: 'OOlxeROjIHNiC5B6bMqWDBzQKtn2',
                      name: "anrz.test@gmail.com",
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
