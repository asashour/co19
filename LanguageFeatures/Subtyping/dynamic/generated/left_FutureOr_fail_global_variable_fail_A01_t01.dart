// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Left FutureOr: T0 is FutureOr<S0>
///   and Future<S0> <: T1
///   and S0 <: T1
/// @description Check that if a type T0 is FutureOr<S0> and S0 is a subtype of
/// T1 but Future<S0> is not a subtype of T1, then a type T0 is not a subtype
/// of a type T1.
/// @author sgrekhov@unipro.ru
///
/// @description Check that if type T0 is not a subtype of a type T1, then
/// instance of T0 cannot be assigned to the to global variable of type T1
/// @author sgrekhov@unipro.ru
///
/// This test is generated from test_types/left_FutureOr_fail_A01.dart and 
/// test_cases/global_variable_fail_x01.dart. Don't modify it! 
/// If you need to change this test, then change one of the files above and then 
/// run generator/generator.dart to regenerate the tests.

import '../../utils/common.dart';
import '../../../../Utils/expect.dart';

import "dart:async";

FutureOr t0Instance = 42;
Future t1Instance = Future.value(42);

class GlobalVariableTest {
  GlobalVariableTest() {
    t1Instance = forgetType(t0Instance);
  }

  GlobalVariableTest.valid() {}

  foo() {
    t1Instance = forgetType(t0Instance);
  }

  static test() {
    t1Instance = forgetType(t0Instance);
  }
}

main() {
  bar () {
    t1Instance = forgetType(t0Instance);
  }

  Expect.throws(() {
    t1Instance = forgetType(t0Instance);
  }, (e) => e is TypeError);

  Expect.throws(() {
    bar();
  }, (e) => e is TypeError);

  Expect.throws(() {
    new GlobalVariableTest();
  }, (e) => e is TypeError);

  Expect.throws(() {
    new GlobalVariableTest.valid().foo();
  }, (e) => e is TypeError);

  Expect.throws(() {
    GlobalVariableTest.test();
  }, (e) => e is TypeError);
}
