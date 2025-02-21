// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion
/// logicalAndPattern ::= ( logicalAndPattern '&&' )? relationalPattern
///
/// A pair of patterns separated by & matches only if both subpatterns match.
/// Unlike logical-or patterns, the variables defined in each branch must not
/// overlap, since the logical-and pattern only matches if both branches do and
/// the variables in both branches will be bound.
///
/// If the left branch does not match, the right branch is not evaluated. This
/// only matters because patterns may invoke user-defined methods with visible
/// side effects.
///
/// @description Checks a logical-and subpattern in a switch statement
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=patterns

import "../../Utils/expect.dart";

bool matches(List list) {
  bool result = false;
  switch (list) {
    case [> 0 && <= 2, 3]:
      result = true;
    default:
  };
  return result;
}

main() {
  Expect.isFalse(matches([0, 3]));
  Expect.isFalse(matches([2, 2]));
  Expect.isFalse(matches([2, 3, 4]));
  Expect.isFalse(matches([2, "3"]));
  Expect.isFalse(matches([3.14, 3]));
  Expect.isTrue(matches([1, 3]));
  Expect.isTrue(matches([2, 3]));
}
