/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS
 * file for details. All rights reserved. Use of this source code is governed
 * by a BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Capability pause([
 *    Capability resumeCapability
 * ])
 *    Requests the isolate to pause.
 *    When the isolate receives the pause command, it stops processing events
 * from the event loop queue. It may still add new events to the queue in
 * response to, e.g., timers or receive-port messages. When the isolate is
 * resumed, it handles the already enqueued events.
 *
 * @description Check that pause() with given capability does not stop the
 * isolate to execute code.
 *
 * @author a.semenov@unipro.ru
 */
import "dart:isolate";
import "dart:math";
import "../../../Utils/expect.dart";

// indefinitely running isolate
entryPoint(List<SendPort> sendPorts) {
  sendPorts[0].send(42);
  Random random = new Random();
  int s = 0;
  while (true) {
    s = -s + random.nextInt(100);
    sendPorts[1].send(s);
  }
}

test() async {
  ReceivePort receivePort1 = new ReceivePort();
  ReceivePort receivePort2 = new ReceivePort();
  ReceivePort onExit = new ReceivePort();
  Isolate isolate =
      await Isolate.spawn(entryPoint,
          [receivePort1.sendPort, receivePort2.sendPort],
          onExit: onExit.sendPort,
          errorsAreFatal: true);
  // make sure that isolate started its work
  await receivePort1.first;
  isolate.pause(new Capability());
  // check that messages are received from paused isolate
  int count = 0;
  await for (var _ in receivePort2) {
    if (count++ == 1000000) {
      break;
    }
  }
  // clean up
  isolate.kill(priority: Isolate.immediate);
  await onExit.first;
  asyncEnd();
}

main() {
  asyncStart();
  test();
}
