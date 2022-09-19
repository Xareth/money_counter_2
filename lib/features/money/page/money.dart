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
        child: MoneyContent(),
      ),
    );
  }
}

// Money Content
class MoneyContent extends StatelessWidget {
  MoneyContent({
    Key? key,
  }) : super(key: key);

  final moneyValues = [1, 5, 10];

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
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Label with money Value
              const Flexible(flex: 3, child: MoneyContentLabel()),
              // Row with actions increase and decrease money counter and score Field
              Flexible(
                  flex: 7,
                  child: MoneyContentChangeActions(moneyValues: moneyValues)),
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
      alignment: Alignment.center,
      padding: const EdgeInsets.all(25),
      color: Colors.grey,
      child: const Text('50 PLN'),
    );
  }
}

// Row with actions increase and decrease money counter and score Field
class MoneyContentChangeActions extends StatelessWidget {
  const MoneyContentChangeActions({
    Key? key,
    required this.moneyValues,
  }) : super(key: key);

  final List<int> moneyValues;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Decrease money counter buttons
          Flexible(
            flex: 3,
            child: MoneyContentChangeActionsChangeButtons(
                moneyValues: moneyValues, isIncrement: false),
          ),
          // Field shows current money counter
          const Flexible(flex: 1, child: MoneyContentResultField()),

          // Increase money counter buttons
          Flexible(
            flex: 3,
            child: MoneyContentChangeActionsChangeButtons(
                moneyValues: moneyValues, isIncrement: true),
          ),
        ],
      ),
    );
  }
}

// Change money counter buttons
class MoneyContentChangeActionsChangeButtons extends StatelessWidget {
  const MoneyContentChangeActionsChangeButtons({
    Key? key,
    required this.moneyValues,
    required this.isIncrement,
  }) : super(key: key);

  final List<int> moneyValues;
  final bool isIncrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (final moneyValue in moneyValues) ...[
          Flexible(
            child: Container(
              color: Colors.red,
              child: FloatingActionButton(
                  onPressed: () {
                    isIncrement
                        ? context.read<MoneyCubit>().increment(moneyValue)
                        : context.read<MoneyCubit>().decrement(moneyValue);
                  },
                  backgroundColor: isIncrement ? Colors.green : Colors.red,
                  child:
                      Text((moneyValue * (isIncrement ? 1 : -1)).toString())),
            ),
          )
        ],
      ],
    );
  }
}

// Sized Box that work as margin
class MoneyContentButtonsSizedBox extends StatelessWidget {
  const MoneyContentButtonsSizedBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
      child: const SizedBox(
        width: 10,
      ),
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
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey[300],
      child: BlocBuilder<MoneyCubit, int>(
        builder: (context, state) {
          return Text(state.toString());
        },
      ),
    );
  }
}
