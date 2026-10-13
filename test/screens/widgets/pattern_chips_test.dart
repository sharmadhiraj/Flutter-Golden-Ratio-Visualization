import 'package:flutter/material.dart';
import 'package:flutter_golden_ratio_visualization/screens/widgets/pattern_chips.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("chip width does not change when selected", (tester) async {
    int selected = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => PatternChips(
              names: const ["One", "Two"],
              selected: selected,
              onSelected: (index) => setState(() => selected = index),
            ),
          ),
        ),
      ),
    );

    final Finder chip = find.byType(ChoiceChip);
    final double before = tester.getSize(chip.at(1)).width;
    final double firstLeft = tester.getTopLeft(chip.at(1)).dx;

    await tester.tap(find.text("Two"));
    await tester.pumpAndSettle();

    expect(tester.getSize(chip.at(1)).width, before);
    expect(tester.getTopLeft(chip.at(1)).dx, firstLeft);
  });
}
