/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion void add(List<int> data)
 *  Adds byte data to the target consumer, ignoring encoding.
 *
 * The encoding does not apply to this method, and the data list is passed
 * directly to the target consumer as a stream event.
 *
 * This function must not be called when a stream is currently being added using
 * addStream.
 *
 * This operation is non-blocking. See flush or done for how to get any errors
 * generated by this call.
 *
 * The data list should not be modified after it has been passed to add.
 * @description Checks that this method adds byte data to the target consumer,
 * ignoring encoding
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "dart:convert";
import "../../../Utils/expect.dart";

var localhost = InternetAddress.LOOPBACK_IP_V4.address;

List<int> list = [256, 257, 1023];

test(String method) async {
  asyncStart();
  String helloWorld = "Hello test world!";
  HttpServer server = await HttpServer.bind(localhost, 0);
  server.listen((HttpRequest request) {
    request.toList().then((data) {
      Expect.listEquals([[0, 1, 255]], data);
      request.response.write(helloWorld);
      request.response.close();
      server.close();
    });
  });

  HttpClient client = new HttpClient();
  client.open(method, localhost, server.port, "")
      .then((HttpClientRequest request) {
    request.contentLength = list.length;
    request.add(list);
    return request.close();
  }).then((HttpClientResponse response) {
    response.transform(UTF8.decoder).listen((content) {});
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
