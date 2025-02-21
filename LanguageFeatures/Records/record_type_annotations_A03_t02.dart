// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion It is a compile-time error if a record type has any of:
///
/// The same field name more than once. This is true even if one or both of the
/// colliding fields is positional. We could permit collisions with positional
/// field names since they are only used for documentation, but we disallow it
/// because it's confusing and not useful.
///
/// Only one positional field and no trailing comma. This isn't ambiguous, since
/// there are no parenthesized type expressions in Dart. But prohibiting this is
/// symmetric with record expressions and leaves the potential for later support
/// for parentheses for grouping in type expressions.
///
/// A field named hashCode, runtimeType, noSuchMethod, or toString.
///
/// A field name that starts with an underscore.
///
/// A field name that collides with the synthesized getter name of a positional
/// field. For example: (int, $1: int) since the named field '$1' collides with
/// the getter for the first positional field.
///
/// @description Checks that it is a compile-time error if a record type has the
/// same field name more than once. Test positional fields
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=records

typedef R1 = (int i, {String s, int i});
//                                  ^
// [analyzer] unspecified
// [cfe] unspecified

typedef R2 = (int i, int i, {String s});
//                       ^
// [analyzer] unspecified
// [cfe] unspecified

typedef (int i, {String s, int i}) R3();
//                             ^
// [analyzer] unspecified
// [cfe] unspecified

typedef (int i, int i, {String s}) R4();
//                  ^
// [analyzer] unspecified
// [cfe] unspecified

typedef void R5((int i, {String s, int i}) r);
//                                     ^
// [analyzer] unspecified
// [cfe] unspecified

typedef void R6((int i, int i, {String s}) r);
//                          ^
// [analyzer] unspecified
// [cfe] unspecified

(int i, String s, {String s}) foo1() => (42, "", s: "");
//                        ^
// [analyzer] unspecified
// [cfe] unspecified

(int i, String i, {String s}) foo2() => (42, "", s: "");
//             ^
// [analyzer] unspecified
// [cfe] unspecified

void bar1((int i, {String s, String i}) r) {}
//                                  ^
// [analyzer] unspecified
// [cfe] unspecified

void bar2((int i, String i, {String s}) r) {}
//                                  ^
// [analyzer] unspecified
// [cfe] unspecified

main() {
  (int i, {String s, int i}) r1 = (42, s: "", i: 0);
//                       ^
// [analyzer] unspecified
// [cfe] unspecified

  (bool d, double d, {int i, String s}) r2 = (true, 1.1, i: 42, s: "");
//                ^
// [analyzer] unspecified
// [cfe] unspecified

  dynamic d = (i: 1, s: "Lily was here");
  if (d is (int i, {int i, String s})) {
//              ^
// [analyzer] unspecified
// [cfe] unspecified
  }

  if (d is (int i, int i, {String s})) {
//                     ^
// [analyzer] unspecified
// [cfe] unspecified
  }
  d as (int i, {String s, int i});
//                            ^
// [analyzer] unspecified
// [cfe] unspecified

  d as (int i, int i, {String s});
//                 ^
// [analyzer] unspecified
// [cfe] unspecified
}
