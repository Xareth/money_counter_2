import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_counter_2/features/money/cubit/money_cubit.dart';
import 'package:money_counter_2/features/money/data/money_data.dart';

class Money extends StatefulWidget {
  const Money({Key? key}) : super(key: key);

  @override
  State<Money> createState() => _MoneyState();
}

class _MoneyState extends State<Money> {
  @override
  Widget build(BuildContext context) {
    // MoneyCubit Provider
    return BlocProvider<MoneyCubit>(
      create: (context) => MoneyCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Licznik nominałów'),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  context.read<MoneyCubit>().reset();
                },
                icon: const Icon(Icons.clear_all_rounded)),
          ],
        ),
        // Money Content
        body: const MoneyContent(),
      ),
    );
  }
}

// Money Content
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
        for (var data in moneyData) ...[
          Container(
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Label with money Value
                Flexible(
                    flex: 2,
                    child: MoneyContentLabel(
                      label: data[1],
                    )),
                // Row with actions increase and decrease money counter and score Field
                Flexible(
                  flex: 6,
                  child: MoneyContentChangeActions(
                      data: data, moneyData: moneyData),
                ),
                // Container with money results
                Flexible(
                    flex: 2,
                    child: MoneyContentScore(
                      data: data,
                    ))
              ],
            ),
          )
        ],
      ],
    );
  }
}

// Label with money Value
class MoneyContentLabel extends StatelessWidget {
  const MoneyContentLabel({Key? key, required this.label}) : super(key: key);

  final int label;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(25),
      color: Colors.grey,
      child: Text('$label PLN'),
    );
  }
}

// Row with actions increase and decrease money counter and score Field
class MoneyContentChangeActions extends StatelessWidget {
  MoneyContentChangeActions(
      {Key? key, required this.data, required this.moneyData})
      : super(key: key);

  final moneyValues = [1, 5, 10];
  final List<dynamic> data;
  final List<dynamic> moneyData;

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
                moneyValues: moneyValues, isIncrement: false, data: data),
          ),
          // Field shows current money counter
          Flexible(
              flex: 1,
              child: MoneyContentResultField(
                position: data[0],
              )),

          // Increase money counter buttons
          Flexible(
            flex: 3,
            child: MoneyContentChangeActionsChangeButtons(
              moneyValues: moneyValues,
              isIncrement: true,
              data: data,
            ),
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
    required this.data,
  }) : super(key: key);

  final List<int> moneyValues;
  final bool isIncrement;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (final moneyValue
            in isIncrement ? moneyValues : moneyValues.reversed) ...[
          Flexible(
            child: Container(
              color: Colors.red,
              child: FloatingActionButton(
                  onPressed: () {
                    isIncrement
                        ? context
                            .read<MoneyCubit>()
                            .increment(moneyValue, data[0])
                        : context
                            .read<MoneyCubit>()
                            .decrement(moneyValue, data[0]);
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
  const MoneyContentResultField({Key? key, required this.position})
      : super(key: key);

  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey[300],
      child: BlocBuilder<MoneyCubit, MoneyState>(
        builder: (context, state) {
          return Text(state.moneyCounter[position][2].toString());
        },
      ),
    );
  }
}

// Container with money results
class MoneyContentScore extends StatelessWidget {
  const MoneyContentScore({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.red,
      child: BlocBuilder<MoneyCubit, MoneyState>(
        builder: (context, state) {
          final score = state.moneyCounter[data[0]][3].toString();
          return Text('$score PLN');
        },
      ),
    );
  }
}
