// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Stream.fromFuture(Future<T> future)
/// When the future completes, the stream will fire one event, either data or
/// error, and then close with a done-event.
/// @description Checks that if the future completes normally, the stream will
/// fire one data event, and then close with a done-event.
/// @author kaigorodov

import "dart:async";
import "../../../Utils/expect.dart";

main() {
  // using immediate sync future
  AsyncExpect.data([123], new Stream.fromFuture(new Future.sync(() => 123)));

  // using immediate future
  AsyncExpect.data(["abc"], new Stream.fromFuture(new Future(() => "abc")));

  // using completable future
  Completer completer = new Completer();
  AsyncExpect.data([3.14], new Stream.fromFuture(completer.future));
  completer.complete(3.14);
}
