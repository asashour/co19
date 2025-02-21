// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Calculate the static type of the pattern. Using that value type,
/// recurse through the pattern again downwards to the leaf subpatterns filling
/// in any missing types in the pattern. This process may also insert implicit
/// coercions and casts from dynamic when values flow into a pattern during
/// matching.
///
/// @description Check that the calculation of the static type of a
/// parenthesized pattern performs casts from dynamic and generic function
/// instantiation
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=patterns

import "../../Utils/static_type_helper.dart";
import "../../Utils/expect.dart";

T foo<T>(T t) => t;

main() {
  dynamic pi = 3.14;
  final (double v1) = pi;
  Expect.equals(3.14, v1);

  Expect.throws(() {
    dynamic e = 2.71;
    var (int v2) = e;
  });

  final (int Function(int) v3) = foo;
  v3.expectStaticType<Exactly<int Function(int)>>();
}
