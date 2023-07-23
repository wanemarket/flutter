@TestOn('windows')

import 'package:ffi/ffi.dart';
import 'package:test/test.dart';
import 'package:win32/winrt.dart';

void main() {
  if (isWindowsRuntimeAvailable()) {
    test('WinRT initialization should succeed', () {
      final hr = RoInitialize(RO_INIT_TYPE.RO_INIT_MULTITHREADED);
      expect(hr, equals(S_OK));
      RoUninitialize();
    });

    test('WinRT double initialization should succeed with warning', () {
      final hr = RoInitialize(RO_INIT_TYPE.RO_INIT_MULTITHREADED);
      expect(SUCCEEDED(hr), isTrue);
      expect(hr, equals(S_OK));

      final hr2 = RoInitialize(RO_INIT_TYPE.RO_INIT_MULTITHREADED);
      expect(SUCCEEDED(hr2), isTrue);
      expect(hr2, equals(S_FALSE));

      // Balance out uninitialization. This is deliberately called twice.
      RoUninitialize();
      RoUninitialize();
    });

    test('WinRT change of threading model should fail', () {
      final hr = RoInitialize(RO_INIT_TYPE.RO_INIT_MULTITHREADED);
      expect(SUCCEEDED(hr), isTrue);
      expect(hr, equals(S_OK));

      final hr2 = RoInitialize(RO_INIT_TYPE.RO_INIT_SINGLETHREADED);
      expect(FAILED(hr2), isTrue);
      expect(hr2, equals(RPC_E_CHANGED_MODE));

      // Balance out uninitialization. This is deliberately only called once,
      // because it only succeeded once.
      RoUninitialize();
    });

    test('WinRT basic test', () {
      winrtInitialize();

      final calendar = Calendar();

      expect(calendar.year, greaterThanOrEqualTo(2020));
      free(calendar.ptr);
      winrtUninitialize();
    });

    test('WinRT getIids test', () {
      winrtInitialize();

      const iids = [
        '{ca30221d-86d9-40fb-a26b-d44eb7cf08ea}', // ICalendar
        '{00000038-0000-0000-c000-000000000046}', // IWeakReferenceSource
        '{bb3c25e5-46cf-4317-a3f5-02621ad54478}', // ITimeZoneOnCalendar
        '{0ca51cc6-17cf-4642-b08e-473dcc3ca3ef}'
      ];

      final calendar = Calendar();

      expect(calendar.iids, equals(iids));

      free(calendar.ptr);
      winrtUninitialize();
    });

    test('WinRT getRuntimeClassName test', () {
      winrtInitialize();

      const calendarClassName = 'Windows.Globalization.Calendar';

      using((Arena arena) {
        final calendar = Calendar(allocator: arena);
        expect(calendar.runtimeClassName, equals(calendarClassName));
      });

      winrtUninitialize();
    });

    test('WinRT getTrustLevel test of base trust class', () {
      winrtInitialize();

      using((Arena arena) {
        final calendar = Calendar(allocator: arena);
        expect(calendar.trustLevel, equals(TrustLevel.baseTrust));
      });
      winrtUninitialize();
    });

    test('WinRT getTrustLevel test of partial trust class', () {
      winrtInitialize();

      const className = 'Windows.Storage.Pickers.FileOpenPicker';

      final object = CreateObject(className, IID_IInspectable);
      final inspectableObject = IInspectable(object);

      expect(inspectableObject.trustLevel, equals(TrustLevel.partialTrust));

      free(object);
      winrtUninitialize();
    });
  }
}
