// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Let S be a class, M be a mixin with required superinterfaces
/// T1, . . . , Tn, combined superinterface MS, implemented interfaces
/// I1, . . . , Ik and members as mixin member declarations, and let N be a name.
/// ...
/// The mixin application of M to S with name N introduces a new class, C,
/// with name N, superclass S, implemented interface I1, . . . , Ik and members
/// as instance members.
/// @description Checks that instance class has the same instance methods as
/// its mixins
/// @author sgrekhov@unipro.ru

import "../../../Utils/expect.dart";

class A {
  int x = 0;
  void ma(int val) {x = val;}
  int get ga => x;
}

class M1 {
  int x = 1;
  void m1(int val) {x = val;}
  int get g1 => x;
}

class M2 {
  int x = 2;
  void m2(int val) {x = val;}
  int get g2 => x;
}

class B1 = A with M1;
class B2 = A with M1, M2;
class B3 = B1 with M2;

main() {
  B1 b1 = new B1();
  B2 b2 = new B2();
  B3 b3 = new B3();

  b1.ma(1);
  b2.ma(2);
  b3.ma(3);

  Expect.equals(1, b1.ga);
  Expect.equals(2, b2.ga);
  Expect.equals(3, b3.ga);

  b1.m1(11);
  b2.m1(12);
  b3.m1(13);

  Expect.equals(11, b1.g1);
  Expect.equals(12, b2.g1);
  Expect.equals(13, b3.g1);

  b2.m2(22);
  b3.m2(23);

  Expect.equals(22, b2.g2);
  Expect.equals(23, b3.g2);
}
