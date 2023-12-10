import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class ZegoCard extends StatelessWidget {
  final String displayName;
  final String name;
  final String id;
  const ZegoCard(
      {super.key,
      required this.displayName,
      required this.name,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Colors.blue,
            Colors.purple
          ], // Change these to your desired colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "call $displayName",
                style: const TextStyle(
                  color: Colors.white, // Change this to your desired color
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ZegoSendCallInvitationButton(
              isVideoCall: false,
              resourceID: "anrz_zego",
              invitees: [
                ZegoUIKitUser(
                  id: id,
                  name: name,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
