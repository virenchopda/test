goimport 'dart:math';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zego_express_engine/zego_express_engine.dart';

enum LiveRole { host, audience }

class CallPage extends StatefulWidget {
  final String? name;
  final String? roomId;
  final LiveRole? liveRole;
  final bool isLiveStreaming;

  const CallPage({
    super.key,
    this.name,
    this.roomId,
    this.liveRole,
    this.isLiveStreaming = false,
  });

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  Widget? localView;
  Widget? remoteView;

  int? localViewID;
  int? remoteViewID;

  Random rand = Random();

  // String getRoomId() {
  //   if (widget.roomId == null) {
  //     final id = rand.nextInt(100000000).toString();
  //     print(id);
  //     return id;
  //   } else {
  //     return widget.roomId!;
  //   }
  // }

  String getUserId() {
    // return 'user101';
    return rand.nextInt(100000000).toString();
  }

  @override
  void initState() {
    super.initState();

    (() async {
      await Permission.camera.request();
      await Permission.microphone.request();
      startListenEvent();
      loginRoom(getUserId(), widget.name!);
    }());
  }

  String _roomId = '';

  void startListenEvent() {
    ZegoExpressEngine
        .onRoomUserUpdate = (roomID, updateType, List<ZegoUser> userList) {
      debugPrint(
        'onRoomUserUpdate: roomID: $roomID, updateType: ${updateType.name}, userList: ${userList.map((e) => e.userID)}',
      );
    };

    ZegoExpressEngine.onRoomStreamUpdate =
        (roomID, updateType, List<ZegoStream> streamList, extendedData) {
          debugPrint(
            'onRoomStreamUpdate: roomID: $roomID, updateType: $updateType, streamList: ${streamList.map((e) => e.streamID)}, extendedData: $extendedData',
          );
          if (updateType == ZegoUpdateType.Add) {
            for (final stream in streamList) {
              startPlayStream(stream.streamID);
            }
          } else {
            for (final stream in streamList) {
              stopPlayStream(stream.streamID);
            }
          }
        };
  }

  Future<void> startPlayStream(String streamID) async {
    await ZegoExpressEngine.instance
        .createCanvasView((viewID) {
          remoteViewID = viewID;
          ZegoExpressEngine.instance.startPlayingStream(
            streamID,
            canvas: ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill),
          );
        })
        .then((canvasViewWidget) {
          setState(() => remoteView = canvasViewWidget);
        });
  }

  Future<void> stopPlayStream(String streamID) async {
    ZegoExpressEngine.instance.stopPlayingStream(streamID);
    if (remoteViewID != null) {
      ZegoExpressEngine.instance.destroyCanvasView(remoteViewID!);
      remoteViewID = null;
      remoteView = null;
      setState(() {});
    }
  }

  Future<ZegoRoomLoginResult> loginRoom(String userID, String userNm) async {
    final user = ZegoUser(userID, userNm);
    _roomId = '1010101010';
    ZegoRoomConfig roomConfig = ZegoRoomConfig.defaultConfig()
      ..isUserStatusNotify = true
      ..token =
          "04AAAAAGk/niUADJee+n+Y6dwUwmD/fwCx48B6feC+vvvSqlsatbIy28ImV1udPL461mM/2lZVLYTpDCfnxw6MvKszzMnkttwoc03hXaTIqCP8o92QNOwpmjpC+ImKeRCblnPr10iyJraqZRXAiQFics2fa1tUU0+GykrVhnhd//3fzE+m2h7TPA6ZCE8FXnl39IKPuQFfX16YJMYDn/udbQbnwoGqFbphdmA8MFS04OggqEKZFBY5QPx9iNk81xlcqoZdPiNzpUnNAQ==";

    return ZegoExpressEngine.instance
        .loginRoom(_roomId, user, config: roomConfig)
        .then((ZegoRoomLoginResult loginRoomResult) {
          // debugPrint(
          //   'loginRoom: errorCode:${loginRoomResult.errorCode}, extendedData:${loginRoomResult.extendedData}',
          // );
          if (loginRoomResult.errorCode == 0) {
            startPreview();
            startPublish();
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('loginRoom failed: ${loginRoomResult.errorCode}'),
            //   ),
            // );
          }
          return loginRoomResult;
        });
  }

  Future<ZegoRoomLogoutResult> logoutRoom() async {
    stopPreview();
    stopPublish();
    return ZegoExpressEngine.instance.logoutRoom(_roomId);
  }

  ///Start and stop preview
  Future<void> startPreview() async {
    await ZegoExpressEngine.instance
        .createCanvasView((viewID) {
          localViewID = viewID;
          ZegoExpressEngine.instance.startPreview(
            canvas: ZegoCanvas(viewID, viewMode: ZegoViewMode.AspectFill),
          );
        })
        .then((canvasViewWidget) {
          setState(() => localView = canvasViewWidget);
        });
  }

  Future<void> stopPreview() async {
    ZegoExpressEngine.instance.stopPreview();
    if (localViewID != null) {
      await ZegoExpressEngine.instance.destroyCanvasView(localViewID!);
      localViewID = null;
      localView = null;
      setState(() {});
    }
  }

  Future<void> startPublish() async {
    return ZegoExpressEngine.instance.startPublishingStream(
      "roooooooooo_${widget.name}",
    );
  }

  Future<void> stopPublish() async {
    return ZegoExpressEngine.instance.stopPublishingStream();
  }

  bool isFrontCamera = false;

  void switchCamera() {
    isFrontCamera = !isFrontCamera;
    ZegoExpressEngine.instance.useFrontCamera(isFrontCamera);
    setState(() {});
  }

  bool isMuted = false;
  bool isFromCam = false;

  void toggleMic() {
    isMuted = !isMuted;
    ZegoExpressEngine.instance.muteMicrophone(isMuted);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Call page ${widget.name} ${remoteView}")),
      body: Stack(
        fit: StackFit.expand,
        children: [
          localView ?? Container(),
          Positioned(
            top: MediaQuery.of(context).size.height / 20,
            right: MediaQuery.of(context).size.width / 20,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: AspectRatio(
                aspectRatio: 9.0 / 16.0,
                child: remoteView ?? Container(color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 20,
            left: 0,
            right: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: MediaQuery.of(context).size.width / 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: toggleMic,
                    child: Icon(isMuted ? Icons.mic_off : Icons.mic, size: 32),
                  ),
                  //
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: () {
                      isFromCam = !isFromCam;
                      ZegoExpressEngine.instance.enableCamera(isFromCam);
                      setState(() {});
                    },
                    child: Icon(
                      isFromCam ? Icons.videocam_off : Icons.videocam,
                      size: 32,
                    ),
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                    ),
                    onPressed: switchCamera,
                    child: const Icon(Icons.switch_camera, size: 32),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      logoutRoom().then((value) {
                        Navigator.pop(context);
                      });
                    },
                    child: const Center(child: Icon(Icons.call_end, size: 32)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
