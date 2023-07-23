// iclosable.dart

// THIS FILE IS GENERATED AUTOMATICALLY AND SHOULD NOT BE EDITED DIRECTLY.

// ignore_for_file: unused_import, directives_ordering
// ignore_for_file: constant_identifier_names, non_constant_identifier_names
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../api_ms_win_core_winrt_string_l1_1_0.dart';
import '../combase.dart';
import '../exceptions.dart';
import '../macros.dart';
import '../utils.dart';
import '../types.dart';
import '../winrt_helpers.dart';

import '../extensions/hstring_array.dart';
import 'ivector.dart';
import 'ivectorview.dart';

import '../com/iinspectable.dart';

/// @nodoc
const IID_IClosable = '{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}';

/// {@category Interface}
/// {@category winrt}
class IClosable extends IInspectable {
  // vtable begins at 6, is 1 entries long.
  IClosable(super.ptr);

  late final Pointer<COMObject> _thisPtr = toInterface(IID_IClosable);

  void Close() {
    final hr = _thisPtr.ref.vtable
        .elementAt(6)
        .cast<Pointer<NativeFunction<HRESULT Function(Pointer)>>>()
        .value
        .asFunction<int Function(Pointer)>()(_thisPtr.ref.lpVtbl);

    if (FAILED(hr)) throw WindowsException(hr);
  }
}
