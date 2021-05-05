// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Function Type/Function: T0 is a function type and T1 is Function
/// @description Check that if type T0 is a function type and T1 is Function then
/// T0 is a subtype of T1. Test non-void generic function with named arguments
/// @author sgrekhov@unipro.ru

/**
 * @description Check that if type T0 is a subtype of a type T1, then instance
 * of T0 can be be used as a return value of type T1
 * @author sgrekhov@unipro.ru
 */
/*
 * This test is generated from function_type_function_A18.dart and 
 * return_value_x01.dart.
 * Don't modify it. If you want to change this file, change one of the files 
 * above and then run generator.dart to regenerate the tests.
 */



class C {}

typedef C T0<X>(C c, {X x});
C t0Func<X>(C c, {X x}) => c;

T0<C> t0Instance = t0Func;
Function t1Instance = null;




Function returnValueFunc() => t0Instance;

class ReturnValueTest {
  static Function staticTestMethod() => t0Instance;

  Function testMethod() => t0Instance;

  Function get testGetter => t0Instance;
}

main() {
  Function returnValueLocalFunc() => t0Instance;

  returnValueFunc();
  returnValueLocalFunc();

  ReturnValueTest.staticTestMethod();

  new ReturnValueTest().testMethod();
  new ReturnValueTest().testGetter;

}
