/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Relational expressions invoke the relational operators on objects.
 * relationalExpression:
 *   shiftExpression (isOperator type | relationalOperator shiftExpression)? |
 *   super relationalOperator shiftExpression
 * ;
 * relationalOperator:
 *   '>=' |
 *   '>' |
 *   '<=' |
 *   '<'
 * ;
 * A relational expression is either a shift expression, or an invocation
 * of a relational operator on either super or an expression e1, with argument e2.
 * @description Checks that a type variable can't be used
 * as the second operand in a relational expression.
 * @compile-error
 * @author msyabro
 * @reviewer rodionov
 */

class A<T> {
  test() {
    try{ 1 > T;} catch(var e) {}
  }
}

main() {
  A a = new A();
  a.test();
}
