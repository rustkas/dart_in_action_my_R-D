library circle;
import 'dart:math';

class Circle {

  /// Радиус окружности
  double r;

double radiusToDegree(double radius){
  return radius *180 / pi;
}
/// Площадь круга
double area(){
  return pi * r * r;
}

double circle_length(){
  return 2*pi*r;
}
}