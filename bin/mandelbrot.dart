import 'dart:io';

import 'package:complex/complex.dart';
import 'package:image/image.dart';

void main() {
  const xmin = -2, ymin = -2, xmax = 2, ymax = 2;
  const width = 1024, height = 1024;

  final img = Image(width: width, height: height);
  for (var py = 0; py < height; py++) {
    final y = py / height * (ymax - ymin) + ymin;
    for (var px = 0; px < width; px++) {
      final x = px / width * (xmax - xmin) + xmin;
      final z = Complex(x, y);
      img.setPixel(px, py, mandelbrot(z));
    }
  }
  File('img.png').writeAsBytesSync(encodePng(img));
}

ColorUint8 mandelbrot(Complex z) {
  const iterations = 200;
  const contrast = 15;

  var v = Complex.zero;
  for (var n = 0; n < iterations; n++) {
    v = (v * v) + z;
    if (v.abs() > 2) {
      final grayTone = 255 - contrast * n;
      return ColorUint8.rgb(grayTone, grayTone, grayTone);
    }
  }
  return ColorUint8.rgb(0, 0, 0);
}
