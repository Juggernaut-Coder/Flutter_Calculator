import "dart:ffi";
import "dart:io" show Platform;
import "./calc_parser/include/generated_bindings.dart";

DynamicLibrary getDynamicLib() {
    return Platform.isLinux ?
        DynamicLibrary.open("lib/calc_parser/lib/libcalc_parser.so") :
        Platform.isAndroid ?
        DynamicLibrary.open("./calc_parser/lib/libcalc_parser_andriod.so") :
        Platform.isIOS ?
        DynamicLibrary.open("./calc_parser/lib/libcalc_parser_ios.dylib") :
        Platform.isWindows ?
        DynamicLibrary.open("./calc_parser/lib/libcalc_parser_ios.dll") :
        DynamicLibrary.open("./calc_parser/lib/libcalc_parser_macOS.dylib");
}

CalcParser returnParserObj() {
    return CalcParser(getDynamicLib());
}
