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

  @override
  Widget build(BuildContext context) {
    return !Responsive.isMobile(context)
        ? Expanded(
            child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: prayers.length,
                    itemBuilder: (context, int index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
                        width: 150,
                        decoration: BoxDecoration(
                          color: prayers[index].isActiveTime == true ? Color(0xFF1DA599) : Color(0xfffcffff),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  'start',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                    color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff707070),
                                  ),
                                ),
                              ),
                              Container(
                                // group5Cbu (1:203)
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 2),
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      prayers[index].startTime,
                                      style: GoogleFonts.poppins(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        letterSpacing: 1.6,
                                        color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff404040),
                                      ),
                                    ),
                                    // Text(
                                    //   'AM',
                                    //   style: GoogleFonts.poppins(
                                    //     fontSize: 19,
                                    //     fontWeight: FontWeight.w400,
                                    //     height: 1.5,
                                    //     color: const Color(0xff404040),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Text(
                                prayers[index].prayerName,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  letterSpacing: 0.72,
                                  color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff1da599),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      prayers[index].endTime,
                                      style: GoogleFonts.poppins(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                        height: 1.5,
                                        letterSpacing: 1.6,
                                        color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff404040),
                                      ),
                                    ),
                                    // Text(
                                    //   'AM',
                                    //   style: GoogleFonts.poppins(
                                    //     fontSize: 19,
                                    //     fontWeight: FontWeight.w400,
                                    //     height: 1.5,
                                    //     color: const Color(0xff404040),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                              Text(
                                'end',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  height: 1.5,
                                  color: prayers[index].isActiveTime == true ? Colors.white : Color(0xff707070),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                Container(
                  width: 190,
                  height: 190,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0x33ffc265)),
                    borderRadius: BorderRadius.circular(95),
                  ),
                  child: Align(
                    child: SizedBox(
                      width: 168,
                      height: 168,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(84),
                          border: Border.all(color: const Color(0x99ffc265)),
                        ),
                        child: Container(
                          width: 170,
                          height: 170,
                          // padding: EdgeInsets.fromLTRB(13.5, 26.5, 13.5, 26.5),
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
                                    height: 1.5,
                                    letterSpacing: 1.3,
                                    color: const Color(0xff404040),
                                  ),
                                ),
                                Text(prayerName == "Isha" ? "Before Fajar Time" : remainingTime,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5,
                                      letterSpacing: 1.6,
                                      color: const Color(0xff404040),
                                    )),
                                Text(
                                  prayerName == "Isha" ? "" : 'left',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    height: 1.5,
                                    letterSpacing: 2,
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
}
