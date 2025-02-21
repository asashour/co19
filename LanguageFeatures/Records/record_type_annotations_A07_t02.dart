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
/// @description Checks that it is no error if a record type has a field name
/// that doesn't collide with the synthesized getter name of a positional field
/// @author sgrekhov22@gmail.com
/// @issue 49883

// SharedOptions=--enable-experiment=records

typedef R1 = (int $6, {String s});

typedef R2 = (int, {String $101});

typedef (int $1, {int i}) R3();

typedef (int, {int $2}) R4();

typedef void R5((String s, {String $2}) r);

(int, {int $2})? foo1() => null;

(int $3, {int x})? foo2() => null;

void bar1((int i, {bool $2}) r) {}

void bar2((int $4, {bool b}) r) {}

main() {
  (int $1, {String s})? r1 = null;

  (double d, {int $2})? r2 = null;

  dynamic d = (1, $2: 0);
  if (d is (int i, {String $2})) {
  }

  if (d is (int $1, {String s})) {
  }

  d as (int, {int $2});
  d = (1, i: 42);
  d as (int $1, {int i});
}
