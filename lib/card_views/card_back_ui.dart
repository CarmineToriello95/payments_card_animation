import 'package:flutter/material.dart';

import '../bloc/card_bloc_provider.dart';
import '../constants.dart';

class CardBackUI extends StatelessWidget {
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
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              color: Colors.black87,
              height: 50.0,
              width: double.infinity,
            ),
            SizedBox(
              height: 16.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.black38,
                    height: 40.0,
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Expanded(
                  child: StreamBuilder<String>(
                    stream: CardBlocProvider.of(context).bloc.sCardSecureCode,
                    builder: (_, snapshot) {
                      return Text(
                        snapshot.data ?? '',
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16.0,
            ),
            Container(
              color: Colors.black12,
              height: 25.0,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
