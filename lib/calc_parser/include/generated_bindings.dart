import "dart:ffi" as ffi;
import "package:ffi/ffi.dart";

class CalcParser {

  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  CalcParser(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  CalcParser.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  late final ffi.Pointer<ffi.Double> _result = _lookup<ffi.Double>("result");
  double get result => _result.value;

  late final ffi.Pointer<ffi.Pointer<Utf8>> _errMsg = _lookup<ffi.Pointer<Utf8>>("errMsg");
  ffi.Pointer<Utf8> get errMsg => _errMsg.value;
  bool errMsgIsNull() {
    return _errMsg.value == ffi.nullptr;
  }

  void solve(String s) {
    ffi.Pointer<Utf8> str = s.toNativeUtf8();
    _solve(str);
    malloc.free(str);
  }
  late final _solvePtr =
      _lookup<ffi.NativeFunction<ffi.Void Function(ffi.Pointer<Utf8>)>>("solve");
  late final _solve =
      _solvePtr.asFunction<void Function(ffi.Pointer<Utf8>)>();

}
