// iwbemclassobject.dart

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
const IID_IWbemClassObject = '{DC12A681-737F-11CF-884D-00AA004B2E24}';

/// {@category Interface}
/// {@category com}
class IWbemClassObject extends IUnknown {
  // vtable begins at 3, is 24 entries long.
  IWbemClassObject(super.ptr);

  int GetQualifierSet(Pointer<Pointer<COMObject>> ppQualSet) => ptr.ref.vtable
          .elementAt(3)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(
                          Pointer, Pointer<Pointer<COMObject>> ppQualSet)>>>()
          .value
          .asFunction<
              int Function(Pointer, Pointer<Pointer<COMObject>> ppQualSet)>()(
      ptr.ref.lpVtbl, ppQualSet);

  int Get(Pointer<Utf16> wszName, int lFlags, Pointer<VARIANT> pVal,
          Pointer<Int32> pType, Pointer<Int32> plFlavor) =>
      ptr.ref.vtable
              .elementAt(4)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Pointer<Utf16> wszName,
                              Int32 lFlags,
                              Pointer<VARIANT> pVal,
                              Pointer<Int32> pType,
                              Pointer<Int32> plFlavor)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      Pointer<Utf16> wszName,
                      int lFlags,
                      Pointer<VARIANT> pVal,
                      Pointer<Int32> pType,
                      Pointer<Int32> plFlavor)>()(
          ptr.ref.lpVtbl, wszName, lFlags, pVal, pType, plFlavor);

  int Put(Pointer<Utf16> wszName, int lFlags, Pointer<VARIANT> pVal,
          int Type) =>
      ptr.ref.vtable
          .elementAt(5)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Utf16> wszName,
                          Int32 lFlags, Pointer<VARIANT> pVal, Int32 Type)>>>()
          .value
          .asFunction<
              int Function(
                  Pointer,
                  Pointer<Utf16> wszName,
                  int lFlags,
                  Pointer<VARIANT> pVal,
                  int Type)>()(ptr.ref.lpVtbl, wszName, lFlags, pVal, Type);

  int Delete(Pointer<Utf16> wszName) => ptr.ref.vtable
          .elementAt(6)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Utf16> wszName)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Utf16> wszName)>()(
      ptr.ref.lpVtbl, wszName);

  int GetNames(Pointer<Utf16> wszQualifierName, int lFlags,
          Pointer<VARIANT> pQualifierVal, Pointer<Pointer<SAFEARRAY>> pNames) =>
      ptr.ref.vtable
              .elementAt(7)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Pointer<Utf16> wszQualifierName,
                              Int32 lFlags,
                              Pointer<VARIANT> pQualifierVal,
                              Pointer<Pointer<SAFEARRAY>> pNames)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      Pointer<Utf16> wszQualifierName,
                      int lFlags,
                      Pointer<VARIANT> pQualifierVal,
                      Pointer<Pointer<SAFEARRAY>> pNames)>()(
          ptr.ref.lpVtbl, wszQualifierName, lFlags, pQualifierVal, pNames);

  int BeginEnumeration(int lEnumFlags) => ptr.ref.vtable
      .elementAt(8)
      .cast<
          Pointer<NativeFunction<Int32 Function(Pointer, Int32 lEnumFlags)>>>()
      .value
      .asFunction<
          int Function(Pointer, int lEnumFlags)>()(ptr.ref.lpVtbl, lEnumFlags);

  int Next(int lFlags, Pointer<Pointer<Utf16>> strName, Pointer<VARIANT> pVal,
          Pointer<Int32> pType, Pointer<Int32> plFlavor) =>
      ptr.ref.vtable
              .elementAt(9)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Int32 lFlags,
                              Pointer<Pointer<Utf16>> strName,
                              Pointer<VARIANT> pVal,
                              Pointer<Int32> pType,
                              Pointer<Int32> plFlavor)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      int lFlags,
                      Pointer<Pointer<Utf16>> strName,
                      Pointer<VARIANT> pVal,
                      Pointer<Int32> pType,
                      Pointer<Int32> plFlavor)>()(
          ptr.ref.lpVtbl, lFlags, strName, pVal, pType, plFlavor);

  int EndEnumeration() => ptr.ref.vtable
      .elementAt(10)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer)>>>()
      .value
      .asFunction<int Function(Pointer)>()(ptr.ref.lpVtbl);

  int GetPropertyQualifierSet(
          Pointer<Utf16> wszProperty, Pointer<Pointer<COMObject>> ppQualSet) =>
      ptr.ref.vtable
              .elementAt(11)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Pointer<Utf16> wszProperty,
                              Pointer<Pointer<COMObject>> ppQualSet)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer<Utf16> wszProperty,
                      Pointer<Pointer<COMObject>> ppQualSet)>()(
          ptr.ref.lpVtbl, wszProperty, ppQualSet);

  int Clone(Pointer<Pointer<COMObject>> ppCopy) => ptr.ref.vtable
          .elementAt(12)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(
                          Pointer, Pointer<Pointer<COMObject>> ppCopy)>>>()
          .value
          .asFunction<
              int Function(Pointer, Pointer<Pointer<COMObject>> ppCopy)>()(
      ptr.ref.lpVtbl, ppCopy);

  int GetObjectText(int lFlags, Pointer<Pointer<Utf16>> pstrObjectText) =>
      ptr.ref.vtable
              .elementAt(13)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Int32 lFlags,
                              Pointer<Pointer<Utf16>> pstrObjectText)>>>()
              .value
              .asFunction<
                  int Function(Pointer, int lFlags,
                      Pointer<Pointer<Utf16>> pstrObjectText)>()(
          ptr.ref.lpVtbl, lFlags, pstrObjectText);

  int SpawnDerivedClass(int lFlags, Pointer<Pointer<COMObject>> ppNewClass) =>
      ptr.ref.vtable
              .elementAt(14)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Int32 lFlags,
                              Pointer<Pointer<COMObject>> ppNewClass)>>>()
              .value
              .asFunction<
                  int Function(Pointer, int lFlags,
                      Pointer<Pointer<COMObject>> ppNewClass)>()(
          ptr.ref.lpVtbl, lFlags, ppNewClass);

  int SpawnInstance(int lFlags, Pointer<Pointer<COMObject>> ppNewInstance) =>
      ptr.ref.vtable
              .elementAt(15)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Int32 lFlags,
                              Pointer<Pointer<COMObject>> ppNewInstance)>>>()
              .value
              .asFunction<
                  int Function(Pointer, int lFlags,
                      Pointer<Pointer<COMObject>> ppNewInstance)>()(
          ptr.ref.lpVtbl, lFlags, ppNewInstance);

  int CompareTo(int lFlags, Pointer<COMObject> pCompareTo) => ptr.ref.vtable
          .elementAt(16)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Int32 lFlags,
                          Pointer<COMObject> pCompareTo)>>>()
          .value
          .asFunction<
              int Function(
                  Pointer, int lFlags, Pointer<COMObject> pCompareTo)>()(
      ptr.ref.lpVtbl, lFlags, pCompareTo);

  int GetPropertyOrigin(
          Pointer<Utf16> wszName, Pointer<Pointer<Utf16>> pstrClassName) =>
      ptr.ref.vtable
              .elementAt(17)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Pointer<Utf16> wszName,
                              Pointer<Pointer<Utf16>> pstrClassName)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer<Utf16> wszName,
                      Pointer<Pointer<Utf16>> pstrClassName)>()(
          ptr.ref.lpVtbl, wszName, pstrClassName);

  int InheritsFrom(Pointer<Utf16> strAncestor) => ptr.ref.vtable
          .elementAt(18)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Utf16> strAncestor)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Utf16> strAncestor)>()(
      ptr.ref.lpVtbl, strAncestor);

  int GetMethod(
          Pointer<Utf16> wszName,
          int lFlags,
          Pointer<Pointer<COMObject>> ppInSignature,
          Pointer<Pointer<COMObject>> ppOutSignature) =>
      ptr.ref.vtable
              .elementAt(19)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Pointer<Utf16> wszName,
                              Int32 lFlags,
                              Pointer<Pointer<COMObject>> ppInSignature,
                              Pointer<Pointer<COMObject>> ppOutSignature)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      Pointer<Utf16> wszName,
                      int lFlags,
                      Pointer<Pointer<COMObject>> ppInSignature,
                      Pointer<Pointer<COMObject>> ppOutSignature)>()(
          ptr.ref.lpVtbl, wszName, lFlags, ppInSignature, ppOutSignature);

  int PutMethod(Pointer<Utf16> wszName, int lFlags,
          Pointer<COMObject> pInSignature, Pointer<COMObject> pOutSignature) =>
      ptr.ref.vtable
              .elementAt(20)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Pointer<Utf16> wszName,
                              Int32 lFlags,
                              Pointer<COMObject> pInSignature,
                              Pointer<COMObject> pOutSignature)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      Pointer<Utf16> wszName,
                      int lFlags,
                      Pointer<COMObject> pInSignature,
                      Pointer<COMObject> pOutSignature)>()(
          ptr.ref.lpVtbl, wszName, lFlags, pInSignature, pOutSignature);

  int DeleteMethod(Pointer<Utf16> wszName) => ptr.ref.vtable
          .elementAt(21)
          .cast<
              Pointer<
                  NativeFunction<
                      Int32 Function(Pointer, Pointer<Utf16> wszName)>>>()
          .value
          .asFunction<int Function(Pointer, Pointer<Utf16> wszName)>()(
      ptr.ref.lpVtbl, wszName);

  int BeginMethodEnumeration(int lEnumFlags) => ptr.ref.vtable
      .elementAt(22)
      .cast<
          Pointer<NativeFunction<Int32 Function(Pointer, Int32 lEnumFlags)>>>()
      .value
      .asFunction<
          int Function(Pointer, int lEnumFlags)>()(ptr.ref.lpVtbl, lEnumFlags);

  int NextMethod(
          int lFlags,
          Pointer<Pointer<Utf16>> pstrName,
          Pointer<Pointer<COMObject>> ppInSignature,
          Pointer<Pointer<COMObject>> ppOutSignature) =>
      ptr.ref.vtable
              .elementAt(23)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(
                              Pointer,
                              Int32 lFlags,
                              Pointer<Pointer<Utf16>> pstrName,
                              Pointer<Pointer<COMObject>> ppInSignature,
                              Pointer<Pointer<COMObject>> ppOutSignature)>>>()
              .value
              .asFunction<
                  int Function(
                      Pointer,
                      int lFlags,
                      Pointer<Pointer<Utf16>> pstrName,
                      Pointer<Pointer<COMObject>> ppInSignature,
                      Pointer<Pointer<COMObject>> ppOutSignature)>()(
          ptr.ref.lpVtbl, lFlags, pstrName, ppInSignature, ppOutSignature);

  int EndMethodEnumeration() => ptr.ref.vtable
      .elementAt(24)
      .cast<Pointer<NativeFunction<Int32 Function(Pointer)>>>()
      .value
      .asFunction<int Function(Pointer)>()(ptr.ref.lpVtbl);

  int GetMethodQualifierSet(
          Pointer<Utf16> wszMethod, Pointer<Pointer<COMObject>> ppQualSet) =>
      ptr.ref.vtable
              .elementAt(25)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Pointer<Utf16> wszMethod,
                              Pointer<Pointer<COMObject>> ppQualSet)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer<Utf16> wszMethod,
                      Pointer<Pointer<COMObject>> ppQualSet)>()(
          ptr.ref.lpVtbl, wszMethod, ppQualSet);

  int GetMethodOrigin(Pointer<Utf16> wszMethodName,
          Pointer<Pointer<Utf16>> pstrClassName) =>
      ptr.ref.vtable
              .elementAt(26)
              .cast<
                  Pointer<
                      NativeFunction<
                          Int32 Function(Pointer, Pointer<Utf16> wszMethodName,
                              Pointer<Pointer<Utf16>> pstrClassName)>>>()
              .value
              .asFunction<
                  int Function(Pointer, Pointer<Utf16> wszMethodName,
                      Pointer<Pointer<Utf16>> pstrClassName)>()(
          ptr.ref.lpVtbl, wszMethodName, pstrClassName);
}

/// @nodoc
const CLSID_WbemClassObject = '{9A653086-174F-11D2-B5F9-00104B703EFD}';

/// {@category com}
class WbemClassObject extends IWbemClassObject {
  WbemClassObject(super.ptr);

  factory WbemClassObject.createInstance() => WbemClassObject(
      COMObject.createFromID(CLSID_WbemClassObject, IID_IWbemClassObject));
}
