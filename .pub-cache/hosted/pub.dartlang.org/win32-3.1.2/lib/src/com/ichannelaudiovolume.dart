// ichannelaudiovolume.dart

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
import '../structs.g.dart';
import '../utils.dart';
import '../variant.dart';
import '../win32/ole32.g.dart';
import 'iunknown.dart';

/// @nodoc
const IID_IChannelAudioVolume = '{1c158861-b533-4b30-b1cf-e853e51c59b8}';

/// {@category Interface}
/// {@category com}
class IChannelAudioVolume extends IUnknown {
  // vtable begins at 3, is 5 entries long.
  IChannelAudioVolume(super.ptr);

  factory IChannelAudioVolume.from(IUnknown interface) =>
      IChannelAudioVolume(interface.toInterface(IID_IChannelAudioVolume));

  int getChannelCount(Pointer<Uint32> pdwCount) => ptr.ref.vtable
          .elementAt(3)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Uint32> pdwCount)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Uint32> pdwCount)>()(
      ptr.ref.lpVtbl, pdwCount);

  int setChannelVolume(
          int dwIndex, double fLevel, Pointer<GUID> EventContext) =>
      ptr.ref.vtable
              .elementAt(4)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Uint32 dwIndex, Float fLevel,
                              Pointer<GUID> EventContext)>>>()
              .value
              .asFunction<
                  int Function(Pointer, int dwIndex, double fLevel,
                      Pointer<GUID> EventContext)>()(
          ptr.ref.lpVtbl, dwIndex, fLevel, EventContext);

  int getChannelVolume(int dwIndex, Pointer<Float> pfLevel) => ptr.ref.vtable
          .elementAt(5)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(
                          Pointer, Uint32 dwIndex, Pointer<Float> pfLevel)>>>()
          .value
          .asFunction<
              int Function(Pointer, int dwIndex, Pointer<Float> pfLevel)>()(
      ptr.ref.lpVtbl, dwIndex, pfLevel);

  int setAllVolumes(
          int dwCount, Pointer<Float> pfVolumes, Pointer<GUID> EventContext) =>
      ptr.ref.vtable
              .elementAt(6)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Uint32 dwCount,
                              Pointer<Float> pfVolumes,
                              Pointer<GUID> EventContext)>>>()
              .value
              .asFunction<
                  int Function(Pointer, int dwCount, Pointer<Float> pfVolumes,
                      Pointer<GUID> EventContext)>()(
          ptr.ref.lpVtbl, dwCount, pfVolumes, EventContext);

  int getAllVolumes(int dwCount, Pointer<Float> pfVolumes) => ptr.ref.vtable
      .elementAt(7)
      .cast<
          Pointer<
              NativeFunction<
                  Int32 Function(
                      Pointer, Uint32 dwCount, Pointer<Float> pfVolumes)>>>()
      .value
      .asFunction<
          int Function(Pointer, int dwCount,
              Pointer<Float> pfVolumes)>()(ptr.ref.lpVtbl, dwCount, pfVolumes);
}
