import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';

class GestationWeek extends StatelessWidget {
  const GestationWeek({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Gestation Week', style: theme.textTheme.titleMedium),
        Text(
          'Select the current week of pregnancy',
          style: theme.textTheme.bodySmall,
        ),

        _weekPicker(),
        Text('Selected: Week 20', style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _weekPicker extends StatelessWidget {
  const _weekPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPopup(
      content: SizedBox.fromSize(
        size: Size.fromHeight(size.height * 0.4),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(40, (index) {
              return ListTile(title: Text("Week ${index + 1}"));
            }),
          ),
        ),
      ),
      child: ListTile(title: Text('Week 1')),
    );
  }
}
