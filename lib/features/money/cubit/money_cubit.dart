import 'package:bloc/bloc.dart';

class MoneyCubit extends Cubit<int> {
  MoneyCubit() : super(0);

  void increment(int newValue) {
    final newState = state + newValue;
    emit(newState);
  }

  void decrement(int newValue) {
    final newState = state - newValue;
    emit(newState);
  }

  void newValue(int newValue) {
    final newState = newValue;
    emit(newState);
  }
}
