import 'package:flutter/material.dart';
import 'package:flutter_scroll/constants/colors.dart';
import 'package:flutter_scroll/layout/main_layout.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(100, (index) => index);

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListView',
      body: ReorderableListView.builder(
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return renderContainer(
              color: RAINBOW_COLORS[numbers[index] % RAINBOW_COLORS.length],
              index: numbers[index]);
        },
        onReorder: ((oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final item = numbers.removeAt(oldIndex);
            numbers.insert(newIndex, item);
          });
        }),
      ),
    );
  }

  Widget renderDefault() {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
      children: numbers
          .map(
            (number) => renderContainer(
                color: RAINBOW_COLORS[number % RAINBOW_COLORS.length],
                index: number),
          )
          .toList(),
    );
  }

  Widget renderContainer({
    Key? key,
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      key: Key(index.toString()),
      height: height ?? 300,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
