// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion
/// primary                 ::= // Existing productions...
///                           | switchExpression
///
/// switchExpression      ::= 'switch' '(' expression ')' '{'
///                           switchExpressionCase ( ',' switchExpressionCase )*
///                           ','? '}'
/// switchExpressionCase  ::= guardedPattern '=>' expression
///
/// The body is a series of cases. Each case has a pattern, optional guard, and
/// a single expression body. As with other expression forms containing a list
/// of subelements (argument lists, collection literals), the cases are
/// separated by commas with an optional trailing comma. Since the body of each
/// case is a single expression with a known terminator, it's easy to tell when
/// one case ends and the next begins. That lets us do away with the case
/// keyword.
///
/// To keep the syntax small and light, we also disallow a default clause.
/// Instead, you can use a shorter _ wildcard pattern to catch any remaining
/// values.
///
/// Slotting into primary means it can be used anywhere any expression can
/// appear, even as operands to unary and binary operators. Many of these uses
/// are ugly, but not any more problematic than using a collection literal in
/// the same context since a switch expression is always delimited by a switch
/// and }.
///
/// @description Check that it is a compile time error if a switch expression
/// can be used as operand of -- or ++ operator
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=patterns

int test1(String s) =>
  ++switch (s) {
//^^
// [analyzer] unspecified
// [cfe] unspecified
    "one" => 1,
    "two" => 2,
    _ => 0
  };

int test2(String s) =>
  --switch (s) {
//^^
// [analyzer] unspecified
// [cfe] unspecified
    "one" => 1,
    "two" => 2,
    _ => 0
  };

int test3(String s) =>
  switch (s) {
    "one" => 1,
    "two" => 2,
    _ => 0
  }++;
// ^^
// [analyzer] unspecified
// [cfe] unspecified

int test4(String s) =>
  switch (s) {
    "one" => 1,
    "two" => 2,
    _ => 0
  }--;
// ^^
// [analyzer] unspecified
// [cfe] unspecified

main() {
  test1("one");
  test2("one");
  test3("one");
  test4("one");
}
