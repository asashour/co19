/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion StreamController({void onListen(), void onPause(),
 *                  void onResume(), dynamic onCancel(), bool sync: false})
 * The onListen callback is called when the stream receives its listener
 * and onCancel when the listener ends its subscription.
 *
 * @description Checks that the onCancel function is called when the listener
 * ends its subscription.
 * @author kaigorodov
 */
import "dart:async";
import "../../../Utils/expect.dart";

main() {
  bool onCancelCalled = false;
  asyncStart();
  StreamController controller = new StreamController(
    onCancel: () {
      onCancelCalled = true;
    }
  );

  Expect.isFalse(onCancelCalled);
  StreamSubscription subs = controller.stream.listen((event) {});

  new Future(() => subs.cancel()).then(
      (_) {
        Expect.isTrue(onCancelCalled);
        asyncEnd();
      }
  );
}
