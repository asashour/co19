/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion A try statement try s1 on − catch1 . . . on − catchn ﬁnally sf deﬁnes an
 * exception handler h that executes as follows:
 *   The on-catch clauses are examined in order, starting with catch1 , until
 * either an on-catch clause that matches the current exception (11.8) is found,
 * or the list of on-catch clauses has been exhausted. If an on-catch clause
 * on−catchk is found, then pk1 is bound to the current exception, pk2 , if declared,
 * is bound to the active stack trace, and then catchk is executed. If no on-catch
 * clause is found, the ﬁnally clause is executed. Then, execution resumes at the
 * end of the try statement.
 *     A ﬁnally clause ﬁnally s deﬁnes an exception handler h that executes by
 * executing the ﬁnally clause. Then, execution resumes at the end of the try
 * statement.
 * @description Checks that the catch clauses are examined in order, starting with catch1,
 * until a catch clause that matches the current exception is found.
 * @author vasya
 * @reviewer rodionov
 * @reviewer iefremov
 */

class T1 { }
class T2 { }
class T3 { }

main() {
  bool ok = false;
  try {
    throw new T1();
  } on T1 catch(p1) {
    ok = true;
  } on T2 catch(p2) {
    Expect.fail("This clause shouldn't be executed");
  } on T3 catch(p3) {
    Expect.fail("This clause shouldn't be executed");
  }

  Expect.isTrue(ok, "Correct catch clause was not executed!");
  ok = false;

  try {
    throw new T2();
  } on T1 catch(p1) {
    Expect.fail("This clause shouldn't be executed");
  } on T2 catch(p2) {
    ok = true;
  } on T3 catch(p3) {
    Expect.fail("This clause shouldn't be executed");
  }
  Expect.isTrue(ok, "Correct catch clause was not executed!");
  ok = false;

  try {
    throw new T3();
  } on T1 catch(p1) {
    Expect.fail("This clause shouldn't be executed");
  } on T2 catch(p2) {
    Expect.fail("This clause shouldn't be executed");
  } on T3 catch(p3) {
    ok = true;
  }
  Expect.isTrue(ok, "Correct catch clause was not executed!");
  ok = false;

  try {
    throw "";
  } on T1 catch(p1) {
    Expect.fail("This clause shouldn't be executed");
  } on T2 catch(p2) {
    Expect.fail("This clause shouldn't be executed");
  } on T3 catch(p3) {
    Expect.fail("This clause shouldn't be executed");
  } catch(ex) {
    ok = true;
  }
  Expect.isTrue(ok, "Correct catch clause was not executed!");
  ok = false;
}
