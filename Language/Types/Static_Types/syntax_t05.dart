/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion Static type annotations are used in variable declarations
 * (including formal parameters), in the return types of functions and in the
 * bounds of type variables. Static type annotations are used during static
 * checking and when running programs in checked mode. They have no effect
 * whatsoever in production mode.
 * type:
 *   typeName typeArguments?
 * ;
 * typeName:
 *   qualified
 * ;
 * typeArguments:
 *   '<' typeList '>'
 * ;
 * typeList:
 *   type (',' type)*
 * ;
 * @description Checks that it is a compile-time error when the type arguments
 * are only space delimited.
 * @compile-error
 * @author iefremov
 */

class G<A, B> {
  G() {}
}

main() {
  G<int double>? g;
}
