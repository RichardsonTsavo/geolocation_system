export 'double_to_formatting_to_money_string.dart';

String doubleToFormattingToMoneyString(double value) {
  return "R\$ ${value.toStringAsFixed(2).replaceAll('.', ',').replaceAll('-', '')}";
}
