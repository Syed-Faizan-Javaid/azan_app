import 'dart:async';

import 'package:azan_app/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/adhan_cubit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AdhanCubit adhanCubit;

  @override
  void initState() {
    adhanCubit = AdhanCubit();
    print('print');
    adhanCubit.getAdhanTimes(true);
    super.initState();
    Timer(
        const Duration(seconds: 1),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider.value(
                  value: adhanCubit,
                  child: const HomePage(),
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => adhanCubit,
      child: Scaffold(
        backgroundColor: Colors.black54,
        body: Center(
          child: Image.asset('images/splash.png'),
        ),
      ),
    );
  }
}
