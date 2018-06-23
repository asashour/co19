/*
 * Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion void writeAll(
 *  Iterable objects, [
 *  String separator = ""
 *  ])
 * Iterates over the given objects and writes them in sequence.
 *
 * If separator is provided, a write with the separator is performed between any
 * two elements of objects`.
 *
 * This operation is non-blocking. See flush or done for how to get any errors
 * generated by this call.
 * @description Checks that this method iterates over the given objects and
 * writes them in sequence.
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";

var localhost = InternetAddress.LOOPBACK_IP_V4.address;

test(String method) async {
  asyncStart();
  Iterable<String> objects = ["Lily", " ", "was", " ", "here", ""];
  HttpServer server = await HttpServer.bind(localhost, 0);
  server.listen((HttpRequest request) {
    request.toList().then((List<List<int>> l) {
      Expect.equals("Lily was here", new String.fromCharCodes(l[0]));
      request.response.close();
      server.close();
      asyncEnd();
    });
  });

  HttpClient client = new HttpClient();
  client.open(method, localhost, server.port, "")
      .then((HttpClientRequest request) {
    request.contentLength = "Lily was here".length;
    request.writeAll(objects);
    return request.close();
  });
}

main() {
  test("get");
  test("head");
  test("delete");
  test("put");
  test("post");
  test("patch");
}
