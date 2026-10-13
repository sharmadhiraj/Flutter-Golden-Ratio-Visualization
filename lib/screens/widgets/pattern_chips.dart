import 'package:flutter/material.dart';

class PatternChips extends StatelessWidget {
  const PatternChips({
    required this.names,
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final List<String> names;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        spacing: 8,
        children: [
          for (final (int i, String name) in names.indexed)
            Semantics(
              button: true,
              label: "Show $name pattern",
              child: ChoiceChip(
                label: Text(name),
                showCheckmark: false,
                selected: i == selected,
                onSelected: (_) => onSelected(i),
              ),
            ),
        ],
      ),
    );
  }
}
