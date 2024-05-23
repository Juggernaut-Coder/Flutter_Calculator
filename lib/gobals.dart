import "package:calc/calc_parser/include/generated_bindings.dart";
import "package:calc/calc_parserffi.dart";
import "package:flutter/material.dart";
import "stateful_box.dart";
import "buttons.dart";

const Color appBarColor = Color(0xFF1B5E20);
const Color white = Color(0xFFFFFFFF);
const Color backgroundColor = Color(0x61FFFFFF);
final GlobalKey<StatefulBoxState> ibkey = GlobalKey<StatefulBoxState>();
final GlobalKey<StatefulBoxState> rbkey = GlobalKey<StatefulBoxState>();
final CalcParser calc = returnParserObj();

final List<String> calcHistory = <String>[];
int currHistCnt = 0;
const List<ButtonInfo> buttons = <ButtonInfo>[
  ButtonInfo("C", Colors.redAccent, Colors.white),
  ButtonInfo("(", Colors.orangeAccent, Colors.black),
  ButtonInfo(")", Colors.orangeAccent, Colors.black),
  ButtonInfo("π", Colors.purpleAccent, Colors.black),
  ButtonInfo("Del", Colors.redAccent, Colors.white),
  ButtonInfo("mod", Colors.orangeAccent, Colors.black),
  ButtonInfo("^", Colors.orangeAccent, Colors.black),
  ButtonInfo("/", Colors.orangeAccent, Colors.black),
  ButtonInfo("7", Colors.blueAccent, Colors.white),
  ButtonInfo("8", Colors.blueAccent, Colors.white),
  ButtonInfo("9", Colors.blueAccent, Colors.white),
  ButtonInfo("*", Colors.orangeAccent, Colors.black),
  ButtonInfo("4", Colors.blueAccent, Colors.white),
  ButtonInfo("5", Colors.blueAccent, Colors.white),
  ButtonInfo("6", Colors.blueAccent, Colors.white),
  ButtonInfo("-", Colors.orangeAccent, Colors.black),
  ButtonInfo("1", Colors.blueAccent, Colors.white),
  ButtonInfo("2", Colors.blueAccent, Colors.white),
  ButtonInfo("3", Colors.blueAccent, Colors.white),
  ButtonInfo("+", Colors.orangeAccent, Colors.black),
  ButtonInfo("0", Colors.blueAccent, Colors.white),
  ButtonInfo(".", Colors.blueAccent, Colors.white),
  ButtonInfo("Ans", Colors.greenAccent, Colors.black),
  ButtonInfo("=", Colors.greenAccent, Colors.black),
];
