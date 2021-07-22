// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// @dart = 2.9

/// @assertion an extension declaration is a top-level declaration with a grammar
/// similar to:
/// <extension> ::=
///   `extension' <identifier>? <typeParameters>? `on' <type> `?'? `{'
///     memberDeclaration*
///   `}'
/// Such a declaration introduces its name (the identifier) into the surrounding
/// scope
///
/// @description Check that it is a syntax error if extension declaration is not
/// top-level
/// @author sgrekhov@unipro.ru

class C {
  extension MyFancyList<T> on List<T> {       //# 01: syntax error
    int get doubleLength => this.length * 2;  //# 01: syntax error
  }                                           //# 01: syntax error
}

main() {
  extension MyFancyList<T> on List<T> {       //# 02: syntax error
    int get doubleLength => this.length * 2;  //# 02: syntax error
  }                                           //# 02: syntax error
}
