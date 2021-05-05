// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Future<T> singleWhere(bool test(T element))
/// Like lastMatch, except that it is an error if more than one matching element occurs in the stream.
/// @description Checks that it is an error if more than one matching element occurs in the stream.
/// @author kaigorodov

import "dart:async";
import "../../../Utils/expect.dart";
import "IsolateStream.dart" as IsolateStream;

void check(Iterable data, bool test(var element), var expected) {
  Stream s = IsolateStream.fromIterable(data);
  asyncStart();
  Future f = s.singleWhere(test);
  f.then((var value) {
      Expect.fail("unexpected call ot onValue($value)");
    },
    onError: (Object error){
      asyncEnd();
    }
  );
}

main() {
  check([1, 2, 3], (var element) => true, 3);
  check([1, 2, 3], (var element) => element != null, 3);
  check([1, 2, 3], (var element) => element > 0, 3);
  check(new Iterable.generate(10, (int index) => index * 5), (var element) => element != 30, 45);
}
