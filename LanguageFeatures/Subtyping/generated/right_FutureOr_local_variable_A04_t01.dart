/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
 * when:
 * Right FutureOr: T1 is FutureOr<S1> and
 *   either T0 <: Future<S1>
 *   or T0 <: S1
 *   or T0 is X0 and X0 has bound S0 and S0 <: T1
 *   or T0 is X0 & S0 and S0 <: T1
 * @description Check that if a type T1 is S1 and a type T0 is X0 and X0 has
 * bound S0 and S0 <: S1, then a type T0 is a subtype of a type T1.
 * @author ngl@unipro.ru
 */

import "../utils/common.dart";

class S1 {}
class S0 extends S1 {
}
class X0 extends S0 {
}

X0 t0Instance = new X0();
S1 t1Instance = new S1();




class LocalVariableTest {

  LocalVariableTest() {
    S1 t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }

  static staticTest() {
    S1 t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }

  test() {
    S1 t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }
}

main() {
  foo() {
    S1 t1 = forgetType(t0Instance);
    t1 = forgetType(t0Instance);
  }

  S1 t1 = forgetType(t0Instance);
  t1 = forgetType(t0Instance);
  foo();
  LocalVariableTest x = new LocalVariableTest();
  x.test();
  LocalVariableTest.staticTest();
}
