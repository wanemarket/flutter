// ispvoice.dart

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

import 'ispeventsource.dart';

/// @nodoc
const IID_ISpVoice = '{6C44DF74-72B9-4992-A1EC-EF996E0422D4}';

/// {@category Interface}
/// {@category com}
class ISpVoice extends ISpEventSource {
  // vtable begins at 13, is 25 entries long.
  ISpVoice(super.ptr);

  int SetOutput(Pointer<COMObject> pUnkOutput, int fAllowFormatChanges) =>
      ptr.ref.vtable
              .elementAt(13)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Pointer<COMObject> pUnkOutput,
                              Int32 fAllowFormatChanges)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer<COMObject> pUnkOutput,
                      int fAllowFormatChanges)>()(
          ptr.ref.lpVtbl, pUnkOutput, fAllowFormatChanges);

  int GetOutputObjectToken(Pointer<Pointer<COMObject>> ppObjectToken) =>
      ptr.ref.vtable
              .elementAt(14)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer,
                              Pointer<Pointer<COMObject>> ppObjectToken)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer, Pointer<Pointer<COMObject>> ppObjectToken)>()(
          ptr.ref.lpVtbl, ppObjectToken);

  int GetOutputStream(Pointer<Pointer<COMObject>> ppStream) => ptr.ref.vtable
          .elementAt(15)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(
                          Pointer, Pointer<Pointer<COMObject>> ppStream)>>>()
          .value
          .asFunction<
              int Function(Pointer, Pointer<Pointer<COMObject>> ppStream)>()(
      ptr.ref.lpVtbl, ppStream);

  int Pause() => ptr.ref.vtable
      .elementAt(16)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer)>>>()
      .value
      .asFunction<int Function(Pointer)>()(ptr.ref.lpVtbl);

  int Resume() => ptr.ref.vtable
      .elementAt(17)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer)>>>()
      .value
      .asFunction<int Function(Pointer)>()(ptr.ref.lpVtbl);

  int SetVoice(Pointer<COMObject> pToken) => ptr.ref.vtable
          .elementAt(18)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<COMObject> pToken)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<COMObject> pToken)>()(
      ptr.ref.lpVtbl, pToken);

  int GetVoice(Pointer<Pointer<COMObject>> ppToken) => ptr.ref.vtable
          .elementAt(19)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(
                          Pointer, Pointer<Pointer<COMObject>> ppToken)>>>()
          .value
          .asFunction<
              int Function(Pointer, Pointer<Pointer<COMObject>> ppToken)>()(
      ptr.ref.lpVtbl, ppToken);

  int
      Speak(Pointer<Utf16> pwcs, int dwFlags,
              Pointer<Uint32> pulStreamNumber) =>
          ptr.ref.vtable
                  .elementAt(20)
                  .cast<
                      Pointer<
                          NativeFunction<
                              Int32 Function(
                                  Pointer,
                                  Pointer<Utf16> pwcs,
                                  Uint32 dwFlags,
                                  Pointer<Uint32> pulStreamNumber)>>>()
                  .value
                  .asFunction<
                      int Function(Pointer, Pointer<Utf16> pwcs, int dwFlags,
                          Pointer<Uint32> pulStreamNumber)>()(
              ptr.ref.lpVtbl, pwcs, dwFlags, pulStreamNumber);

  int
      SpeakStream(Pointer<COMObject> pStream, int dwFlags,
              Pointer<Uint32> pulStreamNumber) =>
          ptr.ref.vtable
                  .elementAt(21)
                  .cast<
                      Pointer<
                          NativeFunction<
                              Int32 Function(
                                  Pointer,
                                  Pointer<COMObject> pStream,
                                  Uint32 dwFlags,
                                  Pointer<Uint32> pulStreamNumber)>>>()
                  .value
                  .asFunction<
                      int Function(Pointer, Pointer<COMObject> pStream,
                          int dwFlags, Pointer<Uint32> pulStreamNumber)>()(
              ptr.ref.lpVtbl, pStream, dwFlags, pulStreamNumber);

  int
      GetStatus(Pointer<SPVOICESTATUS> pStatus,
              Pointer<Pointer<Utf16>> ppszLastBookmark) =>
          ptr.ref.vtable
                  .elementAt(22)
                  .cast<
                      Pointer<
                          NativeFunction<
                              Int32 Function(
                                  Pointer,
                                  Pointer<SPVOICESTATUS> pStatus,
                                  Pointer<Pointer<Utf16>> ppszLastBookmark)>>>()
                  .value
                  .asFunction<
                      int Function(Pointer, Pointer<SPVOICESTATUS> pStatus,
                          Pointer<Pointer<Utf16>> ppszLastBookmark)>()(
              ptr.ref.lpVtbl, pStatus, ppszLastBookmark);

  int
      Skip(Pointer<Utf16> pItemType, int lNumItems,
              Pointer<Uint32> pulNumSkipped) =>
          ptr.ref.vtable
                  .elementAt(23)
                  .cast<
                      Pointer<
                          NativeFunction<
                              Int32 Function(
                                  Pointer,
                                  Pointer<Utf16> pItemType,
                                  Int32 lNumItems,
                                  Pointer<Uint32> pulNumSkipped)>>>()
                  .value
                  .asFunction<
                      int Function(Pointer, Pointer<Utf16> pItemType,
                          int lNumItems, Pointer<Uint32> pulNumSkipped)>()(
              ptr.ref.lpVtbl, pItemType, lNumItems, pulNumSkipped);

  int SetPriority(int ePriority) => ptr.ref.vtable
      .elementAt(24)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer, Int32 ePriority)>>>()
      .value
      .asFunction<
          int Function(Pointer, int ePriority)>()(ptr.ref.lpVtbl, ePriority);

  int GetPriority(Pointer<Int32> pePriority) => ptr.ref.vtable
          .elementAt(25)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Int32> pePriority)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Int32> pePriority)>()(
      ptr.ref.lpVtbl, pePriority);

  int SetAlertBoundary(int eBoundary) => ptr.ref.vtable
      .elementAt(26)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer, Int32 eBoundary)>>>()
      .value
      .asFunction<
          int Function(Pointer, int eBoundary)>()(ptr.ref.lpVtbl, eBoundary);

  int GetAlertBoundary(Pointer<Int32> peBoundary) => ptr.ref.vtable
          .elementAt(27)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Int32> peBoundary)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Int32> peBoundary)>()(
      ptr.ref.lpVtbl, peBoundary);

  int SetRate(int RateAdjust) => ptr.ref.vtable
      .elementAt(28)
      .cast<
          Pointer<NativeFunction<Int32 Function(Pointer, Int32 RateAdjust)>>>()
      .value
      .asFunction<
          int Function(Pointer, int RateAdjust)>()(ptr.ref.lpVtbl, RateAdjust);

  int GetRate(Pointer<Int32> pRateAdjust) => ptr.ref.vtable
          .elementAt(29)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Int32> pRateAdjust)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Int32> pRateAdjust)>()(
      ptr.ref.lpVtbl, pRateAdjust);

  int SetVolume(int usVolume) => ptr.ref.vtable
      .elementAt(30)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer, Uint16 usVolume)>>>()
      .value
      .asFunction<
          int Function(Pointer, int usVolume)>()(ptr.ref.lpVtbl, usVolume);

  int GetVolume(Pointer<Uint16> pusVolume) => ptr.ref.vtable
          .elementAt(31)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Uint16> pusVolume)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Uint16> pusVolume)>()(
      ptr.ref.lpVtbl, pusVolume);

  int WaitUntilDone(int msTimeout) => ptr.ref.vtable
      .elementAt(32)
      .cast<
          Pointer<NativeFunction<Int32 Function(Pointer, Uint32 msTimeout)>>>()
      .value
      .asFunction<
          int Function(Pointer, int msTimeout)>()(ptr.ref.lpVtbl, msTimeout);

  int SetSyncSpeakTimeout(int msTimeout) => ptr.ref.vtable
      .elementAt(33)
      .cast<
          Pointer<NativeFunction<Int32 Function(Pointer, Uint32 msTimeout)>>>()
      .value
      .asFunction<
          int Function(Pointer, int msTimeout)>()(ptr.ref.lpVtbl, msTimeout);

  int GetSyncSpeakTimeout(Pointer<Uint32> pmsTimeout) => ptr.ref.vtable
          .elementAt(34)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Uint32> pmsTimeout)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Uint32> pmsTimeout)>()(
      ptr.ref.lpVtbl, pmsTimeout);

  int SpeakCompleteEvent() => ptr.ref.vtable
      .elementAt(35)
      .cast<Pointer<NativeFunction<IntPtr Function(Pointer)>>>()
      .value
      .asFunction<int Function(Pointer)>()(ptr.ref.lpVtbl);

  int IsUISupported(Pointer<Utf16> pszTypeOfUI, Pointer pvExtraData,
          int cbExtraData, Pointer<Int32> pfSupported) =>
      ptr.ref.vtable
              .elementAt(36)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Pointer<Utf16> pszTypeOfUI,
                              Pointer pvExtraData,
                              Uint32 cbExtraData,
                              Pointer<Int32> pfSupported)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      Pointer<Utf16> pszTypeOfUI,
                      Pointer pvExtraData,
                      int cbExtraData,
                      Pointer<Int32> pfSupported)>()(
          ptr.ref.lpVtbl, pszTypeOfUI, pvExtraData, cbExtraData, pfSupported);

  int DisplayUI(int hwndParent, Pointer<Utf16> pszTitle,
          Pointer<Utf16> pszTypeOfUI, Pointer pvExtraData, int cbExtraData) =>
      ptr.ref.vtable
              .elementAt(37)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              IntPtr hwndParent,
                              Pointer<Utf16> pszTitle,
                              Pointer<Utf16> pszTypeOfUI,
                              Pointer pvExtraData,
                              Uint32 cbExtraData)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      int hwndParent,
                      Pointer<Utf16> pszTitle,
                      Pointer<Utf16> pszTypeOfUI,
                      Pointer pvExtraData,
                      int cbExtraData)>()(ptr.ref.lpVtbl, hwndParent, pszTitle,
          pszTypeOfUI, pvExtraData, cbExtraData);
}

/// @nodoc
const CLSID_SpVoice = '{96749377-3391-11D2-9EE3-00C04F797396}';

/// {@category com}
class SpVoice extends ISpVoice {
  SpVoice(super.ptr);

  factory SpVoice.createInstance() =>
      SpVoice(COMObject.createFromID(CLSID_SpVoice, IID_ISpVoice));
}
