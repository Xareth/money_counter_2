import 'package:bloc/bloc.dart';
import 'package:money_counter_2/features/money/data/money_data.dart';
part 'money_state.dart';

class MoneyCubit extends Cubit<MoneyState> {
  MoneyCubit() : super(MoneyState(moneyCounter: moneyData));

  void increment(int newValue, int position) {
    final newState = state.moneyCounter;
    newState[position][2] = state.moneyCounter[position][2] + newValue;
    newState[position][3] =
        (state.moneyCounter[position][2]) * state.moneyCounter[position][1];
    emit(MoneyState(moneyCounter: newState));
  }

  void decrement(int newValue, int position) {
    final newState = state.moneyCounter;
    newState[position][2] = state.moneyCounter[position][2] - newValue;
    newState[position][3] =
        (state.moneyCounter[position][2]) * state.moneyCounter[position][1];
    emit(MoneyState(moneyCounter: newState));
  }

  void reset() {
    emit(MoneyState(moneyCounter: moneyData));
  }
}
