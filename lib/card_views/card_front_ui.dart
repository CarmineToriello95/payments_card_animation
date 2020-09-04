import 'package:flutter/material.dart';
import 'package:payments_card_animation/bloc/card_bloc_provider.dart';
import 'package:payments_card_animation/constants.dart';

class CardFrontUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.only(
          left: 16.0, right: 16.0, bottom: 32.0, top: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.centerRight,
              child: StreamBuilder<String>(
                stream: CardBlocProvider.of(context).bloc.sCardNumber,
                builder: (_, snapshot) {
                  return Image.asset(
                    'assets/images/mastercard.png',
                    height: 50.0,
                  );
                },
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: StreamBuilder<String>(
                stream: CardBlocProvider.of(context).bloc.sCardNumber,
                builder: (_, snapshot) {
                  return Text(
                    snapshot.data ?? '',
                    style:
                        TextStyle(fontSize: 24.0, letterSpacing: 2, shadows: [
                      Shadow(
                        color: Colors.black12,
                        offset: Offset(2, 1),
                      )
                    ]),
                  );
                },
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Card Holder'),
                    StreamBuilder<String>(
                      stream: CardBlocProvider.of(context).bloc.sCardHolder,
                      builder: (_, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Expiry'),
                    StreamBuilder<String>(
                      stream: CardBlocProvider.of(context).bloc.sCardExpiry,
                      builder: (_, snapshot) {
                        return Text(
                          snapshot.data ?? '',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      },
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
