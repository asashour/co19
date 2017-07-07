/*
 * Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Future<File> copy(String newPath)
 * Copy this file. Returns a Future<File> that completes with a File instance
 * for the copied file.
 *
 * If newPath identifies an existing file, that file is replaced. If newPath
 * identifies an existing directory, the operation fails and the future
 * completes with an exception.
 * @description Checks that if newPath identifies an existing directory, the
 * operation fails and the future completes with an exception
 * @author sgrekhov@unipro.ru
 */
import "dart:io";
import "../../../Utils/expect.dart";
import "../../../Utils/file_utils.dart";
import "../../../Utils/async_utils.dart";

main() {
  File file = getTempFileSync();
  Directory dir = getTempDirectorySync();
  asyncStart();
  file.copy(dir.path).then((File copied) {
    Expect.fail("Exception expected");
  }, onError: (_) {
    try {
      Expect.isTrue(dir.existsSync());
      asyncEnd();
    } finally {
      file.delete();
      dir.delete();
    }
  });
}
