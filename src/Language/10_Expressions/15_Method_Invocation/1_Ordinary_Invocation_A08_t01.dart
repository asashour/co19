/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Let T be the static type of o. If T.m does not exist, 
 * or if F is not a function type, the static type of i is Dynamic;
 * otherwise the static type of i is the declared return type of F.
 * @description Checks that the static type of an ordinary invocation is Dynamic
 * when F is not a function type (but can be assigned to it) by ensuring that 
 * there's no static warning when a result of such invocation is being assigned 
 * to variables with various declared types.
 * @author rodionov
 * @issue 1604
 */

class C {
  Object f1;
}

class A {}

main() {
  C c = new C();
  
  try {
    String foo = c.f1();
  } on NoSuchMethodError catch(e) {}

  try {
    bool foo = c.f1();
  } on NoSuchMethodError catch(e) {}

  try {
    A foo = c.f1();
  } on NoSuchMethodError catch(e) {}

  try {
    Object foo = c.f1();
  } on NoSuchMethodError catch(e) {}

  try {
    List foo = c.f1();
  } on NoSuchMethodError catch(e) {}

  try {
    Map foo = c.f1();
  } on NoSuchMethodError catch(e) {}
}
