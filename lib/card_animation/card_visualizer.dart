import 'dart:math' as math;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'card_visualizer_controller.dart';

class CardVisualizer extends StatefulWidget {
  final Duration animationDuration;
  final CardVisualizerController controller;
  final Widget widgetFront;
  final Widget widgetBack;
  final bool enableScroll;
  final double itemsWidth;

  CardVisualizer({
    Key key,
    @required this.widgetFront,
    @required this.widgetBack,
    this.enableScroll = false,
    this.animationDuration = const Duration(milliseconds: 500),
    CardVisualizerController controller,
    this.itemsWidth,
    Function onPageChanged,
  })  : controller = controller ?? CardVisualizerController(),
        super(key: key);

  @override
  CardVisualizerState createState() => CardVisualizerState();
}

class CardVisualizerState extends State<CardVisualizer>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  bool _isDraggable;
  double _itemsWidth;

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.itemsWidth != null) {
      _itemsWidth = widget.itemsWidth;
    } else {
      _itemsWidth = MediaQuery.of(context).size.width;
    }
  }

  void _initValues() {
    _animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    widget.controller.animation = _animationController;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, __) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(
                  math.pi * _animationController.value,
                ),
              alignment: Alignment.center,
              child: _animationController.value < 0.5
                  ? widget.widgetFront
                  : Transform(
                      transform: Matrix4.identity()
                        ..rotateY(
                          math.pi,
                        ),
                      alignment: Alignment.center,
                      child: widget.widgetBack,
                    ),
            );
          }),
    );
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragFromLeft = _animationController.isCompleted &&
        details.globalPosition.dx < _itemsWidth / 2;
    bool isDragFromRight = _animationController.isDismissed &&
        details.globalPosition.dx > _itemsWidth / 2;
    _isDraggable = isDragFromLeft || isDragFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isDraggable) {
      double delta = details.primaryDelta / _itemsWidth;

      _animationController.value -= delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >=
        MediaQuery.of(context).size.width / 2) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;
      _animationController.fling(velocity: -visualVelocity);
    } else if (_animationController.value > 0.5) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }
}
