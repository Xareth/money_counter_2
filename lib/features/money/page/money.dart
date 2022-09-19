import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_counter_2/features/money/cubit/money_cubit.dart';

class Money extends StatefulWidget {
  const Money({Key? key}) : super(key: key);

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  @override
  Widget build(BuildContext context) {
    // MoneyCubit Provider
    return Scaffold(
      body: BlocProvider<MoneyCubit>(
        create: (context) => MoneyCubit(),
        // Money Content
        child: const MoneyContent(),
      ),
    );
  }
}

class MoneyContent extends StatelessWidget {
  const MoneyContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Rows with each money counter
        Container(
          color: Colors.amber,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              // Label with money Value
              const MoneyContentLabel(),
              // Row with actions increase and decrease money counter
              MoneyContentButtons(),
              // Field shows current money counter
              const MoneyContentResultField(),
            ],
          ),
        )
      ],
    );
  }
}

// Label with money Value
class MoneyContentLabel extends StatelessWidget {
  const MoneyContentLabel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      color: Colors.grey,
      child: const Text('50 PLN'),
    );
  }
}

// Row with actions increase and decrease money counter
class MoneyContentButtons extends StatelessWidget {
  MoneyContentButtons({Key? key}) : super(key: key);

  final moneyValues = [1, 5, 10];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Decrease money counter buttons
            for (final moneyValue in moneyValues.reversed) ...[
              MoneyContentButtonsDecreaseButtons(moneyValue: moneyValue),
            ],
            // Sized Box that work as margin
            Container(
              color: Colors.brown,
              child: const SizedBox(
                width: 10,
              ),
            ),
            // TextField to manually provide money Value
            const MoneyContentButtonsTextField(),
            // Sized Box that work as margin
            const SizedBox(
              width: 10,
            ),
            // Increase money counter buttons
            for (final moneyValue in moneyValues) ...[
              MoneyContentButtonsIncreaseButtons(moneyValue: moneyValue),
            ],
          ],
        ),
      ),
    );
  }
}

// TextField to manually provide money Value
class MoneyContentButtonsTextField extends StatelessWidget {
  const MoneyContentButtonsTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Flexible(
      child: TextField(
        maxLength: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: '0',
          counterText: '',
        ),
      ),
    );
  }
}

// Increase money counter buttons
class MoneyContentButtonsIncreaseButtons extends StatelessWidget {
  const MoneyContentButtonsIncreaseButtons({
    Key? key,
    required this.moneyValue,
  }) : super(key: key);

  final int moneyValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: FloatingActionButton(
          onPressed: () {
            context.read<MoneyCubit>().increment(moneyValue);
          },
          backgroundColor: Colors.red,
          child: Text((moneyValue).toString())),
    );
  }
}

// Decrease money counter buttons
class MoneyContentButtonsDecreaseButtons extends StatelessWidget {
  const MoneyContentButtonsDecreaseButtons({
    Key? key,
    required this.moneyValue,
  }) : super(key: key);

  final int moneyValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: FloatingActionButton(
          onPressed: () {
            context.read<MoneyCubit>().decrement(moneyValue);
          },
          backgroundColor: Colors.red,
          child: Text((moneyValue * -1).toString())),
    );
  }
}

// Field shows current money counter
class MoneyContentResultField extends StatelessWidget {
  const MoneyContentResultField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoneyCubit, int>(
      builder: (context, state) {
        return Container(
            padding: const EdgeInsets.all(25),
            color: Colors.grey[500],
            child: Text(state.toString()));
      },
    );
  }
}
