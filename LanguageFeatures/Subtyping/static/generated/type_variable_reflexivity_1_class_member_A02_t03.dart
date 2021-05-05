// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Type Variable Reflexivity 1: T0 is a type variable X0 or a promoted type
/// variables X0 & S0 and T1 is X0
/// @description Check that if type T0 a promoted type variables X0 & S0 and T1
/// is X0 then T0 is a subtype of T1.
/// @author sgrekhov@unipro.ru

/**
 * @description Check that if type T0 is a subtype of a type T1, then instance
 * of T0 can be be assigned to the mixin member of type T1
 * @author sgrekhov@unipro.ru
 */
/*
 * This test is generated from type_variable_reflexivity_1_A02.dart and 
 * class_member_x03.dart.
 * Don't modify it. If you want to change this file, change one of the files 
 * above and then run generator.dart to regenerate the tests.
 */


class X0 {}
class S0 extends X0 {
}

///# @T0 = S0

X0 t0Instance = new S0();
X0 t1Instance = new X0();




class ClassMemberMixin1_t03 {
  X0 m;

  void set superSetter(dynamic val) {}
}

class ClassMember1_t03 extends Object with ClassMemberMixin1_t03 {
  test() {
    m = t0Instance;
    superSetter = t0Instance;
  }
}



test<T>(T t0Instance) {
  if (t0Instance is S0) {
  
  ClassMember1_t03 c1 = new ClassMember1_t03();
  c1.m = t0Instance;
  c1.test();
  c1.superSetter = t0Instance;

  }
}

main() {
  test<S0>(t0Instance);
}
