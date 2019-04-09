/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion The operator [>>>] is now allowed in a potentially constant
 * expression, and it is valid in constant expression if its left and right
 * operands are [int] instances, and the operation doesn't throw. The [>>>]
 * operator has not been added to the [int] class yet, so unless the left-hand
 * operand's static type is [dynamic], the program will still be rejected. When
 * the operator is added, it should then also work in a constant expression.
 * @description Checks that arguments of [>>>] operator should be int.
 * @Issue 30886
 * @author iarkh@unipro.ru
 */
// SharedOptions=--enable-experiment=constant-update-2018,triple-shift

main() {
  const d1 = 14;
  const d2 = 1000;
  const d3 = 0;

  const d4 = -1;
  const d5 = -99999;

  const c1 = d1 >>> d3;
  const c2 = 12345 >>> 0;
  const c3 = -111 >>> d3;
  const c4 = 0 >>> 0;

  const c5 = d1 >>> d4;    //# 01: compile-time error
  const c6 = d2 >>> d5;    //# 02: compile-time error

  const c7  = d3 >>> -11;  //# 03: compile-time error
  const c8  = 1 >>> -9999; //# 04: compile-time error
  const c9  = d4 >>> -2;   //# 05: compile-time error
  const c10 = -24 >>> d5;   //# 06: compile-time error
}
