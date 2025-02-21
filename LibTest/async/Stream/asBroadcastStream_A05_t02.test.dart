// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Stream<T> asBroadcastStream (
///   {void onListen(StreamSubscription<T> subscription),
///    void onCancel(StreamSubscription<T> subscription)})
/// Returns a multi-subscription stream that produces the same events as this.
///
/// @description Checks Stream interface methods (errors processing)
/// @author a.semenov@unipro.ru

library asBroadcastStream_A05_t02;
import "dart:async";
import "../../../Utils/expect.dart";
import "allTests_A02.lib.dart" as StreamTests;

void test(CreateStreamWithErrorsFunction create) {
  Stream s = create([], isError:(_) => false, defaultValue: Object());
  if (!s.isBroadcast) {
    StreamTests.test(
        <T>(Iterable<T> data, { bool isError(T x)?, required T defaultValue }) {
          return create<T>(data,
              isError: isError,
              defaultValue: defaultValue).asBroadcastStream();
        }
    );
  }
}
