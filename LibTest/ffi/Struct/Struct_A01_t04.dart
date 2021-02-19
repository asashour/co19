/*
 * Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion All field declarations in a Struct subclass declaration must
 * either have type int or double and be annotated with a NativeType
 * representing the native type, or must be of type Pointer or subtype of Struct.
 *
 * @description Checks that it is a compile error if any of the field in Struct
 * subclass is not 'int', 'double' or 'Pointer' or subtype of 'Struct'
 * @author sgrekhov@unipro.ru
 */
import "dart:ffi";
import "dart:async";

class S1 extends Struct {
  @Int8()
  external int i;

  @Double()
  external FutureOr<double> x;
//         ^^^^^^^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
  @Int32()
  external FutureOr<int> y;
//         ^^^^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
}

class S2 extends Struct {
  Pointer<FutureOr<Int8>> x;
//         ^^^^^^^^^^^^^
// [analyzer] unspecified
// [cfe] unspecified
}

void main() {
  S1? s1;
  S2? s2;
}
