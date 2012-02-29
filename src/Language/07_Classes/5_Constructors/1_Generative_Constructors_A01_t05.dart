/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion constructorSignature:
 * identifier formalParameterList | namedConstructorSignature  ;
 * namedConstructorSignature:  identifier '.' identifier formalParameterList ;
 * @description Checks that it is a compile-time error if a named constructor has
 * the return type
 * @compile-error
 * @author msyabro
 */

class C {
  C C.name();
}

main() {
  try {
    var c = new C.name();
  } catch(var x){}
}
