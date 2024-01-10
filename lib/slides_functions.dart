import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

Widget newPage(
  int pageId,
  int positionIndex,
  bool fadeIn,
) {
  return DelayedDisplay(
    slidingBeginOffset: Offset(fadeIn ? -2.5 : 2.5, 0),
    fadeIn: fadeIn,
    fadingDuration: const Duration(seconds: 2),
    child: Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(top: positionIndex * 60),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 237, 132, 255),
        border: Border.all(color: Colors.black),
      ),
      child: Center(
          child: Text(
        pageId.toString(),
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      )),
    ),
  );
}

Widget hitPage(
  int pageId,
  int positionIndex,
  bool fadeIn,
) {
  return DelayedDisplay(
    slidingBeginOffset: const Offset(0, 0),
    fadeIn: fadeIn,
    fadingDuration: const Duration(seconds: 1),
    child: Container(
      width: 60,
      height: 60,
      margin: EdgeInsets.only(top: positionIndex * 60),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 103, 0, 124),
          border: Border.all(color: Colors.black)),
      child: Center(
          child: Text(
        pageId.toString(),
        style: const TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      )),
    ),
  );
}
