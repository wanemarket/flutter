// Copyright (c) 2018, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/error/codes.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'context_collection_resolution.dart';

main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(PropertyAccessResolutionTest);
    defineReflectiveTests(PropertyAccessResolutionWithoutNullSafetyTest);
  });
}

@reflectiveTest
class PropertyAccessResolutionTest extends PubPackageResolutionTest
    with PropertyAccessResolutionTestCases {
  test_implicitCall_tearOff_nullable() async {
    await assertErrorsInCode('''
class A {
  int call() => 0;
}

class B {
  A? a;
}

int Function() foo() {
  return B().a; // ref
}
''', [
      error(CompileTimeErrorCode.RETURN_OF_INVALID_TYPE_FROM_FUNCTION, 85, 5),
    ]);

    var identifier = findNode.simple('a; // ref');
    assertElement(identifier, findElement.getter('a'));
    assertType(identifier, 'A?');
  }

  test_nullShorting_cascade() async {
    await assertNoErrorsInCode(r'''
class A {
  int get foo => 0;
  int get bar => 0;
}

void f(A? a) {
  a?..foo..bar;
}
''');

    assertPropertyAccess2(
      findNode.propertyAccess('..foo'),
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('..bar'),
      element: findElement.getter('bar'),
      type: 'int',
    );

    assertType(findNode.cascade('a?'), 'A?');
  }

  test_nullShorting_cascade2() async {
    await assertNoErrorsInCode(r'''
class A {
  int? get foo => 0;
}

main() {
  A a = A()..foo?.isEven;
  a;
}
''');

    assertPropertyAccess2(
      findNode.propertyAccess('..foo?'),
      element: findElement.getter('foo'),
      type: 'int?',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('.isEven'),
      element: intElement.getGetter('isEven'),
      type: 'bool',
    );

    assertType(findNode.cascade('A()'), 'A');
  }

  test_nullShorting_cascade3() async {
    await assertNoErrorsInCode(r'''
class A {
  A? get foo => this;
  A? get bar => this;
  A? get baz => this;
}

main() {
  A a = A()..foo?.bar?.baz;
  a;
}
''');

    assertPropertyAccess2(
      findNode.propertyAccess('.foo'),
      element: findElement.getter('foo'),
      type: 'A?',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('.bar'),
      element: findElement.getter('bar'),
      type: 'A?',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('.baz'),
      element: findElement.getter('baz'),
      type: 'A?',
    );

    assertType(findNode.cascade('A()'), 'A');
  }

  test_nullShorting_cascade4() async {
    await assertNoErrorsInCode(r'''
A? get foo => A();

class A {
  A get bar => this;
  A? get baz => this;
  A get baq => this;
}

main() {
  foo?.bar?..baz?.baq;
}
''');

    assertSimpleIdentifier(
      findNode.simple('foo?'),
      element: findElement.topGet('foo'),
      type: 'A?',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('.bar'),
      element: findElement.getter('bar'),
      type: 'A?',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('.baz'),
      element: findElement.getter('baz'),
      type: 'A?',
    );

    assertPropertyAccess2(
      findNode.propertyAccess('.baq'),
      element: findElement.getter('baq'),
      type: 'A',
    );

    assertType(findNode.cascade('foo?'), 'A?');
  }

  test_ofEnum_read() async {
    await assertNoErrorsInCode('''
enum E {
  v;
  int get foo => 0;
}

void f(E e) {
  (e).foo;
}
''');

    var propertyAccess = findNode.propertyAccess('foo;');
    assertPropertyAccess2(
      propertyAccess,
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: findElement.getter('foo'),
      type: 'int',
    );
  }

  test_ofEnum_read_fromMixin() async {
    await assertNoErrorsInCode('''
mixin M on Enum {
  int get foo => 0;
}

enum E with M {
  v;
}

void f(E e) {
  (e).foo;
}
''');

    var propertyAccess = findNode.propertyAccess('foo;');
    assertPropertyAccess2(
      propertyAccess,
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: findElement.getter('foo'),
      type: 'int',
    );
  }

  test_ofEnum_write() async {
    await assertNoErrorsInCode('''
enum E {
  v;
  set foo(int _) {}
}

void f(E e) {
  (e).foo = 1;
}
''');

    var assignment = findNode.assignment('foo = 1');
    assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: ParenthesizedExpression
      leftParenthesis: (
      expression: SimpleIdentifier
        token: e
        staticElement: self::@function::f::@parameter::e
        staticType: E
      rightParenthesis: )
      staticType: E
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@enum::E::@setter::foo::@parameter::_
    staticType: int
  readElement: <null>
  readType: null
  writeElement: self::@enum::E::@setter::foo
  writeType: int
  staticElement: <null>
  staticType: int
''');
  }
}

mixin PropertyAccessResolutionTestCases on PubPackageResolutionTest {
  test_extensionOverride_read() async {
    await assertNoErrorsInCode('''
class A {}

extension E on A {
  int get foo => 0;
}

void f(A a) {
  E(a).foo;
}
''');

    var propertyAccess = findNode.propertyAccess('foo;');
    assertPropertyAccess2(
      propertyAccess,
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: findElement.getter('foo'),
      type: 'int',
    );
  }

  test_extensionOverride_readWrite_assignment() async {
    await assertNoErrorsInCode('''
class A {}

extension E on A {
  int get foo => 0;
  set foo(num _) {}
}

void f(A a) {
  E(a).foo += 1;
}
''');

    var assignment = findNode.assignment('foo += 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: ExtensionOverride
      extensionName: SimpleIdentifier
        token: E
        staticElement: self::@extension::E
        staticType: null
      argumentList: ArgumentList
        leftParenthesis: (
        arguments
          SimpleIdentifier
            token: a
            parameter: <null>
            staticElement: self::@function::f::@parameter::a
            staticType: A
        rightParenthesis: )
      extendedType: A
      staticType: null
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: dart:core::@class::num::@method::+::@parameter::other
    staticType: int
  readElement: self::@extension::E::@getter::foo
  readType: int
  writeElement: self::@extension::E::@setter::foo
  writeType: num
  staticElement: dart:core::@class::num::@method::+
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: ExtensionOverride
      extensionName: SimpleIdentifier
        token: E
        staticElement: self::@extension::E
        staticType: null
      argumentList: ArgumentList
        leftParenthesis: (
        arguments
          SimpleIdentifier
            token: a
            parameter: <null>
            staticElement: self::@function::f::@parameter::a
            staticType: A*
        rightParenthesis: )
      extendedType: A*
      staticType: null
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: ParameterMember
      base: dart:core::@class::num::@method::+::@parameter::other
      isLegacy: true
    staticType: int*
  readElement: self::@extension::E::@getter::foo
  readType: int*
  writeElement: self::@extension::E::@setter::foo
  writeType: num*
  staticElement: MethodMember
    base: dart:core::@class::num::@method::+
    isLegacy: true
  staticType: int*
''');
    }
  }

  test_extensionOverride_write() async {
    await assertNoErrorsInCode('''
class A {}

extension E on A {
  set foo(int _) {}
}

void f(A a) {
  E(a).foo = 1;
}
''');

    var assignment = findNode.assignment('foo = 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: ExtensionOverride
      extensionName: SimpleIdentifier
        token: E
        staticElement: self::@extension::E
        staticType: null
      argumentList: ArgumentList
        leftParenthesis: (
        arguments
          SimpleIdentifier
            token: a
            parameter: <null>
            staticElement: self::@function::f::@parameter::a
            staticType: A
        rightParenthesis: )
      extendedType: A
      staticType: null
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@extension::E::@setter::foo::@parameter::_
    staticType: int
  readElement: <null>
  readType: null
  writeElement: self::@extension::E::@setter::foo
  writeType: int
  staticElement: <null>
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: ExtensionOverride
      extensionName: SimpleIdentifier
        token: E
        staticElement: self::@extension::E
        staticType: null
      argumentList: ArgumentList
        leftParenthesis: (
        arguments
          SimpleIdentifier
            token: a
            parameter: <null>
            staticElement: self::@function::f::@parameter::a
            staticType: A*
        rightParenthesis: )
      extendedType: A*
      staticType: null
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@extension::E::@setter::foo::@parameter::_
    staticType: int*
  readElement: <null>
  readType: null
  writeElement: self::@extension::E::@setter::foo
  writeType: int*
  staticElement: <null>
  staticType: int*
''');
    }
  }

  test_functionType_call_read() async {
    await assertNoErrorsInCode('''
void f(int Function(String) a) {
  (a).call;
}
''');

    assertPropertyAccess2(
      findNode.propertyAccess('call;'),
      element: null,
      type: 'int Function(String)',
    );
  }

  test_instanceCreation_read() async {
    await assertNoErrorsInCode('''
class A {
  int foo = 0;
}

void f() {
  A().foo;
}
''');

    var propertyAccess = findNode.propertyAccess('foo;');
    assertPropertyAccess2(
      propertyAccess,
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: findElement.getter('foo'),
      type: 'int',
    );
  }

  test_instanceCreation_readWrite_assignment() async {
    await assertNoErrorsInCode('''
class A {
  int foo = 0;
}

void f() {
  A().foo += 1;
}
''');

    var assignment = findNode.assignment('foo += 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: dart:core::@class::num::@method::+::@parameter::other
    staticType: int
  readElement: self::@class::A::@getter::foo
  readType: int
  writeElement: self::@class::A::@setter::foo
  writeType: int
  staticElement: dart:core::@class::num::@method::+
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A*
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A*
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: ParameterMember
      base: dart:core::@class::num::@method::+::@parameter::other
      isLegacy: true
    staticType: int*
  readElement: self::@class::A::@getter::foo
  readType: int*
  writeElement: self::@class::A::@setter::foo
  writeType: int*
  staticElement: MethodMember
    base: dart:core::@class::num::@method::+
    isLegacy: true
  staticType: int*
''');
    }
  }

  test_instanceCreation_write() async {
    await assertNoErrorsInCode('''
class A {
  int foo = 0;
}

void f() {
  A().foo = 1;
}
''');

    var assignment = findNode.assignment('foo = 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@class::A::@setter::foo::@parameter::_foo
    staticType: int
  readElement: <null>
  readType: null
  writeElement: self::@class::A::@setter::foo
  writeType: int
  staticElement: <null>
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A*
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A*
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@class::A::@setter::foo::@parameter::_foo
    staticType: int*
  readElement: <null>
  readType: null
  writeElement: self::@class::A::@setter::foo
  writeType: int*
  staticElement: <null>
  staticType: int*
''');
    }
  }

  test_invalid_inDefaultValue_nullAware() async {
    await assertInvalidTestCode('''
void f({a = b?.foo}) {}
''');

    assertPropertyAccess2(
      findNode.propertyAccess('?.foo'),
      element: null,
      type: 'dynamic',
    );
  }

  test_invalid_inDefaultValue_nullAware2() async {
    await assertInvalidTestCode('''
typedef void F({a = b?.foo});
''');

    assertPropertyAccess2(
      findNode.propertyAccess('?.foo'),
      element: null,
      type: 'dynamic',
    );
  }

  test_invalid_inDefaultValue_nullAware_cascade() async {
    await assertInvalidTestCode('''
void f({a = b?..foo}) {}
''');

    assertPropertyAccess2(
      findNode.propertyAccess('?..foo'),
      element: null,
      type: 'dynamic',
    );
  }

  test_ofDynamic_read_hash() async {
    await assertNoErrorsInCode('''
void f(dynamic a) {
  (a).hash;
}
''');

    var propertyAccess = findNode.propertyAccess('hash;');
    assertPropertyAccess2(
      propertyAccess,
      element: null,
      type: 'dynamic',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: null,
      type: 'dynamic',
    );
  }

  test_ofDynamic_read_hashCode() async {
    await assertNoErrorsInCode('''
void f(dynamic a) {
  (a).hashCode;
}
''');

    var hashCodeElement = elementMatcher(
      objectElement.getGetter('hashCode'),
      isLegacy: isLegacyLibrary,
    );

    var propertyAccess = findNode.propertyAccess('hashCode;');
    assertPropertyAccess2(
      propertyAccess,
      element: hashCodeElement,
      type: 'int',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: hashCodeElement,
      type: 'int',
    );
  }

  test_ofDynamic_read_runtimeType() async {
    await assertNoErrorsInCode('''
void f(dynamic a) {
  (a).runtimeType;
}
''');

    var runtimeTypeElement = elementMatcher(
      objectElement.getGetter('runtimeType'),
      isLegacy: isLegacyLibrary,
    );

    var propertyAccess = findNode.propertyAccess('runtimeType;');
    assertPropertyAccess2(
      propertyAccess,
      element: runtimeTypeElement,
      type: 'Type',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: runtimeTypeElement,
      type: 'Type',
    );
  }

  test_ofDynamic_read_toString() async {
    await assertNoErrorsInCode('''
void f(dynamic a) {
  (a).toString;
}
''');

    var toStringElement = elementMatcher(
      objectElement.getMethod('toString'),
      isLegacy: isLegacyLibrary,
    );

    var propertyAccess = findNode.propertyAccess('toString;');
    assertPropertyAccess2(
      propertyAccess,
      element: toStringElement,
      type: 'String Function()',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: toStringElement,
      type: 'String Function()',
    );
  }

  test_ofExtension_read() async {
    await assertNoErrorsInCode('''
class A {}

extension E on A {
  int get foo => 0;
}

void f(A a) {
  A().foo;
}
''');

    var propertyAccess = findNode.propertyAccess('foo;');
    assertPropertyAccess2(
      propertyAccess,
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: findElement.getter('foo'),
      type: 'int',
    );
  }

  test_ofExtension_readWrite_assignment() async {
    await assertNoErrorsInCode('''
class A {}

extension E on A {
  int get foo => 0;
  set foo(num _) {}
}

void f() {
  A().foo += 1;
}
''');

    var assignment = findNode.assignment('foo += 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: dart:core::@class::num::@method::+::@parameter::other
    staticType: int
  readElement: self::@extension::E::@getter::foo
  readType: int
  writeElement: self::@extension::E::@setter::foo
  writeType: num
  staticElement: dart:core::@class::num::@method::+
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A*
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A*
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: ParameterMember
      base: dart:core::@class::num::@method::+::@parameter::other
      isLegacy: true
    staticType: int*
  readElement: self::@extension::E::@getter::foo
  readType: int*
  writeElement: self::@extension::E::@setter::foo
  writeType: num*
  staticElement: MethodMember
    base: dart:core::@class::num::@method::+
    isLegacy: true
  staticType: int*
''');
    }
  }

  test_ofExtension_write() async {
    await assertNoErrorsInCode('''
class A {}

extension E on A {
  set foo(int _) {}
}

void f() {
  A().foo = 1;
}
''');

    var assignment = findNode.assignment('foo = 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@extension::E::@setter::foo::@parameter::_
    staticType: int
  readElement: <null>
  readType: null
  writeElement: self::@extension::E::@setter::foo
  writeType: int
  staticElement: <null>
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: InstanceCreationExpression
      constructorName: ConstructorName
        type: NamedType
          name: SimpleIdentifier
            token: A
            staticElement: self::@class::A
            staticType: null
          type: A*
        staticElement: self::@class::A::@constructor::•
      argumentList: ArgumentList
        leftParenthesis: (
        rightParenthesis: )
      staticType: A*
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@extension::E::@setter::foo::@parameter::_
    staticType: int*
  readElement: <null>
  readType: null
  writeElement: self::@extension::E::@setter::foo
  writeType: int*
  staticElement: <null>
  staticType: int*
''');
    }
  }

  test_super_read() async {
    await assertNoErrorsInCode('''
class A {
  int foo = 0;
}

class B extends A {
  void f() {
    super.foo;
  }
}
''');

    var propertyAccess = findNode.propertyAccess('super.foo');
    assertPropertyAccess2(
      propertyAccess,
      element: findElement.getter('foo'),
      type: 'int',
    );

    assertSuperExpression(
      propertyAccess.target,
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: findElement.getter('foo'),
      type: 'int',
    );
  }

  test_super_readWrite_assignment() async {
    await assertNoErrorsInCode('''
class A {
  int foo = 0;
}

class B extends A {
  void f() {
    super.foo += 1;
  }
}
''');

    var assignment = findNode.assignment('foo += 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: SuperExpression
      superKeyword: super
      staticType: B
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: dart:core::@class::num::@method::+::@parameter::other
    staticType: int
  readElement: self::@class::A::@getter::foo
  readType: int
  writeElement: self::@class::A::@setter::foo
  writeType: int
  staticElement: dart:core::@class::num::@method::+
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: SuperExpression
      superKeyword: super
      staticType: B*
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: +=
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: ParameterMember
      base: dart:core::@class::num::@method::+::@parameter::other
      isLegacy: true
    staticType: int*
  readElement: self::@class::A::@getter::foo
  readType: int*
  writeElement: self::@class::A::@setter::foo
  writeType: int*
  staticElement: MethodMember
    base: dart:core::@class::num::@method::+
    isLegacy: true
  staticType: int*
''');
    }

    var propertyAccess = assignment.leftHandSide as PropertyAccess;
    assertSuperExpression(
      propertyAccess.target,
    );
  }

  test_super_write() async {
    await assertNoErrorsInCode('''
class A {
  int foo = 0;
}

class B extends A {
  void f() {
    super.foo = 1;
  }
}
''');

    var assignment = findNode.assignment('foo = 1');
    if (isNullSafetyEnabled) {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: SuperExpression
      superKeyword: super
      staticType: B
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@class::A::@setter::foo::@parameter::_foo
    staticType: int
  readElement: <null>
  readType: null
  writeElement: self::@class::A::@setter::foo
  writeType: int
  staticElement: <null>
  staticType: int
''');
    } else {
      assertResolvedNodeText(assignment, r'''
AssignmentExpression
  leftHandSide: PropertyAccess
    target: SuperExpression
      superKeyword: super
      staticType: B*
    operator: .
    propertyName: SimpleIdentifier
      token: foo
      staticElement: <null>
      staticType: null
    staticType: null
  operator: =
  rightHandSide: IntegerLiteral
    literal: 1
    parameter: self::@class::A::@setter::foo::@parameter::_foo
    staticType: int*
  readElement: <null>
  readType: null
  writeElement: self::@class::A::@setter::foo
  writeType: int*
  staticElement: <null>
  staticType: int*
''');
    }

    var propertyAccess = assignment.leftHandSide as PropertyAccess;
    assertSuperExpression(
      propertyAccess.target,
    );
  }

  test_targetTypeParameter_dynamicBounded() async {
    await assertNoErrorsInCode('''
class A<T extends dynamic> {
  void f(T t) {
    (t).foo;
  }
}
''');

    var propertyAccess = findNode.propertyAccess('.foo');
    assertPropertyAccess2(
      propertyAccess,
      element: null,
      type: 'dynamic',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: null,
      type: 'dynamic',
    );
  }

  test_targetTypeParameter_noBound() async {
    await resolveTestCode('''
class C<T> {
  void f(T t) {
    (t).foo;
  }
}
''');
    assertErrorsInResult(expectedErrorsByNullability(
      nullable: [
        error(CompileTimeErrorCode.UNCHECKED_PROPERTY_ACCESS_OF_NULLABLE_VALUE,
            37, 3),
      ],
      legacy: [
        error(CompileTimeErrorCode.UNDEFINED_GETTER, 37, 3),
      ],
    ));

    var propertyAccess = findNode.propertyAccess('.foo');
    assertPropertyAccess2(
      propertyAccess,
      element: null,
      type: 'dynamic',
    );

    assertSimpleIdentifier(
      propertyAccess.propertyName,
      element: null,
      type: 'dynamic',
    );
  }

  test_tearOff_method() async {
    await assertNoErrorsInCode('''
class A {
  void foo(int a) {}
}

bar() {
  A().foo;
}
''');

    var identifier = findNode.simple('foo;');
    assertElement(identifier, findElement.method('foo'));
    assertType(identifier, 'void Function(int)');
  }
}

@reflectiveTest
class PropertyAccessResolutionWithoutNullSafetyTest
    extends PubPackageResolutionTest
    with PropertyAccessResolutionTestCases, WithoutNullSafetyMixin {}
