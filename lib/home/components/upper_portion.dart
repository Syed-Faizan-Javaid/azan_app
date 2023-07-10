import 'dart:async';

import 'package:azan_app/home/cubit/adhan_cubit.dart';
import 'package:azan_app/model/Adhan.dart';
import 'package:azan_app/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/constant_widgets/constant_widgets.dart';
import '../../model/prayer_time.dart';

class UpperPortion extends StatefulWidget {
  UpperPortion({Key? key, required this.adhan, required this.prayerTimeModel, required this.time, required this.zone, required this.todayIslamicDate})
      : super(key: key);
  Adhan adhan;
  PrayerTimeModel prayerTimeModel;
  String time;
  String zone;
  String todayIslamicDate;

  @override
  State<UpperPortion> createState() => _UpperPortionState();
}

class _UpperPortionState extends State<UpperPortion> {
  late Timer _timer;
  late AdhanCubit _adhanCubit;
  @override
  void initState() {
    _adhanCubit = context.read<AdhanCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Container(
            height: MediaQuery.of(context).size.height * .6,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'images/sunrise.png',
                    height: 65,
                    width: 170,
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 810,
                        height: 280,
                        constraints: const BoxConstraints(minHeight: 280, minWidth: 810),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              left: 18,
                              top: -15,
                              child: SizedBox(
                                width: 670,
                                height: 305,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                      child: Text(
                                        widget.time,
                                        style: GoogleFonts.poppins(
                                          fontSize: 190,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          letterSpacing: 4.2,
                                          color: const Color(0xffffc265),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                                      child: Text(
                                        widget.zone,
                                        style: GoogleFonts.poppins(
                                          fontSize: 50,
                                          fontWeight: FontWeight.w400,
                                          height: 1.5,
                                          color: const Color(0xff707070),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 135,
                              top: 245,
                              child: Align(
                                child: SizedBox(
                                  width: 440,
                                  height: 35,
                                  child: Text(
                                    widget.todayIslamicDate,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.lobster(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w400,
                                      height: 1,
                                      letterSpacing: 1.6,
                                      color: const Color(0xff707070),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 615,
                              top: 27,
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(13.47, 10.52, 14.76, 10.52),
                                width: 182.23,
                                height: 61.24,
                                decoration: BoxDecoration(
                                  color: const Color(0xfffcffff),
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x19000000),
                                      offset: Offset(0, 5),
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(0, 1.38, 20, 0),
                                      child: Text(
                                        'Sunrise',
                                        style: GoogleFonts.inter(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w400,
                                          height: 1,
                                          color: const Color(0xff404040),
                                        ),
                                      ),
                                    ),
                                    Image.network(
                                      "images/sun_vector.png",
                                      width: 32,
                                      height: 34,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      children: [
                        buildContainer('Sunrise', widget.adhan.sunrise),
                        buildContainer('Sunset', widget.adhan.sunset),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        : Container();
  }
}
