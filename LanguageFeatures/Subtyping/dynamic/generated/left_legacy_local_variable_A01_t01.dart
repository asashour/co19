// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Left Legacy if T0 is S0* then:
/// - T0 <: T1 iff S0 <: T1.
/// @description Check that if type T0 is S0* and S0 <: T1 then T0 is subtype of
/// T1.
/// @author sgrekhov@unipro.ru
///
/// @description Check that if type T0 is a subtype of a type T1, then instance
/// of T0 can be assigned to the to local variable of type T1
/// @author sgrekhov@unipro.ru
///
/// This test is generated from test_types/left_legacy_A01.dart and 
/// test_cases/local_variable_x01.dart. Don't modify it! 
/// If you need to change this test, then change one of the files above and then 
/// run generator/generator.dart to regenerate the tests.

import '../../utils/common.dart';

// Requirements=nnbd-weak
import "../../utils/legacy_lib.dart";
class S0 {}

var t0Instance = getLegacyType<S0>(new S0());

class LocalVariableTest {

  LocalVariableTest() {
    Object t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }

  static staticTest() {
    Object t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }

  test() {
    Object t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }
}

main() {
  foo() {
    Object t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }

  Object t1 = forgetType(t0Instance);
  t1 = forgetType(t0Instance);
  foo();
  LocalVariableTest x = new LocalVariableTest();
  x.test();
  LocalVariableTest.staticTest();
}
