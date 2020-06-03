import 'dart:html';
import 'dart:math' show pi;

void main() {
  CanvasElement canvas = Element.tag('canvas');
  canvas.width = 300;
  canvas.height = 300;
  document.body.children.add(canvas);

  final ctx = canvas.context2D;
  ctx.fillText('Hello Canvas', 10, 10);
  ctx.beginPath();
  ctx.arc(50, 50, 20, 0, pi * 2, true);
  ctx.closePath();
  ctx.fill();
}


// webdev serve
// localhost:8080
