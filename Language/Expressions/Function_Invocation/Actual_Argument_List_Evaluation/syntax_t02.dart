// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Function invocation involves evaluation of the list of actual
/// arguments to the function and binding of the results to the functions
/// formal parameters.
/// arguments:
///   '(' argumentList? ')'
/// ;
/// argumentList:
///   namedArgument (', ' namedArgument)* |
///   expressionList (', ' namedArgument)*
/// ;
/// namedArgument:
///   label expression
/// ;
/// @description Checks that it is a compile-time error when named arguments
/// precede positional arguments in a function invocation expression.
/// @author msyabro

// @dart = 2.16

func(p1, {p2}) {}

main() {
  try {
    func(p2: 1, 2);
//              ^
// [analyzer] unspecified
// [cfe] unspecified
  } catch (e) {}
}
