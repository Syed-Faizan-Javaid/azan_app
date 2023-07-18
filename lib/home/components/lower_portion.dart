import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:azan_app/persistent_storage/shared_prefs.dart';
import 'package:azan_app/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../model/prayer_time.dart';

class LowerPortion extends StatelessWidget {
  LowerPortion({Key? key, required this.prayers, required this.prayerTimeModel, required this.remainingTime, required this.prayerName})
      : super(key: key);
  List<PrayerTimeModel> prayers;
  PrayerTimeModel prayerTimeModel;
  String remainingTime;
  String prayerName;
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return !Responsive.isMobile(context)
        ? Expanded(
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (Responsive.isDesktop(context)) Container(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.74,
                  height: 230,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: prayers.length,
                      itemBuilder: (context, int index) {
                        if (prayers[index].isActiveTime == true) {
                          _playAudio(prayers[index].prayerName, prayers[index].isActiveTime);
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          width: 140,
                          decoration: BoxDecoration(
                            color: prayers[index].isActiveTime == true ? const Color(0xFF1DA599) : const Color(0xfffcffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'start',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2,
                                  color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff707070),
                                ),
                              ),
                              Text(
                                prayers[index].startTime,
                                style: GoogleFonts.poppins(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  letterSpacing: 1.3,
                                  color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff404040),
                                ),
                              ),
                              Text(
                                prayers[index].prayerName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  height: 1.2,
                                  color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff1da599),
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    prayers[index].endTime,
                                    style: GoogleFonts.poppins(
                                      fontSize: 27,
                                      fontWeight: FontWeight.w500,
                                      height: 1.2,
                                      letterSpacing: 1.3,
                                      color: prayers[index].isActiveTime == true ? Colors.white : const Color(0xff404040),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'end',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                  height: 1.2,
                                  color: prayers[index].isActiveTime == true ? Colors.white : const Color(0xff707070),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0x33ffc265)),
                    borderRadius: BorderRadius.circular(95),
                  ),
                  child: Align(
                    child: SizedBox(
                      width: 170,
                      height: 170,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(84),
                          border: Border.all(color: const Color(0x99ffc265)),
                        ),
                        child: Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            color: const Color(0xffffc265),
                            borderRadius: BorderRadius.circular(85.4999923706),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  prayerName,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff404040),
                                  ),
                                ),
                                Text(prayerName == "Isha" ? "Before Fajar Time" : remainingTime,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: const Color(0xff404040),
                                    )),
                                Text(
                                  prayerName == "Isha" ? "" : 'left',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff404040),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))
        : Container();
  }

  _playAudio(String? namazName, bool isActiveNamazTime) {
    bool playAudio = false;
    String? namazNameFromPref = SharedPrefs.getString("namazName");
    if (namazNameFromPref != namazName) {
      SharedPrefs.setString("namazName", namazName!);
      playAudio = isActiveNamazTime;
      if (playAudio == true) {
        AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
        assetsAudioPlayer.open(
          Audio("audio/allahu_akbar_short.mp3"),
          showNotification: true,
        );
        playAudio = false;
      }
    }
  }
}
