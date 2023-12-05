import 'package:flutter/material.dart';
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
                      id: 'xKR377Z3nCUdDbKipSlcPzVPLuF2',
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
                      id: 'gYhJkibFV2ahmzHoXtzIj338KWl2',
                      name: "Thaiseva App",
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
