// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written T0 <: T1)
/// when:
/// Right Promoted Variable: if T1 is a promoted type variable X1 & S1 then:
/// - T0 <: T1 iff T0 <: X1 and T0 <: S1
/// @description Check that if type T1 is a promoted type variables X1 & S1 and
/// T0 <: X1 and T0 <: S1 then T0 is a subtype of T1.
/// @author sgrekhov@unipro.ru
///
/// @description Check that if type T0 is a subtype of a type T1, then instance
/// of T0 can be assigned to the superclass member of type T1
/// @author sgrekhov@unipro.ru
///
/// This test is generated from test_types/right_promoted_variable_A01.dart and 
/// test_cases/class_member_x02.dart. Don't modify it! 
/// If you need to change this test, then change one of the files above and then 
/// run generator/generator.dart to regenerate the tests.

class X1 {
  const X1();
}
class S1 extends X1 {
  const S1();
}

class T0 extends S1 {}

T0 t0Instance = new T0();
X1 t1Instance = new S1();

const t1Default = const S1();

class ClassMemberSuper1_t02 {
  S1 m = t1Default;

  ClassMemberSuper1_t02(dynamic value) {
    m = value;
  }

  ClassMemberSuper1_t02.named(dynamic value) {
    m = value;
  }

  ClassMemberSuper1_t02.short(this.m);

  void set superSetter(S1 val) {}
}

class ClassMember1_t02 extends ClassMemberSuper1_t02 {

  ClassMember1_t02() : super(t0Instance) {}

  ClassMember1_t02.named() : super.named(t0Instance) {}

  ClassMember1_t02.short() : super.short(t0Instance);

  test() {
    m = t0Instance;
    superSetter = t0Instance;
  }
}

main() {
  X1 t1Instance = new S1();
  if (t1Instance is S1) {
    ClassMember1_t02 c1 = new ClassMember1_t02();
    c1 = new ClassMember1_t02.short();
    c1 = new ClassMember1_t02.named();
    c1.m = t0Instance;
    c1.test();
    c1.superSetter = t0Instance;
  }
}
