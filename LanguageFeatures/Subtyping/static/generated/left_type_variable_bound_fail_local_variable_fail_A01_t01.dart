// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Left Type Variable Bound: T0 is a type variable X0 with bound B0
///   and B0 <: T1
/// @description Check that if T0 is a type variable X0 with bound B0 and
/// B0 is not a subtype of T1 then T0 is not a subtype of a type T1.
/// @author ngl@unipro.ru
///
/// @description Check that if type T0 is not a subtype of a type T1, then
/// instance of T0 cannot be assigned to the to local variable of type T1.
/// Assignment to local variable is tested.
/// @author sgrekhov@unipro.ru
/// @author ngl@unipro.ru
///
/// This test is generated from test_types/left_type_variable_bound_fail_A01.dart and 
/// test_cases/local_variable_fail_x01.dart. Don't modify it! 
/// If you need to change this test, then change one of the files above and then 
/// run generator/generator.dart to regenerate the tests.

class T1 {
  const T1();
}
class B0 {}
class X0 extends B0 {}

X0 t0Instance = new X0();

class LocalVariableTest {
  LocalVariableTest() {
    T1 t1 = t0Instance;
//           ^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
  }

  test() {
    T1 t1 = t0Instance;
//           ^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
  }

  static staticTest() {
    T1 t1 = t0Instance;
//           ^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
  }
}

main() {
  T1 t1 = t0Instance;
//         ^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified

  bar () {
    T1 t1 = t0Instance;
//           ^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
  }
}
