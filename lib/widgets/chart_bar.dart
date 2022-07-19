import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double percentOfTotal;

  const ChartBar(
      {Key? key,
      required this.label,
      required this.percentOfTotal,
      required this.spendAmount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => Column(
              children: [
                Container(
                    height: constraints.maxHeight * 0.15,
                    child: FittedBox(
                        child: Text('\$${spendAmount.toStringAsFixed(0)}'))),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  width: 10,
                  child: Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: const Color.fromRGBO(220, 220, 220, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    FractionallySizedBox(
                      heightFactor: percentOfTotal,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )
                  ]),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                Container(
                    height: constraints.maxHeight * 0.15,
                    child: FittedBox(child: Text(label)))
              ],
            ));
  }
}
