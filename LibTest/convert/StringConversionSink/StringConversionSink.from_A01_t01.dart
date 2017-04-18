/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion StringConversionSink.from(Sink<String> sink)
 * @description Checks that this constructor creates StringConversionSink
 * @author sgrekhov@unipro.ru
 */
import "dart:convert";
import "../../../Utils/expect.dart";
import "../../../Utils/async_utils.dart";

main() {
  var c = new StreamController();
  dynamic sink = c.sink;

  StringConversionSink outSink = new StringConversionSink.from(sink);

  ByteConversionSink inSink = ASCII.decoder.startChunkedConversion(outSink);
  var list = ASCII.encode("12345");
  inSink.add(list);
  list = ASCII.encode("absdABCD");
  inSink.add(list);
  inSink.close();

  asyncStart();
  c.stream.toList().then((x) {
    Expect.listEquals(["12345", "absdABCD"], x);
    asyncEnd();
  });
  c.close();
}
