// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We say that a type T0 is a subtype of a type T1 (written
/// T0 <: T1) when:
/// A record type A is a subtype of record type B iff they have same shape and
/// the types of all fields of A are subtypes of the corresponding field types
/// of B
///
/// @description Check that if type T0 is a record with another shape than T1
/// then T0 is not a subtype of T1
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=records

(int, String) t0Instance = (1, "2");
(int, String, {bool b}) t1Instance = (3, "4", b: true);

const t1Default = const (5, "6", b: false);

//# @T0 = (int i, String s)
//# @T1 = (int i, String s, {bool b})
