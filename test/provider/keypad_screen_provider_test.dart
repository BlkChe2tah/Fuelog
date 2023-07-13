import 'package:flutter_test/flutter_test.dart';
import 'package:petrol_ledger/features/keypad/domain/keypad_screen_provider.dart';
import 'package:petrol_ledger/features/keypad/views/widgets/keypad_type_selector.dart';
import 'package:petrol_ledger/core/keys.dart';

void main() {
  late KeypadScreenProvider provider;
  late int salePrice;

  setUpAll(() {
    salePrice = 1000;
  });

  setUp(() {
    provider = KeypadScreenProvider();
  });

  test('reset initial value when keypad type changed', () {
    provider.prvAmount = '100';
    provider.prvLiter = '100';
    provider.prvKeypadType = KeypadType.amount;
    provider.setKeypadType(KeypadType.liter);
    expect(provider.amount, KeypadScreenProvider.initValue);
    expect(provider.liter, KeypadScreenProvider.initValue);
    expect(provider.keypadType, KeypadType.liter);
  });

  test('reset call test', () {
    provider.prvAmount = '100';
    provider.prvLiter = '100';
    provider.reset();
    expect(provider.amount, KeypadScreenProvider.initValue);
    expect(provider.liter, KeypadScreenProvider.initValue);
  });

  // value calculation
  // amount = (liter * sale price) and then ceil
  // liter = (amount / sale price) and then 3 place
  group('on value test', () {
    test('on amount 1000', () {
      // arrange
      provider.prvAmount = '0';
      provider.prvLiter = '0';
      provider.amountController.prvValue = '0';
      provider.literController.prvValue = '0';
      provider.prvKeypadType = KeypadType.amount;
      // act
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '1');
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '0');
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '0');
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '0');
      // assert
      expect(provider.amount, '1000');
      expect(provider.liter, '1.000');
    });
    test('on liter 1.5', () {
      // arrange
      provider.prvAmount = '0';
      provider.prvLiter = '0';
      provider.amountController.prvValue = '0';
      provider.literController.prvValue = '0';
      provider.prvKeypadType = KeypadType.liter;
      // act
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '1');
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '.');
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '5');
      // assert
      expect(provider.amount, '1500');
      expect(provider.liter, '1.5');
    });
  });

  group('on Keypad press', () {
    test('emit delete with value 0', () {
      // arrange
      provider.prvAmount = '0';
      provider.prvLiter = '0';
      provider.amountController.prvValue = '0';
      provider.literController.prvValue = '0';
      // act
      provider.emit(salePrice: salePrice, key: Keys.delete);
      // assert
      expect(provider.amount, '0');
      expect(provider.liter, '0');
    });
    test('emit 0', () {
      // arrange
      provider.prvAmount = '0';
      provider.prvLiter = '0';
      provider.amountController.prvValue = '0';
      provider.literController.prvValue = '0';
      // act
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '0');
      // assert
      expect(provider.amount, '0');
      expect(provider.liter, '0');
    });
    test('emit 00', () {
      // arrange
      provider.prvAmount = '0';
      provider.prvLiter = '0';
      provider.amountController.prvValue = '0';
      provider.literController.prvValue = '0';
      // act
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '00');
      // assert
      expect(provider.amount, '0');
      expect(provider.liter, '0');
    });
    test('emit .', () {
      // arrange
      provider.prvAmount = '0';
      provider.prvLiter = '0';
      provider.amountController.prvValue = '0';
      provider.literController.prvValue = '0';
      provider.prvKeypadType = KeypadType.liter;
      // act
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '00');
      // assert
      expect(provider.amount, '0');
      expect(provider.liter, '0');
    });
    test('emit delete', () {
      provider.prvAmount = "100";
      provider.amountController.prvValue = '100';
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.amount, '10');
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.amount, '1');
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.amount, '0');
    });
    test('emit delete with dot', () {
      provider.prvLiter = "10.0";
      provider.literController.prvValue = '10.0';
      provider.prvKeypadType = KeypadType.liter;
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.liter, '10.');
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.liter, '10');
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.liter, '1');
      // emit delete
      provider.emit(salePrice: salePrice, key: Keys.delete);
      expect(provider.liter, '0');
    });
    test('emit 1,2,3,4,5,6,7,8,9,0', () {
      provider.prvAmount = '0';
      provider.amountController.prvValue = '0';
      provider.prvKeypadType = KeypadType.amount;
      // emit 1
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '1');
      expect(provider.amount, '1');
      // emit 2
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '2');
      expect(provider.amount, '12');
      // emit 3
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '3');
      expect(provider.amount, '123');
      // emit 4
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '4');
      expect(provider.amount, '1234');
      // emit 5
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '5');
      expect(provider.amount, '12345');
      // emit 6
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '6');
      expect(provider.amount, '123456');
      // emit 7
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '7');
      expect(provider.amount, '1234567');
      // emit 8
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '8');
      expect(provider.amount, '12345678');
      // emit 9
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '9');
      expect(provider.amount, '123456789');
      // emit 0
      provider.emit(salePrice: salePrice, key: Keys.numbers, value: '0');
      expect(provider.amount, '1234567890');
    });
  });
}
