import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:trialapp/screens/location_screen.dart';
import 'background_his.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'dart:async';

class CustomDatabase extends StatefulWidget {
  CustomDatabase({this.app});
  final FirebaseApp app;

  @override
  _CustomDatabaseState createState() => _CustomDatabaseState();
}

class _CustomDatabaseState extends State<CustomDatabase> {
  final referenceDatabase = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ref = referenceDatabase.reference();
    return Scaffold(
      body: BackgroundHis(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Flexible(
                        child: new FirebaseAnimatedList(
                          shrinkWrap: true,
                          query: ref,
                          itemBuilder: (BuildContext context,
                              DataSnapshot snapshot,
                              Animation<double> animation,
                              int index) {
                            String temperature =
                                snapshot.value['Temperature']['val'];
                            bool _isthreat = snapshot.value['isthreat']['val'];
                            _isthreat ? playaudio() : puseaudio();
                            double latitude = snapshot.value['latitude']['val'];
                            double longitude =
                                snapshot.value['longitude']['val'];

                            return Stack(children: [
                              Column(children: [
                                ListTile(
                                  leading: _isthreat
                                      ? IconButton(
                                          icon: Icon(
                                            Icons.snooze,
                                            color: _isthreat
                                                ? Colors.red[800]
                                                : null,
                                          ),
                                          onPressed: () {
                                            snooze();
                                          })
                                      : null,
                                  trailing: IconButton(
                                      icon: Icon(
                                        Icons.location_on,
                                        color:
                                            _isthreat ? Colors.red[800] : null,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            LocationScreen.routeName);
                                      }),
                                  title: Text(
                                    'worker temperature : $temperature ˚C',
                                    style: TextStyle(
                                      fontSize: 21,
                                      color: _isthreat ? Colors.red[800] : null,
                                    ),
                                  ),
                                  subtitle: Text(
                                      'latitude: $latitude , longitude: $longitude'),
                                ),
                              ]),
                            ]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

  void playaudio() async {
    assetsAudioPlayer.open(Audio('assets/audio/alarm.mp3'));
  }

  void puseaudio() async {
    assetsAudioPlayer.stop();
    print('stooop');
  }

  @override
  void dispose() {
    assetsAudioPlayer.stop();
    super.dispose();
  }

  void snooze() async {
    assetsAudioPlayer.stop();
    Timer(Duration(minutes: 2), () {
      assetsAudioPlayer.play();
    });
  }
}
