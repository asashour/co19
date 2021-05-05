// Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// @assertion Let d be the declaration of a variable v.  If d is a local or
/// instance variable, then the invocation of the implicit getter of v
/// evaluates to the value stored in v.
/// If d is a static or library variable then the implicit getter method of v
/// executes as follows:
/// - Non-constant variable declaration with initializer. If d is of one of the 
///   forms var v = e; , T v = e; , final v = e; , final T v = e; , static 
///   v = e; , static T v = e; , static final v = e;  or static final T v = e; 
///   and no value has yet been stored into v then the initializer expression 
///   e is evaluated. If, during the evaluation of e, the getter  for v is 
///   invoked, a CyclicInitializationError is thrown. If the evaluation 
///   succeeded yielding an object o, let r = o, otherwise let r = null. In 
///   any case, r is stored into v. The result of executing the getter is r.
/// - Constant variable declaration. If d is of one of the forms const v = e; ,
///   const T v = e; , static const v = e;  or static const T v = e; the result
///   of the getter is the value of the compile time constant e. Note that a
///   compile time constant cannot depend on itself, so no cyclic references 
///   can occur. Otherwise
/// - Variable declaration without initializer. The result of executing the
///   getter method is the value stored in v.
/// @description Checks that if during the evaluation of e, the getter for v
/// is invoked, a CyclicInitializationError is thrown. Also expects that
/// after that the result of getter is [:null:]
/// @author msyabro
/// @reviewer iefremov

import "../../../Utils/expect.dart";

f(func) {
  try {
    throw 1; // caugth exceptions do not matter
  } on int catch (e) {
    func();
  }
}

class C {
  static var sVar = f(() => sVar);
  static int sTyped = f(() => sTyped);
  static final sFinal = f(() => sFinal);
  static final int sFinalTyped = f(() => sFinalTyped);
}


main() {
  Expect.throws(() => C.sVar, (e) => e is CyclicInitializationError);
  Expect.equals(null, C.sVar);

  Expect.throws(() => C.sTyped, (e) => e is CyclicInitializationError);
  Expect.equals(null, C.sTyped);

  Expect.throws(() => C.sFinal, (e) => e is CyclicInitializationError);
  Expect.equals(null, C.sFinal);

  Expect.throws(() => C.sFinalTyped, (e) => e is CyclicInitializationError);
  Expect.equals(null, C.sFinalTyped);
}
