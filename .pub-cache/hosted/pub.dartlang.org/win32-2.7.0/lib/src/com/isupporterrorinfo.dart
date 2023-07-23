// isupporterrorinfo.dart

// THIS FILE IS GENERATED AUTOMATICALLY AND SHOULD NOT BE EDITED DIRECTLY.

// ignore_for_file: unused_import, directives_ordering
// ignore_for_file: constant_identifier_names, non_constant_identifier_names
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../callbacks.dart';
import '../combase.dart';
import '../constants.dart';
import '../exceptions.dart';
import '../guid.dart';
import '../macros.dart';
import '../ole32.dart';
import '../structs.dart';
import '../structs.g.dart';
import '../utils.dart';

import 'iunknown.dart';

/// @nodoc
const IID_ISupportErrorInfo = '{DF0B3D60-548F-101B-8E65-08002B2BD119}';

/// {@category Interface}
/// {@category com}
class ISupportErrorInfo extends IUnknown {
  // vtable begins at 3, is 1 entries long.
  ISupportErrorInfo(super.ptr);

  int InterfaceSupportsErrorInfo(Pointer<GUID> riid) => ptr.ref.vtable
      .elementAt(3)
      .cast<
          Pointer<
              NativeFunction<Int32 Function(Pointer, Pointer<GUID> riid)>>>()
      .value
      .asFunction<
          int Function(Pointer, Pointer<GUID> riid)>()(ptr.ref.lpVtbl, riid);
}
