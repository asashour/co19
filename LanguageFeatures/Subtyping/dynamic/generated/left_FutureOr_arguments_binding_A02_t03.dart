// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Left FutureOr: T0 is FutureOr<S0>
///   and Future<S0> <: T1
///   and S0 <: T1
/// @description Check that if a type T0 is FutureOr<S0> and Future<S0> and S0
/// are subtypes of a type T1, then a type T0 is a subtype of a type T1. Case
/// when an instance of T0 is an instance of Future<S0> type.
/// @author ngl@unipro.ru
///
/// @description Check that if type T0 is a subtype of a type T1, then instance
/// of T0 can be used as an argument of type T1. Test mixin members
/// @author sgrekhov@unipro.ru
///
/// This test is generated from test_types/left_FutureOr_A02.dart and 
/// test_cases/arguments_binding_x03.dart. Don't modify it! 
/// If you need to change this test, then change one of the files above and then 
/// run generator/generator.dart to regenerate the tests.

import '../../utils/common.dart';

import "dart:async";

class C {
  const C();
}
class S0 extends C {}

FutureOr<S0> t0Instance = new Future<S0>.value(new S0());
FutureOr<C> t1Instance = new Future<C>.value(new C());

const t1Default = const C();

class ArgumentsBindingMixin1_t03 {
  FutureOr<C> m = t1Default;

  void superTest(FutureOr<C> val) {}
  void superTestPositioned(FutureOr<C> val, [FutureOr<C> val2 = t1Default]) {}
  void superTestNamed(FutureOr<C> val, {FutureOr<C> val2 = t1Default}) {}
  FutureOr<C> get superGetter => m;
  void set superSetter(FutureOr<C> val) {}
}

class ArgumentsBinding1_t03 extends Object with ArgumentsBindingMixin1_t03 {

  test(dynamic t1, dynamic t2) {
    superTest(t1);
    superTestPositioned(t1);
    superTestPositioned(t2, t1);
    superTestNamed(t1);
    superTestNamed(t2, val2: t1);
    superSetter = t1;
    m = t1;
    superGetter;
  }
}

class ArgumentsBindingMixin2_t03<X> {
  void superTest(X val) {}
  void superTestNamed(X val, {required X val2}) {}
  void set superSetter(X val) {}
}

class ArgumentsBinding2_t03<X> extends Object with ArgumentsBindingMixin2_t03<X> {

  test(dynamic t1, dynamic t2) {
    superTest(t1);
    superTestNamed(t2, val2: t1);
    superSetter = t1;
  }
}

main() {
  ArgumentsBinding1_t03 c1 = new ArgumentsBinding1_t03();

  c1.test(forgetType(t0Instance), t1Instance);
  c1.superTest(forgetType(t0Instance));
  c1.superTestPositioned(forgetType(t0Instance));
  c1.superTestPositioned(t1Instance, forgetType(t0Instance));
  c1.superTestNamed(forgetType(t0Instance));
  c1.superTestNamed(t1Instance, val2: forgetType(t0Instance));
  c1.superSetter = forgetType(t0Instance);
  c1.superGetter;

  // Test type parameters
  ArgumentsBinding2_t03<FutureOr<C>> c2 = new ArgumentsBinding2_t03<FutureOr<C>>();
  c2.test(forgetType(t0Instance), t1Instance);
  c2.superTest(forgetType(t0Instance));
  c2.superTestNamed(t1Instance, val2: forgetType(t0Instance));
  c2.superSetter = forgetType(t0Instance);
}
