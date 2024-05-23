import "gobals.dart";
import "package:flutter/material.dart";

class StatefulBox extends StatefulWidget {
    final double w, h;

    const StatefulBox({required this.w, required this.h, super.key});

    @override
    StatefulBoxState createState() {
        return StatefulBoxState();
    }
}

class StatefulBoxState extends State<StatefulBox> {
    String input = "";
    String get getStr => input;

    void update(String label) {
        setState(() {
            input += label;
        });
    }

    void set(String label) {
        setState(() {
            input = label;
        });
    }

    void clear() {
        setState(() {
            input = "";
        });
    }

    void del() {
        if(input.isEmpty) return;
        int len = input.length;
        setState(() {
            if(input[len - 1] == "s" || input[len - 1] == "l" || input[len - 1] == "d") {
                input = input.substring(0, len - 3);
            } else {
                input = input.substring(0, len - 1);
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            width: widget.w,
            height: widget.h,
            decoration: BoxDecoration(
                color: backgroundColor.withOpacity(0.5),
                shape: BoxShape.rectangle,
                border: Border.all(color: backgroundColor, width: 2),
                boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                    )
                ]
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.bottomRight,
            child: Text(
                input,
                textAlign: TextAlign.right,
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                ),
            ),
        );
    }
}
