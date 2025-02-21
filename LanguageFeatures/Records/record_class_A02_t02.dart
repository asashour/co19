// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion A built-in class [Record] with no members except those inherited
/// from [Object]. All record types are a subtype of this class. This type
/// cannot be constructed, extended, mixed in, or implemented by user-defined
/// classes.
///
/// @description Checks that it is a compile error to extend [Record] class
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=records

class R1 extends Record {
//               ^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
}

class R2 extends (int, {String s}) {
//               ^^^^^^^^^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
}

class R3 extends () {
//               ^^
// [analyzer] unspecified
// [cfe] unspecified
}

main() {
  R1();
  R2();
  R3();
}
