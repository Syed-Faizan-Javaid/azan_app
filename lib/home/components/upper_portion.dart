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
    return !Responsive.isMobile(context)
        ? Container(
            height: MediaQuery.of(context).size.height * .6,
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * 0.78,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sunriseConstant(const Color(0xFF1DA599)),
                      Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Container(
                                width: 600,
                                height: 260,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    Positioned(
                                      right: 12,
                                      top: 10,
                                      child: sunriseConstant(const Color(0xff404040)),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(top: 30),
                                              child: Text(
                                                widget.time,
                                                style: GoogleFonts.poppins(
                                                  letterSpacing: 2.5,
                                                  height: 1,
                                                  fontSize: 150,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xffffc265),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20, left: 10),
                                              child: Text(
                                                widget.zone,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 40,
                                                  fontWeight: FontWeight.w400,
                                                  color: const Color(0xff707070),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            widget.todayIslamicDate,
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.lobster(
                                              fontSize: 26,
                                              fontWeight: FontWeight.w400,
                                              height: 1,
                                              letterSpacing: 1.4,
                                              color: const Color(0xff707070),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Column(
                    children: [
                      buildContainer('Sunrise', widget.adhan.sunrise),
                      buildContainer('Sunset', widget.adhan.sunset),
                    ],
                  ),
                )
              ],
            ),
          )
        : Container();
  }

  Container sunriseConstant(Color color) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
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
            margin: const EdgeInsets.fromLTRB(0, 1.38, 13, 0),
            child: Text(
              'Sunrise',
              style: GoogleFonts.inter(
                fontSize: 23,
                fontWeight: FontWeight.w400,
                height: 1,
                color: color,
              ),
            ),
          ),
          Image.asset(
            "images/sun_vector.png",
            width: 32,
            height: 34,
            color: color,
          ),
        ],
      ),
    );
  }
}
