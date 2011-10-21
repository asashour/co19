/*
 * Copyright (c) 2011, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/**
 * @assertion int extends num and type num implements Comparable interface.
 * @description Checks that the compareTo method is implemented correctly for integer arguments.
 * @author vasya
 * @reviewer msyabro
 * @reviewer rodionov
 */

main() {
  Expect.equals(0,  0.compareTo(0));
  Expect.equals(1,  0.compareTo(-1));
  Expect.equals(-1, 0.compareTo(1));

  Expect.equals(0,  2147483647.compareTo(2147483647));
  Expect.equals(1,  2147483647.compareTo(2147483646));
  Expect.equals(-1, 2147483647.compareTo(2147483648));

  Expect.equals(0,  (-2147483648).compareTo(-2147483648));
  Expect.equals(-1, (-2147483648).compareTo(-2147483647));
  Expect.equals(1,  (-2147483648).compareTo(-2147483649));

  Expect.equals(0,  9223372036854775807.compareTo(9223372036854775807));
  Expect.equals(1,  9223372036854775807.compareTo(9223372036854775806));
  Expect.equals(-1, 9223372036854775807.compareTo(9223372036854775808));

  Expect.equals(0,  (-9223372036854775808).compareTo(-9223372036854775808));
  Expect.equals(-1, (-9223372036854775808).compareTo(-9223372036854775807));
  Expect.equals(1,  (-9223372036854775808).compareTo(-9223372036854775809));

  Expect.equals(0,  111111111111111111111111111111111111111111111111.compareTo(111111111111111111111111111111111111111111111111));
  Expect.equals(1,  111111111111111111111111111111111111111111111111.compareTo(111111111111111111111111111111111111111111111110));
  Expect.equals(-1, 111111111111111111111111111111111111111111111111.compareTo(1111111111111111111111111111111111111111111111111111));

  Expect.equals(0, 0x18000000000000000.compareTo(0x18000000000000000));
  Expect.equals(1, 0x18000000000000000.compareTo(0x1999999999999999));
}
