import 'package:rxdart/rxdart.dart';

class CardBloc {
  final BehaviorSubject<String> _bCardNumber = BehaviorSubject<String>();
  final BehaviorSubject<String> _bCardHolder = BehaviorSubject<String>();
  final BehaviorSubject<String> _bCardExpiry = BehaviorSubject<String>();
  final BehaviorSubject<String> _bCardSecureCode = BehaviorSubject<String>();

  CardBloc() {
    changeCardNumber('');
  }

  changeCardNumber(String cardNumber) {
    _bCardNumber.sink.add(
      cardNumber
          .padRight(16, '*')
          .replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} "),
    );
  }

  Function(String) get changeCardHolder => _bCardHolder.sink.add;
  Function(String) get changeCardExpiry => _bCardExpiry.sink.add;
  Function(String) get changeCardSecureCode => _bCardSecureCode.sink.add;

  Stream<String> get sCardNumber => _bCardNumber.stream;
  Stream<String> get sCardHolder => _bCardHolder.stream;
  Stream<String> get sCardExpiry => _bCardExpiry.stream;
  Stream<String> get sCardSecureCode => _bCardSecureCode.stream;

  dispose() {
    _bCardNumber.close();
    _bCardHolder.close();
    _bCardExpiry.close();
    _bCardSecureCode.close();
  }
}
