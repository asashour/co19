// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion
/// listPattern         ::= typeArguments? '[' listPatternElements? ']'
/// listPatternElements ::= listPatternElement ( ',' listPatternElement )* ','?
/// listPatternElement  ::= pattern | restPattern
/// restPattern         ::= '...' pattern?
///
/// A list pattern may contain a rest element which allows matching lists of
/// arbitrary lengths. If a rest element is present and has a subpattern, all of
/// the elements not matched by other subpatterns are collected into a new list
/// and that list is matched against the rest subpattern.
///
/// var [a, b, ...rest, c, d] = [1, 2, 3, 4, 5, 6, 7];
/// print('$a $b $rest $c $d'); // Prints "1 2 [3, 4, 5] 6 7".
///
/// @description Check that Object subpattern can be used in a list's rest
/// pattern
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=patterns,records

import "patterns_lib.dart";
import "../../Utils/expect.dart";

String test1(List list) {
  return switch (list) {
    [1, 2, 3, 4, ... Square(size: var r1)] => r1.toString(),
    [2, ...Square(size: final r2), 5, 6] => r2.toString(),
    [... /* comment */ Square(size: var r3), 6, 7, 8] => r3.toString(),
    _ => "default"
  };
}

String test2(List list) {
  switch (list) {
    case [1, 2, 3, 4, ... Square(size: var r1)]:
      return r1.toString();
    case [2, ...Square(size: final r2), 5, 6]:
      return r2.toString();
    case [... /* comment */ Square(size: var r3), 6, 7, 8]:
      return r3.toString();
    default:
      return "default";
  }
}

String test3(List list) {
  if (list case [1, 2, 3, 4, ... Square(size: var r1)]) {
    return r1.toString();
  }
  if (list case [2, ...Square(size: final r2), 5, 6]) {
    return r2.toString();
  }
  if (list case [... /* comment */ Square(size: var r3), 6, 7, 8]) {
    return r3.toString();
  }
  return "default";
}

main() {
  Expect.equals("default", test1([1, 2, 3, 4, Square(1)]));
  Expect.equals("default", test1([2, Square(1), 5, 6]));
  Expect.equals("default", test1([Square(1), 6, 7, 8]));
  Expect.equals("default", test1([1, 2]));
  Expect.equals("default", test2([1, 2, 3, 4, Square(1)]));
  Expect.equals("default", test2([2, Square(1), 5, 6]));
  Expect.equals("default", test2([Square(1), 6, 7, 8]));
  Expect.equals("default", test2([1, 2]));
  Expect.equals("default", test3([1, 2, 3, 4, Square(1)]));
  Expect.equals("default", test3([2, Square(1), 5, 6]));
  Expect.equals("default", test3([Square(1), 6, 7, 8]));
  Expect.equals("default", test3([1, 2]));
}
