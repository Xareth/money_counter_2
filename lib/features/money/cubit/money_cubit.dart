import 'package:bloc/bloc.dart';
import 'package:money_counter_2/features/money/data/money_data.dart';
part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit()
      : super(MoneyState(moneyCounter: moneyData, moneySummary: moneySummary));

  // Action to increase current state
  void increment(int newValue, int position) {
    final newState = state.moneyCounter;
    newState[position][2] = state.moneyCounter[position][2] + newValue;
    newState[position][3] =
        (state.moneyCounter[position][2]) * state.moneyCounter[position][1];

    var newSum = moneySum();
    emit(MoneyState(moneyCounter: newState, moneySummary: newSum));
  }

  // Action to decrease current state
  void decrement(int newValue, int position) {
    final newState = state.moneyCounter;
    newState[position][2] = state.moneyCounter[position][2] - newValue;
    newState[position][3] =
        (state.moneyCounter[position][2]) * state.moneyCounter[position][1];
    var newSum = moneySum();
    emit(MoneyState(moneyCounter: newState, moneySummary: newSum));
  }

  // Action to reset particular row
  void reset(int position) {
    final newState = state.moneyCounter;
    newState[position][2] = 0;
    newState[position][3] = 0;
    var newSum = moneySum();
    emit(MoneyState(moneyCounter: newState, moneySummary: newSum));
  }

  // Sum all money counted
  int moneySum() {
    int moneySum = 0;
    for (var data in moneyData) {
      moneySum = data[3] + moneySum;
    }
    return moneySum;
  }
}
