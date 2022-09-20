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
        ),
        // Money Content
        body: ConstrainedBox(
            constraints: const BoxConstraints.expand(width: 800),
            child: const MoneyContent()),
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
        // Row with headers
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Expanded(flex: 2, child: Text('Nominały')),
            Expanded(flex: 6, child: Text('Akcje')),
            Expanded(flex: 2, child: Text('Wynik')),
            Expanded(flex: 1, child: Text('')),
          ],
        ),
        // Rows with each money counter
        for (var data in moneyData) ...[
          Column(
            children: <Widget>[
              MoneyContentMain(data: data),
            ],
          ),
        ],
        // Row with summary
        const MoneyContentSummaryRow()
      ],
    );
  }
}

// Rows with each money counter
class MoneyContentMain extends StatelessWidget {
  const MoneyContentMain({
    Key? key,
    required this.data,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final data;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      // color: Colors.amber,
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
            child: MoneyContentChangeActions(data: data, moneyData: moneyData),
          ),
          // Container with money results
          Flexible(
            flex: 2,
            child: MoneyContentScore(
              data: data,
            ),
          ),
          // Button to reset current score in a row
          Flexible(
            flex: 1,
            child: ElevatedButton(
              style: const ButtonStyle(),
              onPressed: () {
                context.read<MoneyCubit>().reset(data[0]);
              },
              child: const Icon(Icons.autorenew),
            ),
          )
        ],
      ),
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
      color: Colors.grey[300],
      child: Text('$label PLN'),
    );
  }
}

// Row with actions increase and decrease money counter and score Field
class MoneyContentChangeActions extends StatelessWidget {
  MoneyContentChangeActions(
      {Key? key, required this.data, required this.moneyData})
      : super(key: key);

  final moneyValues = [1, 5];
  final List<dynamic> data;
  final List<dynamic> moneyData;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
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
            // ignore: avoid_unnecessary_containers
            child: Container(
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
    // ignore: avoid_unnecessary_containers
    return Container(
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
      child: BlocBuilder<MoneyCubit, MoneyState>(
        builder: (context, state) {
          return Text(state.moneyCounter[position][2].toString());
        },
      ),
    );
  }
}

class MoneyContentScore extends StatelessWidget {
  const MoneyContentScore({Key? key, required this.data}) : super(key: key);

  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: BlocBuilder<MoneyCubit, MoneyState>(
        builder: (context, state) {
          final score = state.moneyCounter[data[0]][3].toString();
          return Text('$score PLN');
        },
      ),
    );
  }
}

class MoneyContentSummaryRow extends StatelessWidget {
  const MoneyContentSummaryRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(flex: 8, child: Container()),
        Expanded(
          flex: 2,
          // ignore: avoid_unnecessary_containers
          child: Container(
            child:
                BlocBuilder<MoneyCubit, MoneyState>(builder: (context, state) {
              return Text(state.moneySummary.toString());
            }),
          ),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
