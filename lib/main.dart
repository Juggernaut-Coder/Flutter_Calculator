import "gobals.dart";
import "package:flutter/material.dart";
import "stateful_box.dart";
import "buttons.dart";
import "app_bar.dart";

void main() {
    runApp(const CalcWidget());
}

class CalcWidget extends StatelessWidget {
    const CalcWidget({super.key});
    @override
    Widget build(BuildContext context) {
        final Size scrnSize = MediaQuery.sizeOf(context);
        return getMaterialApp(scrnSize);
    }
}

Container getPaddingContainer(double w) {
    return Container(
        height: 2,
        width: w,
        color: const Color(0xFF000000),
    );
}

MaterialApp getMaterialApp(Size scrnSize) {
    final double appBarHeight = scrnSize.height * 0.08;
    final double resultBoxHeight = scrnSize.height * 0.1;
    final double inputBoxHeight = scrnSize.height * 0.2;
    final double heightRemains = (1-0.08-0.1-0.2)*scrnSize.height - 2*3;
    final bool hasRealState = scrnSize.height > 50;
    final Scaffold home = Scaffold (
        backgroundColor : backgroundColor,
        body: SafeArea(
            child: Column (
                children: <Widget>[
                    getAppBar(scrnSize, appBarHeight),
                    if(hasRealState)
                        getPaddingContainer(scrnSize.width),
                    StatefulBox(w: scrnSize.width, h: resultBoxHeight, key: rbkey), // result box
                    if(hasRealState)
                        getPaddingContainer(scrnSize.width),
                    StatefulBox(w: scrnSize.width, h: inputBoxHeight, key: ibkey), // input box
                    if(hasRealState)
                        getPaddingContainer(scrnSize.width),
                    if(hasRealState)
                        getButtonView(heightRemains, scrnSize.width)
                ],
            ),
        )
    );
    return MaterialApp (home : home);
}


// Notes:-> use stack with positoined for more fine grained positioning
