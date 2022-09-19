import 'package:bloc/bloc.dart';
part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(MoneyState(moneyCounter: [0]));

  void increment(int newValue) {
    final newState = state.moneyCounter;
    newState[0] = state.moneyCounter[0] + newValue;
    emit(MoneyState(moneyCounter: newState));
  }

  void decrement(int newValue) {
    final newState = state.moneyCounter;
    newState[0] = state.moneyCounter[0] - newValue;
    emit(MoneyState(moneyCounter: newState));
  }
}
