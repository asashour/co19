// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion void writeln([Object obj = ""])
/// This operation is non-blocking.
/// @description Checks that [writeln] is non-blocking operation.
/// @author iarkh@unipro.ru

import "../../../Utils/expect.dart";
import "dart:io";

String str = "Testme";

run_process(IOSink sink) {
  sink.writeln(str);
  sink.writeln(str);
  sink.writeln();
  sink.writeln();
  sink.writeln(str);
}

run_main(String mode) async {
  int called = 0;
  String executable = Platform.resolvedExecutable;
  String eScript = Platform.script.toString();
  await Process.run(executable, [eScript, mode]).then((
      ProcessResult results) {
    Expect.equals(str + "\n" + str + "\n\n\n" + str + "\n",
        mode == "err" ? results.stderr : results.stdout);
    called++;
  });
  Expect.equals(1, called);
}

main(List<String> args) {
  if(args.length > 0)
    run_process(args[0] == "err" ? stderr : stdout);
  else {
    run_main("out");
    run_main("err");
  }
}
