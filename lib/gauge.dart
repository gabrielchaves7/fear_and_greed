import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class FearGreedGauge extends StatelessWidget {
  final double value;

  const FearGreedGauge({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          minimum: 0,
          maximum: 100,
          startAngle: 180,
          endAngle: 0,
          showTicks: false,
          showLabels: false,
          radiusFactor: 0.9,
          canScaleToFit: true,
          axisLineStyle: const AxisLineStyle(
            thickness: 0.15,
            thicknessUnit: GaugeSizeUnit.factor,
          ),
          ranges: <GaugeRange>[
            GaugeRange(
              startValue: 0,
              endValue: 20,
              color: Colors.red,
              label: 'EXTREME\nFEAR',
              labelStyle: const GaugeTextStyle(fontSize: 10),
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: 20,
              endValue: 40,
              color: Colors.red.shade100,
              label: 'FEAR',
              labelStyle: const GaugeTextStyle(fontSize: 10),
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: 40,
              endValue: 60,
              color: Colors.grey.shade200,
              label: 'NEUTRAL',
              labelStyle: const GaugeTextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: 60,
              endValue: 80,
              color: Colors.green.shade100,
              label: 'GREED',
              labelStyle: const GaugeTextStyle(fontSize: 10),
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
            GaugeRange(
              startValue: 80,
              endValue: 100,
              color: Colors.green,
              label: 'EXTREME\nGREED',
              labelStyle: const GaugeTextStyle(fontSize: 10),
              startWidth: 0.15,
              endWidth: 0.15,
              sizeUnit: GaugeSizeUnit.factor,
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: value,
              needleLength: 0.8,
              lengthUnit: GaugeSizeUnit.factor,
              needleColor: Colors.black,
              needleEndWidth: 4,
              knobStyle: const KnobStyle(
                knobRadius: 0,
                sizeUnit: GaugeSizeUnit.factor,
                color: Colors.white,
                borderColor: Colors.blue,
                borderWidth: 2,
              ),
            ),
          ],
          annotations: <GaugeAnnotation>[
            GaugeAnnotation(
              widget: Text(
                value.toInt().toString(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              angle: 90,
              positionFactor: 0.1,
            ),
          ],
        ),
      ],
    );
  }
}
