// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Super-Interface: T0 is an interface type with super-interfaces S0,...Sn
/// - and Si <: T1 for some i
/// @description Check that if type T0 is an interface type with super-interfaces
/// S0,...Sn and Si <: T1 for some i then T0 is a subtype of a type T1
/// @author sgrekhov@unipro.ru
///
/// @description Check that if type T0 is a subtype of a type T1, then instance
/// of T0 can be assigned to the class member of type T1
/// @author sgrekhov@unipro.ru
///
/// This test is generated from test_types/super_interface_A01.dart and 
/// test_cases/class_member_x01.dart. Don't modify it! 
/// If you need to change this test, then change one of the files above and then 
/// run generator/generator.dart to regenerate the tests.

class T1 {
  const T1();
}

abstract class S0 extends T1 {}
abstract class S1 {}
abstract class S2 {}

abstract class T0 implements S0, S1, S2  {}

class T implements T0 {}

T0 t0Instance = new T();

class ClassMember1_t01 {
  static T1 s = t0Instance;
  T1 m = t0Instance;
  T1 _p = t0Instance;

  ClassMember1_t01() {
    s = t0Instance;
    m = t0Instance;
    _p = t0Instance;
  }

  ClassMember1_t01.named(T1 value) {
    s = value;
    m = value;
    _p = value;
  }

  ClassMember1_t01.short(this.m, this._p);

  test() {
    s = t0Instance;
    m = t0Instance;
    _p = t0Instance;
  }

  set setter(T1 val) {
    _p = val;
  }

  T1 get getter => _p;

  static staticTest() {
    s = t0Instance;
  }

  static set staticSetter(T1 val) {
    s = val;
  }

  static T1 get staticGetter => t0Instance;
}

main() {
  ClassMember1_t01 c1 = new ClassMember1_t01();
  c1 = new ClassMember1_t01.short(t0Instance,
      t0Instance);
  c1 = new ClassMember1_t01.named(t0Instance);
  c1.m = t0Instance;
  c1.test();
  c1.setter = t0Instance;
  c1.getter;

  ClassMember1_t01.s = t0Instance;
  ClassMember1_t01.staticTest();
  ClassMember1_t01.staticSetter = t0Instance;
  ClassMember1_t01.staticGetter;
}
