// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion The switch statement supports dispatching control among a large
/// number of cases.
/// switchStatement:
///   switch '(' expression ')' '{' switchCase* defaultCase? '}'
/// ;
/// switchCase:
///   label* case expression ':' statements
/// ;
/// defaultCase:
///   label* default ':' statements
/// ;
/// @description Checks that it is a compile-time error if a label is not
/// followed by case or default keywords.
/// @author kaigorodov

foo(value) {
  var result;

  switch (value) {
    case 0: break;
    label:
//       ^
// [analyzer] unspecified
// [cfe] unspecified
  }
//^
// [analyzer] unspecified
// [cfe] unspecified
  return result;
}

main() {}
