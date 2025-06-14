import 'package:fear_and_greed/fetch_data.dart';
import 'package:fear_and_greed/gauge.dart';
import 'package:flutter/material.dart';

enum IndexType { bitcoim, eggPrices, recession, inx }

class FearGreedProgress extends StatefulWidget {
  const FearGreedProgress({super.key});

  @override
  State<FearGreedProgress> createState() => _FearGreedProgressState();
}

class _FearGreedProgressState extends State<FearGreedProgress> {
  IndexType selectedType = IndexType.bitcoim;

  late final Future<double> _bitcoimFuture;
  late final Future<double> _eggPricesFuture;
  late final Future<double> _recessionFuture;
  late final Future<double> _inxFuture;

  String _labelByIndex(IndexType type) {
    String label;
    if (type == IndexType.bitcoim) {
      label = 'Bitcoim';
    } else if (type == IndexType.eggPrices) {
      label = 'Egg prices';
    } else if (type == IndexType.recession) {
      label = 'Recession';
    } else if (type == IndexType.inx) {
      label = 'S&P';
    } else {
      throw Exception();
    }

    return label;
  }

  Future<double> _futureByIndex(IndexType type) {
    Future<double> future;
    if (type == IndexType.bitcoim) {
      future = _bitcoimFuture;
    } else if (type == IndexType.eggPrices) {
      future = _eggPricesFuture;
    } else if (type == IndexType.recession) {
      future = _recessionFuture;
    } else if (type == IndexType.inx) {
      future = _inxFuture;
    } else {
      throw Exception();
    }

    return future;
  }

  @override
  void initState() {
    _bitcoimFuture = fetchBitcoimData();
    _eggPricesFuture = fetchEggPrices();
    _recessionFuture = fetchRecession();
    _inxFuture = fetchInx();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: IndexType.values.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs:
                IndexType.values.map((indexType) {
                  return Tab(text: _labelByIndex(indexType));
                }).toList(),
          ),
          title: const Text('Feer And Greed Index'),
        ),
        body: TabBarView(
          children:
              IndexType.values.map((indexType) {
                return _item(
                  label: _labelByIndex(indexType),
                  future: _futureByIndex(indexType),
                );
              }).toList(),
        ),
      ),
    );
  }

  Widget _item({required String label, required Future<double> future}) {
    return FutureBuilder<double>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
        List<Widget> children;
        if (snapshot.hasData && snapshot.data != null) {
          final value = snapshot.data!;

          children = <Widget>[
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 40,
                  child: Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                FearGreedGauge(value: value),
              ],
            ),
          ];
        } else {
          children = const <Widget>[
            SizedBox(width: 60, height: 60, child: CircularProgressIndicator()),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        );
      },
    );
  }
}
