// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion The special type void may only be used as the return type of a
/// function: it is a compile-time error to use void in any other context.
/// For example, as a type argument, or as the type of a variable or parameter.
/// @description Checks that specifying void on the right side of a type test
/// expression causes a compile-time error.
/// @author iefremov

main() {
  bool b = null is void;
//                 ^
// [analyzer] unspecified
// [cfe] unspecified
}
