import "package:calc/stateful_box.dart";

import "gobals.dart";
import "package:flutter/material.dart";

void up() {
    if(currHistCnt > 0) {
        StatefulBoxState state = ibkey.currentState!;
        state.set( calcHistory[--currHistCnt]);
    }
}

void down() {
    if(currHistCnt < calcHistory.length - 1) {
        StatefulBoxState state = ibkey.currentState!;
        state.set( calcHistory[++currHistCnt]);
    }
}

Container getAppBar(Size scrnSize, double h) {
    TextStyle getTextStyle(double factor) {
        return TextStyle(
            color: white,
            fontWeight: FontWeight.bold,
            fontSize: (factor/2.5), // Adjust font size as needed
        );
    }

    double scaleFactor = h;
    double subContainerSz = scaleFactor - (scaleFactor * 0.08);
    const String title = "Calculator";
    TextStyle textStyle = getTextStyle(scaleFactor);
    TextSpan textSpan = TextSpan(text: title, style: textStyle);
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    double textWidth = textPainter.size.width;
    double textheight = textPainter.size.height;
    final double barWidth = 3 * subContainerSz + textWidth + 12 + 10; //+10 extra and +12 sizedbox

    if(barWidth > scrnSize.width) {
        scaleFactor = scaleFactor * 0.3;
        textStyle = getTextStyle(scaleFactor);
        textSpan = TextSpan(text: title, style: textStyle);
        textPainter = TextPainter(
            text: textSpan,
            textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textWidth = textPainter.size.width;
        textheight = textPainter.size.height;
        subContainerSz = (scrnSize.width - textWidth - 12 -10)/3;
    }

    return Container(
        width: scrnSize.width,
        height: h,
        decoration: const BoxDecoration (
            color: appBarColor,
            shape: BoxShape.rectangle
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Row (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                        const SizedBox(width: 4),
                        createIconButtonContainer(Icons.menu, subContainerSz, (){})
                    ]
                ),
                CustomPaint(
                    size: Size(textWidth, textheight), // Size based on text width and height
                    painter: TextPainterWidget(textPainter),
                ),
                Row (
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                        createIconButtonContainer(Icons.arrow_upward, subContainerSz, up),
                        const SizedBox(width: 4),
                        createIconButtonContainer(Icons.arrow_downward, subContainerSz, down),
                        const SizedBox(width: 4)
                    ],
                )
            ],
        ),
    );
}


class TextPainterWidget extends CustomPainter {
    final TextPainter textPainter;

    TextPainterWidget(this.textPainter);

    @override
    void paint(Canvas canvas, Size size) {
        textPainter.paint(canvas, Offset.zero);
    }

    @override
    bool shouldRepaint(covariant CustomPainter oldDelegate) {
        return false;
    }
}

Container createIconButtonContainer(IconData icon, double containerSz, Function() onPress) {
    return Container(
        width: containerSz,
        height: containerSz,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: appBarColor.withOpacity(0.5),
            shape: BoxShape.circle,
            border: Border.all(color: appBarColor, width: 2),
            boxShadow: <BoxShadow>[
                BoxShadow(
                    color: const Color(0xFF000000).withOpacity(0.35),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                )
            ]
        ),
        child: Center(
            child : IconButton(
                padding: EdgeInsets.zero,
                icon: Icon (
                    icon,
                    color: white,
                    size: containerSz * 0.6,
                ),
                onPressed: onPress,
            )
        )
    );
}
