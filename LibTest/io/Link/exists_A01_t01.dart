// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Future<bool> exists()
/// Checks whether the file system entity with this path exists. Returns a
/// Future<bool> that completes with the result.
///
/// Since FileSystemEntity is abstract, every FileSystemEntity object is
/// actually an instance of one of the subclasses File, Directory, and Link.
/// Calling exists on an instance of one of these subclasses checks whether the
/// object exists in the file system object exists and is of the correct type
/// (file, directory, or link). To check whether a path points to an object on
/// the file system, regardless of the object's type, use the type static
/// method.
///
/// @description Checks that this method checks whether the file system entity
/// with this path exists
///
/// @note The test should run with the Administrator priveleges on Windows.
/// Dart API Spec reads:
/// In order to create a symbolic link on Windows, Dart must be run in
/// Administrator mode or the system must have Developer Mode enabled, otherwise
/// a FileSystemException will be raised with ERROR_PRIVILEGE_NOT_HELD set as
/// the errno when this call is made.
///
/// @author sgrekhov@unipro.ru

import "dart:io";
import "../../../Utils/expect.dart";
import "../file_utils.dart";

main() async {
  await inSandbox(_main);
}

_main(Directory sandbox) async {
  Link link = getTempLinkSync(parent: sandbox);
  asyncStart();

  await link.exists().then((result) {
    Expect.isTrue(result);
    asyncEnd();
  });
}
