import 'package:flutter/material.dart';
import 'package:flutter_tiktok_sdk/flutter_tiktok_sdk.dart';
import 'package:tiktok_login_flutter/tiktok_login_flutter.dart';

import 'package:flutter_insta/flutter_insta.dart';

import 'package:flutter/services.dart';
import 'test_insta_screen.dart';

const clientKey = 'aw1u1ucjw0n0wmc2';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TiktokLoginFlutter.initializeTiktokLogin(clientKey);
  WidgetsFlutterBinding.ensureInitialized();
  // await TikTokSDK.instance.setup(clientKey: clientKey);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  //get data from api
  Future printDetails(String username) async {
    FlutterInsta flutterInsta = FlutterInsta();
    await flutterInsta.getProfileData(username);
    print('flutterInsta: $flutterInsta');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('認証'),
      ),
      body: ListView(
        children: [
          ElevatedButton(
            child: const Text('instagram 認証開始1'),
            onPressed: () {
              printDetails('beauty_golf');
            },
            // onPressed: () async {
            //   try {
            //     final result = await TikTokSDK.instance.login(
            //       permissions: {
            //         TikTokPermissionType.userInfoBasic,
            //       },
            //     );
            //     print('data: ${result}');
            //   } catch (e) {
            //     print('e: $e');
            //   }
            // },
          ),
          ElevatedButton(
            child: const Text('tiktok 認証開始2'),
            onPressed: () async {
              const MethodChannel _channel =
                  MethodChannel('tiktok_login_flutter');
              try {
                // var code = await TiktokLoginFlutter.authorize(
                //     "user.info.basic,video.list");
                var code = await _channel.invokeMethod('authorize', {
                  "scope": "user.info.basic,video.list",
                });
                print('code: ${code}');
              } catch (e) {
                print('e: $e');
              }
            },
          ),
        ],
      ),
    );
  }
}
