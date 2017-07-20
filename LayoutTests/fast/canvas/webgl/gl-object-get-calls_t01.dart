/*
 * Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
 * for details. All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */
/** 
 * @description Test of get calls against GL objects like getBufferParameter,
 * etc.
 */
import "dart:html";
import "dart:web_gl" as wgl;
import 'dart:typed_data';
import "../../../testcommon.dart";
import "resources/webgl-test.dart";
import "resources/webgl-test-utils.dart" as wtu;
import "../../../../Utils/async_utils.dart";
import "pwd.dart";

main() {
  document.body.setInnerHtml('''
      <div id="console"></div>
      <div>PASS</div>
      ''', treeSanitizer: new NullTreeSanitizer());

  var gl;

  sizeInBytes(type) {
    switch (type) {
      case wgl.BYTE:
      case wgl.UNSIGNED_BYTE:
        return 1;
      case wgl.SHORT:
      case wgl.UNSIGNED_SHORT:
        return 2;
      case wgl.INT:
      case wgl.UNSIGNED_INT:
      case wgl.FLOAT:
        return 4;
      default:
        throw "unknown type";
    }
  }

  gl = create3DContext();

  var standardVert = loadStandardVertexShader(gl);
  var standardFrag = loadStandardFragmentShader(gl);
  var standardProgram = gl.createProgram();
  gl.attachShader(standardProgram, standardVert);
  gl.attachShader(standardProgram, standardFrag);
  gl.linkProgram(standardProgram);
  var shaders = gl.getAttachedShaders(standardProgram);
  shouldBe(shaders.length, 2);
  shouldBeTrue(shaders[0] == standardVert && shaders[1] == standardFrag || shaders[1] == standardVert && shaders[0] == standardFrag);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  shouldBeNull(gl.getAttachedShaders(null));
  glErrorShouldBe(gl, wgl.INVALID_VALUE);
  shouldThrow(() => gl.getAttachedShaders(standardVert));
  glErrorShouldBe(gl, wgl.NO_ERROR);

  // Test getBufferParameter
  var buffer = gl.createBuffer();
  gl.bindBuffer(wgl.ARRAY_BUFFER, buffer);
  gl.bufferData(wgl.ARRAY_BUFFER, 16, wgl.DYNAMIC_DRAW);
  shouldBe(gl.getBufferParameter(wgl.ARRAY_BUFFER, wgl.BUFFER_SIZE), 16);
  shouldBe(gl.getBufferParameter(wgl.ARRAY_BUFFER, wgl.BUFFER_USAGE), wgl.DYNAMIC_DRAW);

  // Test getFramebufferAttachmentParameter
  var texture = gl.createTexture();
  gl.bindTexture(wgl.TEXTURE_2D, texture);
  gl.texImage2D(wgl.TEXTURE_2D, 0, wgl.RGBA, 2, 2, 0, wgl.RGBA, wgl.UNSIGNED_BYTE,
      new Uint8List.fromList([
        0, 0, 0, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        0, 0, 0, 255]));
  gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_MIN_FILTER, wgl.LINEAR);
  gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_MAG_FILTER, wgl.LINEAR);
  gl.bindTexture(wgl.TEXTURE_2D, null);
  var framebuffer = gl.createFramebuffer();
  gl.bindFramebuffer(wgl.FRAMEBUFFER, framebuffer);
  gl.framebufferTexture2D(wgl.FRAMEBUFFER, wgl.COLOR_ATTACHMENT0, wgl.TEXTURE_2D, texture, 0);
  var renderbuffer = gl.createRenderbuffer();
  glErrorShouldBe(gl, wgl.NO_ERROR);
  gl.bindRenderbuffer(wgl.RENDERBUFFER, renderbuffer);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  gl.renderbufferStorage(wgl.RENDERBUFFER, wgl.DEPTH_COMPONENT16, 2, 2);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  gl.framebufferRenderbuffer(wgl.FRAMEBUFFER, wgl.DEPTH_ATTACHMENT, wgl.RENDERBUFFER, renderbuffer);
  // FIXME: on some machines (in particular the WebKit commit bots) the
  // framebuffer status is FRAMEBUFFER_UNSUPPORTED; more investigation
  // is needed why this is the case, because the FBO allocated
  // internally by the WebKit implementation has almost identical
  // parameters to this one. See https://bugs.webkit.org/show_bug.cgi?id=31843.
  shouldBe(gl.checkFramebufferStatus(wgl.FRAMEBUFFER), wgl.FRAMEBUFFER_COMPLETE);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.COLOR_ATTACHMENT0, wgl.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE), wgl.TEXTURE);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.COLOR_ATTACHMENT0, wgl.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME), texture);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.COLOR_ATTACHMENT0, wgl.FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL), 0);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.COLOR_ATTACHMENT0, wgl.FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE), 0);

  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.DEPTH_ATTACHMENT, wgl.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE), wgl.RENDERBUFFER);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.DEPTH_ATTACHMENT, wgl.FRAMEBUFFER_ATTACHMENT_OBJECT_NAME), renderbuffer);

  // Test getProgramParameter
  shouldBe(gl.getProgramParameter(standardProgram, wgl.DELETE_STATUS), false);
  shouldBe(gl.getProgramParameter(standardProgram, wgl.LINK_STATUS), true);
  shouldBeTrue(gl.getProgramParameter(standardProgram, wgl.VALIDATE_STATUS) is bool);
  shouldBe(gl.getProgramParameter(standardProgram, wgl.ATTACHED_SHADERS), 2);
  shouldBe(gl.getProgramParameter(standardProgram, wgl.ACTIVE_ATTRIBUTES), 2);
  shouldBe(gl.getProgramParameter(standardProgram, wgl.ACTIVE_UNIFORMS), 1);

  // Test getRenderbufferParameter
  shouldBe(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_WIDTH), 2);
  shouldBe(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_HEIGHT), 2);
  // Note: we can't test the actual value of the internal format since
  // the implementation is allowed to change it.
  shouldBeNonZero(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_INTERNAL_FORMAT));
  shouldBeNonZero(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_DEPTH_SIZE));
  var colorbuffer = gl.createRenderbuffer();
  glErrorShouldBe(gl, wgl.NO_ERROR);
  gl.bindRenderbuffer(wgl.RENDERBUFFER, renderbuffer);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  gl.renderbufferStorage(wgl.RENDERBUFFER, wgl.RGBA4, 2, 2);
  shouldBeNonZero(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_RED_SIZE));
  shouldBeNonZero(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_GREEN_SIZE));
  shouldBeNonZero(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_BLUE_SIZE));
  shouldBeNonZero(gl.getRenderbufferParameter(wgl.RENDERBUFFER, wgl.RENDERBUFFER_ALPHA_SIZE));

  // Test getShaderParameter
  shouldBe(gl.getShaderParameter(standardVert, wgl.SHADER_TYPE), wgl.VERTEX_SHADER);
  shouldBe(gl.getShaderParameter(standardVert, wgl.DELETE_STATUS), false);
  shouldBe(gl.getShaderParameter(standardVert, wgl.COMPILE_STATUS), true);

  // Test getTexParameter
  gl.bindFramebuffer(wgl.FRAMEBUFFER, framebuffer);
  gl.bindTexture(wgl.TEXTURE_2D, texture);
  gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_MAG_FILTER, wgl.NEAREST);
  gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_MIN_FILTER, wgl.NEAREST);
  gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_WRAP_S, wgl.CLAMP_TO_EDGE);
  gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_WRAP_T, wgl.CLAMP_TO_EDGE);
  shouldBe(gl.getTexParameter(wgl.TEXTURE_2D, wgl.TEXTURE_MAG_FILTER), wgl.NEAREST);
  shouldBe(gl.getTexParameter(wgl.TEXTURE_2D, wgl.TEXTURE_MIN_FILTER), wgl.NEAREST);
  shouldBe(gl.getTexParameter(wgl.TEXTURE_2D, wgl.TEXTURE_WRAP_S), wgl.CLAMP_TO_EDGE);
  shouldBe(gl.getTexParameter(wgl.TEXTURE_2D, wgl.TEXTURE_WRAP_T), wgl.CLAMP_TO_EDGE);

  // Test getUniform with all variants of data types
  // Boolean uniform variables
  var boolProgram = loadProgram(gl, "$root/resources/boolUniformShader.vert", "$root/resources/noopUniformShader.frag");
  shouldBe(gl.getProgramParameter(boolProgram, wgl.LINK_STATUS), true);
  var bvalLoc = gl.getUniformLocation(boolProgram, "bval");
  var bval2Loc = gl.getUniformLocation(boolProgram, "bval2");
  var bval3Loc = gl.getUniformLocation(boolProgram, "bval3");
  var bval4Loc = gl.getUniformLocation(boolProgram, "bval4");
  gl.useProgram(boolProgram);
  gl.uniform1i(bvalLoc, 1);
  gl.uniform2i(bval2Loc, 1, 0);
  gl.uniform3i(bval3Loc, 1, 0, 1);
  gl.uniform4i(bval4Loc, 1, 0, 1, 0);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  shouldBe(gl.getUniform(boolProgram, bvalLoc), true);
  shouldBeList(gl.getUniform(boolProgram, bval2Loc), [true, false]);
  shouldBeList(gl.getUniform(boolProgram, bval3Loc), [true, false, true]);
  shouldBeList(gl.getUniform(boolProgram, bval4Loc), [true, false, true, false]);
  // Integer uniform variables
  var intProgram = loadProgram(gl, "$root/resources/intUniformShader.vert", "$root/resources/noopUniformShader.frag");
  shouldBe(gl.getProgramParameter(intProgram, wgl.LINK_STATUS), true);
  var ivalLoc = gl.getUniformLocation(intProgram, "ival");
  var ival2Loc = gl.getUniformLocation(intProgram, "ival2");
  var ival3Loc = gl.getUniformLocation(intProgram, "ival3");
  var ival4Loc = gl.getUniformLocation(intProgram, "ival4");
  gl.useProgram(intProgram);
  gl.uniform1i(ivalLoc, 1);
  gl.uniform2i(ival2Loc, 2, 3);
  gl.uniform3i(ival3Loc, 4, 5, 6);
  gl.uniform4i(ival4Loc, 7, 8, 9, 10);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  shouldBe(gl.getUniform(intProgram, ivalLoc), 1);
  shouldBeList(gl.getUniform(intProgram, ival2Loc), [2, 3]);
  shouldBeList(gl.getUniform(intProgram, ival3Loc), [4, 5, 6]);
  shouldBeList(gl.getUniform(intProgram, ival4Loc), [7, 8, 9, 10]);
  // Float uniform variables
  var floatProgram = loadProgram(gl, "$root/resources/floatUniformShader.vert", "$root/resources/noopUniformShader.frag");
  shouldBe(gl.getProgramParameter(floatProgram, wgl.LINK_STATUS), true);
  var fvalLoc = gl.getUniformLocation(floatProgram, "fval");
  var fval2Loc = gl.getUniformLocation(floatProgram, "fval2");
  var fval3Loc = gl.getUniformLocation(floatProgram, "fval3");
  var fval4Loc = gl.getUniformLocation(floatProgram, "fval4");
  gl.useProgram(floatProgram);
  gl.uniform1f(fvalLoc, 11);
  gl.uniform2f(fval2Loc, 12, 13);
  gl.uniform3f(fval3Loc, 14, 15, 16);
  gl.uniform4f(fval4Loc, 17, 18, 19, 20);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  shouldBe(gl.getUniform(floatProgram, fvalLoc), 11);
  shouldBeList(gl.getUniform(floatProgram, fval2Loc), [12, 13]);
  shouldBeList(gl.getUniform(floatProgram, fval3Loc), [14, 15, 16]);
  shouldBeList(gl.getUniform(floatProgram, fval4Loc), [17, 18, 19, 20]);
  // Sampler uniform variables
  var samplerProgram = loadProgram(gl, "$root/resources/noopUniformShader.vert", "$root/resources/samplerUniformShader.frag");
  shouldBe(gl.getProgramParameter(samplerProgram, wgl.LINK_STATUS), true);
  var s2DValLoc = gl.getUniformLocation(samplerProgram, "s2D");
  var sCubeValLoc = gl.getUniformLocation(samplerProgram, "sCube");
  gl.useProgram(samplerProgram);
  gl.uniform1i(s2DValLoc, 0);
  gl.uniform1i(sCubeValLoc, 1);
  glErrorShouldBe(gl, wgl.NO_ERROR);
  shouldBe(gl.getUniform(samplerProgram, s2DValLoc), 0);
  shouldBe(gl.getUniform(samplerProgram, sCubeValLoc), 1);
  // Matrix uniform variables
  var matProgram = loadProgram(gl, "$root/resources/matUniformShader.vert", "$root/resources/noopUniformShader.frag");
  shouldBe(gl.getProgramParameter(matProgram, wgl.LINK_STATUS), true);
  var mval2Loc = gl.getUniformLocation(matProgram, "mval2");
  var mval3Loc = gl.getUniformLocation(matProgram, "mval3");
  var mval4Loc = gl.getUniformLocation(matProgram, "mval4");
  gl.useProgram(matProgram);
  gl.uniformMatrix2fv(mval2Loc, false, new Float32List.fromList([1.0, 2.0, 3.0, 4.0]));
  gl.uniformMatrix3fv(mval3Loc, false, new Float32List.fromList([5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0]));
  gl.uniformMatrix4fv(mval4Loc, false, new Float32List.fromList([14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0, 21.0, 22.0, 23.0, 24.0, 25.0, 26.0, 27.0, 28.0, 29.0]));
  glErrorShouldBe(gl, wgl.NO_ERROR);
  shouldBeList(gl.getUniform(matProgram, mval2Loc), [1, 2, 3, 4]);
  shouldBeList(gl.getUniform(matProgram, mval3Loc), [5, 6, 7, 8, 9, 10, 11, 12, 13]);
  shouldBeList(gl.getUniform(matProgram, mval4Loc), [14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29]);

  // Test getVertexAttrib
  var array = new Float32List.fromList([1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0]);
  gl.bindBuffer(wgl.ARRAY_BUFFER, buffer);
  gl.bufferData(wgl.ARRAY_BUFFER, array, wgl.DYNAMIC_DRAW);
  // Vertex attribute 0 is special in that it has no current state, so
  // fetching GL_CURRENT_VERTEX_ATTRIB generates an error. Use attribute
  // 1 for these tests instead.
  gl.enableVertexAttribArray(1);
  gl.vertexAttribPointer(1, 4, wgl.FLOAT, false, 0, 0);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING), buffer);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_ENABLED), true);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_SIZE), 4);
  // Stride MUST be the value the user put in.
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_STRIDE), 0);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_TYPE), wgl.FLOAT);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_NORMALIZED), false);
  gl.vertexAttribPointer(1, 4, wgl.FLOAT, false, 36, 12);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_STRIDE), 36);
  shouldBe(gl.getVertexAttribOffset(1, wgl.VERTEX_ATTRIB_ARRAY_POINTER), 12);
  gl.disableVertexAttribArray(1);
  shouldBe(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_ENABLED), false);
  gl.vertexAttrib4f(1, 5, 6, 7, 8);
  shouldBeList(gl.getVertexAttrib(1, wgl.CURRENT_VERTEX_ATTRIB), [5, 6, 7, 8]);
  glErrorShouldBe(gl, wgl.NO_ERROR);

  // Test cases where name == 0
  gl.deleteTexture(texture);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.COLOR_ATTACHMENT0, wgl.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE), wgl.NONE);
  gl.deleteRenderbuffer(renderbuffer);
  shouldBe(gl.getFramebufferAttachmentParameter(wgl.FRAMEBUFFER, wgl.DEPTH_ATTACHMENT, wgl.FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE), wgl.NONE);
  gl.deleteBuffer(buffer);
  shouldBeNull(gl.getVertexAttrib(1, wgl.VERTEX_ATTRIB_ARRAY_BUFFER_BINDING));
  glErrorShouldBe(gl, wgl.NO_ERROR);
}
