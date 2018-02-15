/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Stream<T> skipWhile(bool test(T element))
 * Skip data events from this stream while they are matched by test.
 *
 * Error and done events are provided by the returned stream unmodified.
 *
 * @description Checks that if this stream is closed, the done event is provided
 * by the return stream unmodified.
 * @author ngl@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

check(test(e), expected) {
  asyncStart();
  var address = InternetAddress.LOOPBACK_IP_V4;
  RawDatagramSocket.bind(address, 0).then((producer) {
    RawDatagramSocket.bind(address, 0).then((receiver) {
      int sent = 0;
      List list = [];
      producer.send([sent++], address, receiver.port);
      producer.send([sent++], address, receiver.port);
      producer.close();
      receiver.close();

      Stream s = receiver.skipWhile((e) => test(e));
      s.listen((event) {
        list.add(event);
      }, onDone: () {
        Expect.listEquals(expected, list);
        asyncEnd();
      });
    });
  });
}

main() {
  check((e) => false, [RawSocketEvent.CLOSED]);
  check((e) => true, []);
  check((e) => e == RawSocketEvent.CLOSED, []);
}
