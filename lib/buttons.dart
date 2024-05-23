import "package:calc/stateful_box.dart";
import "package:ffi/ffi.dart";
import "package:flutter/material.dart";
import "gobals.dart";

class ButtonInfo {
    final String label;
    final Color buttonColor;
    final Color textColor;

    const ButtonInfo(this.label, this.buttonColor, this.textColor);
}

Container getButtonView(double h, double w) {
    final double buttonHeight = h / 6;
    final double buttonWidth = w / 4;

    return Container(
        height: h,
        width: w,
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
        child: GridView.builder(
            itemCount: buttons.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: buttonWidth / buttonHeight
            ),
            itemBuilder: (BuildContext context, int index) {
                StatefulBoxState state = ibkey.currentState!;
                StatefulBoxState rbstate = rbkey.currentState!;
                Function() fn =
                    buttons[index].label == "Del" ?
                    state.del :
                    buttons[index].label == "C" ?
                    () {
                        state.clear();
                        rbstate.clear();
                    } :
                    buttons[index].label == "=" ?
                    () {
                        calc.solve(state.getStr);
                        if(calc.errMsgIsNull()) {
                            calcHistory.add(state.getStr);
                            currHistCnt = calcHistory.length;
                            rbstate.set(calc.result.toString());
                        } else {
                            rbstate.set(calc.errMsg.toDartString());
                        }
                        state.clear();
                    } :
                    () => state.update(buttons[index].label)
                ;
                return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                        )
                    ),
                    child: newButton(
                        buttons[index].label,
                        buttons[index].buttonColor,
                        buttons[index].textColor,
                        const RoundedRectangleBorder(),
                        fn
                    ),
                );
            },
        ),
    );
}

ElevatedButton newButton(String label, Color buttonColor, Color textColor, OutlinedBorder shape, Function() fn) {
    return ElevatedButton(
        onPressed: fn,
        style: ElevatedButton.styleFrom(
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            shape: shape,
            backgroundColor: buttonColor,
            foregroundColor: textColor
        ),
        child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22
            ),
        )
    );
}
