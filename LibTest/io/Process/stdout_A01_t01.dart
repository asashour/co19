/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion  Stream<List<int>> stdout
 *
 * Returns the standard output stream of the process as a Stream.
 *
 * @description Checks that [stdout] returns Stream<List<int>> value that is the
 * standard output stream of the process as a Stream.
 * @author ngl@unipro.ru
 */
import 'dart:convert';
import "dart:io";
import "dart:async";
import "../../../Utils/expect.dart";

runMain() {
  String command = Platform.resolvedExecutable;
  String eScript = Platform.script.toString();
  List<String> args = [
    eScript,
    'Hi, stdout',
    'Hi, stderr'
  ];

  asyncStart();
  Process.start(command, args).then((Process process) {
    Expect.isTrue(process.stderr is Stream<List<int>>);
    Utf8Decoder decoder = new Utf8Decoder();
    process.stdout.toList().then((List outList) async {
      if (outList.isEmpty) {
        List stderr = await process.stderr.toList();
        Expect.fail("Stdout is empty. Stderr: $stderr");
      }
      String decoded = decoder.convert(outList[0]);
      Expect.isTrue(decoded.contains("Hi, stdout"), "Actual value: $decoded");
      asyncEnd();
    });
  });
}

runProcess(List<String> arguments) {
  if (arguments.length > 0) {
    stdout.write(arguments[0]);
  }
  if (arguments.length > 1) {
    stderr.write(arguments[1]);
  }
  if (arguments.length > 2) {
    stdin.listen((List<int> event){
      Utf8Decoder decoder = new Utf8Decoder();
      String decoded = decoder.convert(event);
      stdout.write(decoded);
    });
  }
}

main(List<String> args) {
  if(args.length > 0)
    runProcess(args);
  else {
    runMain();
  }
}
