import 'package:flutter/material.dart';
import 'package:flutter_insta/flutter_insta.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class TestInstaScreen extends StatefulWidget {
  @override
  _TestInstaScreenState createState() => _TestInstaScreenState();
}

class _TestInstaScreenState extends State<TestInstaScreen> {
  FlutterInsta flutterInsta =
      FlutterInsta(); // create instance of FlutterInsta class
  TextEditingController usernameController = TextEditingController();
  TextEditingController reelController = TextEditingController();

  String? username, followers = " ", following, bio, website, profileimage;
  bool pressed = false;
  bool downloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Package example app'),
      ),
      body: ElevatedButton(
        onPressed: () {
          printDetails('beauty_golf');
        },
        child: Text('test'),
      ),
    );
  }

//get data from api
  Future printDetails(String username) async {
    await flutterInsta.getProfileData(username);
    setState(() {
      // print('flutterInsta: $flutterInsta');
      var map = {
        'userName': flutterInsta.username,
        'followers': flutterInsta.followers,
        'following': flutterInsta.following,
        'website': flutterInsta.website,
        'bio': flutterInsta.bio,
        'imgurl': flutterInsta.imgurl,
      };
      print('map: $map');
      // this.username = flutterInsta.username; //username
      // this.followers = flutterInsta.followers; //number of followers
      // this.following = flutterInsta.following; // number of following
      // this.website = flutterInsta.website; // bio link
      // this.bio = flutterInsta.bio; // Bio
      // this.profileimage = flutterInsta.imgurl; // Profile picture URL
      // print(followers);
    });
  }

//Reel Downloader page
  Widget reelPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextField(
          controller: reelController,
        ),
        ElevatedButton(
          onPressed: () {
            setState(() {
              downloading = true; //set to true to show Progress indicator
            });
            download();
          },
          child: Text("Download"),
        ),
        downloading
            ? Center(
                child:
                    CircularProgressIndicator(), //if downloading is true show Progress Indicator
              )
            : Container()
      ],
    );
  }

//Download reel video on button clickl
  void download() async {
    var myvideourl = await flutterInsta.downloadReels(reelController.text);

    await FlutterDownloader.enqueue(
      url: '$myvideourl',
      savedDir: '/sdcard/Download',
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification:
          true, // click on notification to open downloaded file (for Android)
    ).whenComplete(() {
      setState(() {
        downloading = false; // set to false to stop Progress indicator
      });
    });
  }
}
