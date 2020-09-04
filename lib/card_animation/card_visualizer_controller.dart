import 'package:flutter/material.dart';

class CardVisualizerController {
  AnimationController animation;

  void toggle() {
    if (animation.value == 0) {
      animation.forward();
    } else {
      animation.reverse();
    }
  }

  void open() {
    if (animation.value == 0) {
      animation.forward();
    }
  }

  void close() {
    if(animation.value == 1){
      animation.reverse();
    }
  }

  void dispose(){
    animation.dispose();
  }
}
