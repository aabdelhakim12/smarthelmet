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
    var temp;
    return Scaffold(
      body: BackgroundHis(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.all(10),
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
                            var temperature =
                                snapshot.value['Temperature']['val'];
                            if (temperature >= 32 && temperature <= 37) {
                              temp = 37;
                            } else {
                              temp = temperature;
                            }
                            bool _isthreat = snapshot.value['isthreat']['val'];
                            _isthreat ? playaudio() : puseaudio();
                            bool _iswearinghelmet =
                                snapshot.value['iswearinghelmet']['val'];
                            !_iswearinghelmet ? playaudio() : puseaudio();
                            var latitude = snapshot.value['latitude']['val'];
                            var longitude = snapshot.value['longitude']['val'];

                            return Stack(children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                color: Colors.yellowAccent[100],
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _iswearinghelmet
                                                ? ' worker temperature : $temp ˚C'
                                                : "worker isn't wearing helmet",
                                            style: TextStyle(
                                              fontSize: 23,
                                              color:
                                                  _isthreat || !_iswearinghelmet
                                                      ? Colors.red[800]
                                                      : null,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (_) =>
                                              //             GoogleMapPage(
                                              //               lat: latitude,
                                              //               long: longitude,
                                              //             )));
                                              Navigator.of(context).pushNamed(
                                                  LocationScreen.routeName);
                                            },
                                            child: Icon(
                                              Icons.location_on,
                                              color: _isthreat
                                                  ? Colors.red[800]
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'latitude:$latitude ,longitude:$longitude',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color:
                                                  _isthreat || !_iswearinghelmet
                                                      ? Colors.red[800]
                                                      : Colors.grey[700],
                                            ),
                                          ),
                                          _iswearinghelmet
                                              ? Image.asset(
                                                  'assets/images/nothelmet.png',
                                                  height: 35,
                                                  width: 35,
                                                )
                                              : Image.asset(
                                                  'assets/images/helmet.png',
                                                  height: 40,
                                                  width: 40,
                                                  color: Colors.red[800],
                                                ),
                                          !_iswearinghelmet || _isthreat
                                              ? GestureDetector(
                                                  onTap: () {
                                                    snooze();
                                                  },
                                                  child: Icon(
                                                    Icons.snooze,
                                                    color: !_iswearinghelmet ||
                                                            _isthreat
                                                        ? Colors.red[800]
                                                        : null,
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                    ]),
                              ),
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
