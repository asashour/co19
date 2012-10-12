/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion An unqualified function invocation i has the form id(a1, ... , an, xn+1 : an+1, ... , xn+k :
 * an+k), where id is an identifier.
 * If there exists a lexically visible declaration named id, let fid be the inner-
 * most such declaration. Then:
 *  - If fid is a local function, a library function, a library or static getter or a
 * variable then i is interpreted as a function expression invocation.
 *  - Otherwise, if fid is a static method of the enclosing class C, i is equivalent
 * the static method invocation C.id(a1, ... , an, xn+1 : an+1, ... , xn+k : an+k).
 * Otherwise, i is equivalent to the ordinary method invocation this.id(a1, ... , an, xn+1 :
 * an+1, ... , xn+k : an+k).
 * @description Checks that if fid is a variable,
 * then i is interpreted as a function expression invocation.
 * @author msyabro
 * @reviewer rodionov
 * @issue 1604
 */

f (p1) {
  Expect.equals(null, p1);
  return 100;
}

class A {
  test() {
    var m = f;
    Expect.equals(100, m(null));

    m = 1;
    try {
      m(1, 2, 3);
      Expect.fail("NoSuchMethodError expected");
    } on NoSuchMethodError catch(ok) {}
  }
}

main() {
  new A().test();
}
