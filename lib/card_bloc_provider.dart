import 'package:flutter/material.dart';
import 'package:payments_card_animation/card_bloc.dart';

class CardBlocProvider extends InheritedWidget {
  CardBlocProvider({Key key, Widget child, this.bloc})
      : super(key: key, child: child);

  final CardBloc bloc;

  static CardBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CardBlocProvider>();
  }

  @override
  bool updateShouldNotify(CardBlocProvider oldWidget) {
    return true;
  }
}
