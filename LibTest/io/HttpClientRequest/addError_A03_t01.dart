// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion void addError(
///  error, [
///  StackTrace stackTrace
/// ])
/// Passes the error to the target consumer as an error event.
///
/// This function must not be called when a stream is currently being added using
/// addStream.
///
/// This operation is non-blocking. See flush or done for how to get any errors
/// generated by this call.
/// @description Checks that this operation is non-blocking
/// @author sgrekhov@unipro.ru
/// @issue 31723

import "dart:io";
import "../../../Utils/expect.dart";

var localhost = InternetAddress.loopbackIPv4.address;

test(String method) async {
  asyncStart();
  HttpServer server = await HttpServer.bind(localhost, 0);
  server.listen((HttpRequest request) {
    Expect.fail("Error expected");
  });
  server.handleError((e) {
    Expect.fail("Error on the client end expected");
  });

  HttpClient client = new HttpClient();
  client.open(method, localhost, server.port, "")
      .then((HttpClientRequest request) {
    request.addError("Error 1");
    request.addError("Error 2");
    request.addError("Error 3");
    return request.close();
  }).then((HttpClientResponse response) {
    Expect.fail("Error expected");
  }, onError: (e) {
    Expect.equals("Error 1", e);
    server.close();
    asyncEnd();
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
