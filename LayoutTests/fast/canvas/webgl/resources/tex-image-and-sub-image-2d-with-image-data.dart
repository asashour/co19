
library tex_image_and_sub_image_2d_with_image_data;

import 'dart:html';
import 'dart:web_gl' as wgl;
import 'webgl-test.dart';
import 'webgl-test-utils.dart' as wtu;
import "../../../../testcommon.dart";

generateTest(pixelFormat, pixelType, prologue) {
  var gl = null;
  var textureLoc = null;
  var imageData = null;

  runOneIteration(useTexSubImage2D, flipY, premultiplyAlpha, topColor, bottomColor)
  {
    debug('Testing ' + (useTexSubImage2D ? 'texSubImage2D' : 'texImage2D') +
        ' with flipY=$flipY and premultiplyAlpha=$premultiplyAlpha');
    gl.clear(wgl.COLOR_BUFFER_BIT | wgl.DEPTH_BUFFER_BIT);
    // Enable writes to the RGBA channels
    gl.colorMask(true, true, true, false);
    var texture = gl.createTexture();
    // Bind the texture to texture unit 0
    gl.bindTexture(wgl.TEXTURE_2D, texture);
    // Set up texture parameters
    gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_MIN_FILTER, wgl.NEAREST);
    gl.texParameteri(wgl.TEXTURE_2D, wgl.TEXTURE_MAG_FILTER, wgl.NEAREST);
    // Set up pixel store parameters
    gl.pixelStorei(wgl.UNPACK_FLIP_Y_WEBGL, flipY ? 1 : 0);
    gl.pixelStorei(wgl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, premultiplyAlpha ? 1 : 0);
    // Upload the image into the texture
    if (useTexSubImage2D) {
      // Initialize the texture to black first
      gl.texImage2D(wgl.TEXTURE_2D, 0, pixelFormat, 1, 2, 0,
          pixelFormat, pixelType, null);
      gl.texSubImage2D(wgl.TEXTURE_2D, 0, 0, 0, pixelFormat, pixelType, imageData);
    } else {
      gl.texImage2D(wgl.TEXTURE_2D, 0, pixelFormat, pixelFormat, pixelType, imageData);
    }

    // Point the uniform sampler to texture unit 0
    gl.uniform1i(textureLoc, 0);
    // Draw the triangles
    wtu.drawQuad(gl, [0, 0, 0, 255]);

    // Check the top pixel and bottom pixel and make sure they have
    // the right color.
    debug("Checking bottom pixel");
    wtu.checkCanvasRect(gl, 0, 0, 1, 1, bottomColor, "shouldBe $bottomColor");
    debug("Checking top pixel");
    wtu.checkCanvasRect(gl, 0, 1, 1, 1, topColor, "shouldBe $topColor");
  }

  runTest()
  {
    var red = [255, 0, 0, 255];
    var green = [0, 255, 0, 255];
    var redPremultiplyAlpha = [255, 0, 0, 255];
    var greenPremultiplyAlpha = [0, 0, 0, 255];

    runOneIteration(false, true, false,
        red, green);
    runOneIteration(false, false, false,
        green, red);
    runOneIteration(false, true, true,
        redPremultiplyAlpha, greenPremultiplyAlpha);
    runOneIteration(false, false, true,
        greenPremultiplyAlpha, redPremultiplyAlpha);
    runOneIteration(true, true, false,
        red, green);
    runOneIteration(true, false, false,
        green, red);
    runOneIteration(true, true, true,
        redPremultiplyAlpha, greenPremultiplyAlpha);
    runOneIteration(true, false, true,
        greenPremultiplyAlpha, redPremultiplyAlpha);

    glErrorShouldBe(gl, wgl.NO_ERROR, "should be no errors");
  }

  var init = ()
  {
    debug('Verify texImage2D and texSubImage2D code paths taking ImageData ($pixelFormat/$pixelType)');

    gl = wtu.create3DContext("example");

    if (!prologue(gl)) {
      return;
    }

    var program = wtu.setupTexturedQuad(gl);
    gl.clearColor(0,0,0,1);
    gl.clearDepth(1);
    gl.disable(wgl.BLEND);

    textureLoc = gl.getUniformLocation(program, "tex");

    dynamic canvas2d = document.getElementById("texcanvas");
    var context2d = canvas2d.getContext("2d");
    imageData = context2d.createImageData(1, 2);
    var data = imageData.data;
    data[0] = 255;
    data[1] = 0;
    data[2] = 0;
    data[3] = 255;
    data[4] = 0;
    data[5] = 255;
    data[6] = 0;
    data[7] = 0;

    runTest();
  };

  return init;
}
