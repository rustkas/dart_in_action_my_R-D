library coords;

import 'dart:math';

class Coords {
  /// Координата "x" точки
  double x=0;

  /// Координата "y" точки
  double y=0;

  /// Координата "z" точки
  double z=0;

Coords.xyz([double x=0,double y=0,double z=0]) {
  this.x = x;
  this.y = y;
  this.z =z;
}

  double getDistance(){
    
    return sqrt(x*x + y*y+z*z);
  }
}
