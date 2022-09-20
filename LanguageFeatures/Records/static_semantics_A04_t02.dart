// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion We define shape to mean the number of positional fields (the
/// record's arity) and the set of names of its named fields. Record types are
/// structural, not nominal. Records produced in unrelated libraries have the
/// exact same static type if they have the same shape and their corresponding
/// fields have the same types.
///
/// The order of named fields is not significant. The record types {int a,
/// int b} and {int b, int a} are identical to the type system and the runtime.
/// (Tools may or may not display them to users in a canonical form similar to
/// how they handle function typedefs.)
///
/// @description Checks that equality of the record types. Test type
/// normalization
/// @author sgrekhov22@gmail.com

// SharedOptions=--enable-experiment=records

import "dart:async";
import "../../Utils/expect.dart";

void testNever<X extends Never>() {
  Expect.isTrue((FutureOr<Object>, X) == (Object, Never));
}

typedef T1 = ({dynamic s, Object? i});
typedef T2 = ({dynamic s, FutureOr<Object?> i,});

typedef T3 = (Object?, FutureOr<Object?>);
typedef T4 = (FutureOr<Object?> f, Object? o,);

typedef T5 = (void, dynamic);
typedef T6 = (dynamic, void);
typedef T7 = (Object?,);
typedef T8 = (dynamic,);
typedef T9 = (void,);

main() {
  Expect.isTrue(T1 == T2);
  Expect.isTrue(T3 == T4);
  Expect.isFalse(T5 == T6);
  Expect.isFalse(T7 == T8);
  Expect.isFalse(T7 == T9);
  Expect.isFalse((Object?,) == (dynamic,));
  testNever();
}
