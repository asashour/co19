/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future<HttpClientResponse> done
 * A HttpClientResponse future that will complete once the response is
 * available. If an error occurs before the response is available, this future
 * will complete with an error.
 * @description Checks that if an error occurs before the response is available,
 * this future will complete with an error.
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";

var localhost = InternetAddress.LOOPBACK_IP_V4.address;

test(String method) async {
  asyncStart();
  String helloWorld = "Hello test world!";
  HttpServer server = await HttpServer.bind(localhost, 0);
  server.listen((HttpRequest request) {
    request.response.write(helloWorld);
    request.response.close();
  });

  HttpClient client = new HttpClient();
  client.open(method, localhost, server.port + 1, "")
      .then((HttpClientRequest request) {
        request.done.catchError((_) {
          server.close();
          asyncEnd();
        });
        return request.close();
  });
}

main() {
  test("no-such-method");
}
