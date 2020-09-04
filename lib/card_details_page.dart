import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payments_card_animation/card_views/card_back_ui.dart';
import 'package:payments_card_animation/bloc/card_bloc.dart';
import 'package:payments_card_animation/card_views/card_front_ui.dart';
import 'package:payments_card_animation/card_animation/card_visualizer_controller.dart';
import 'package:payments_card_animation/constants.dart';

import 'bloc/card_bloc_provider.dart';
import 'card_animation/card_visualizer.dart';

class CardDetailsPage extends StatefulWidget {
  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  double _screenHeight;
  final CardBloc _cardBloc = CardBloc();
  final FocusNode _secureCodeFocusNode = FocusNode();
  final CardVisualizerController _cardVisualizerController =
      CardVisualizerController();

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  _initValues() {
    _secureCodeFocusNode.addListener(() => _cardVisualizerController.toggle());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
  }

  @override
  void dispose() {
    _cardVisualizerController.dispose();
    _secureCodeFocusNode.dispose();
    _cardBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5F4F4),
      appBar: AppBar(
        title: Text(
          'Credit Card',
          style: labelStyle.copyWith(fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: labelColor,
          ),
          onPressed: () {},
        ),
      ),
      body: CardBlocProvider(
        bloc: _cardBloc,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: _screenHeight * 1.1 / 3,
                child: CardVisualizer(
                  widgetFront: CardFrontUI(),
                  widgetBack: CardBackUI(),
                  controller: _cardVisualizerController,
                  enableScroll: false,
                ),
              ),
              Container(
                height: _screenHeight * 1.9 / 3,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      label: 'Card Number',
                      onChanged: (value) => _cardBloc.changeCardNumber(value),
                      keyboardType: TextInputType.number,
                      maxLength: 16,
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            label: 'Expiry date',
                            onChanged: _cardBloc.changeCardExpiry,
                            keyboardType: TextInputType.datetime,
                            maxLength: 5,
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          flex: 2,
                          child: CustomTextField(
                            label: 'Secure Code',
                            onChanged: _cardBloc.changeCardSecureCode,
                            keyboardType: TextInputType.number,
                            focusNode: _secureCodeFocusNode,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    CustomTextField(
                      label: 'Name on card',
                      onChanged: _cardBloc.changeCardHolder,
                    ),
                    Spacer(),
                    ButtonTheme(
                      minWidth: double.infinity,
                      height: 50.0,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        color: buttonColor,
                        child: Text(
                          'Pay',
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 16.0),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final Function onChanged;
  final TextInputType keyboardType;
  final int maxLength;
  final FocusNode focusNode;
  CustomTextField(
      {this.label = '',
      this.onChanged,
      this.keyboardType = TextInputType.text,
      this.maxLength = 20,
      this.focusNode});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: labelStyle,
        ),
        SizedBox(
          height: 6.0,
        ),
        TextField(
          maxLength: maxLength,
          onChanged: onChanged,
          decoration: textFieldDecoration,
          cursorColor: labelColor,
          style: TextStyle(fontWeight: FontWeight.w300),
          keyboardType: keyboardType,
          focusNode: focusNode,
          textCapitalization: TextCapitalization.words,
        )
      ],
    );
  }
}
