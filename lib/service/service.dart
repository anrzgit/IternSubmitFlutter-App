import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

const int yourAppID = 1345690377;
const String yourAppSign =
    '6739868f72d3616135b222cd9b7b993cd8676d10b59228e931320490bbe4d9d7';

class ZegoService {
  Future initZego(String userName, String uid) async {
    try {
      //username is currently email
      await ZegoUIKitPrebuiltCallInvitationService().init(
        appID: yourAppID /*input your AppID*/,
        appSign: yourAppSign /*input your AppSign*/,
        userID: uid,
        userName: userName,
        plugins: [ZegoUIKitSignalingPlugin()],
      );
      print("zedo initialisation done");
    } catch (e) {
      print("error in zego initialisation");
      print(e.toString());
    }
    //=================================================
  }
}
