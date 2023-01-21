import 'package:flutter/material.dart';
import 'package:flutter_scroll/constants/colors.dart';
import 'package:flutter_scroll/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridView',
      body: renderMaxExtent(),
    );
  }

  // MEMO: 한번에 다 그림
  Widget renderCount() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12.0,
      mainAxisSpacing: 12.0,
      children: numbers
          .map((number) => renderContainer(
              color: RAINBOW_COLORS[number % RAINBOW_COLORS.length],
              index: number))
          .toList(),
    );
  }

  // MEMO: 보이는 것만 그림
  Widget renderBuilder() {
    return GridView.builder(
      itemCount: 100,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12.0,
        crossAxisSpacing: 12.0,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: RAINBOW_COLORS[index % RAINBOW_COLORS.length],
          index: index,
        );
      },
    );
  }

  // MEMO: 최대 사이즈
  Widget renderMaxExtent() {
    return GridView.builder(
      itemCount: 100,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: RAINBOW_COLORS[index % RAINBOW_COLORS.length],
          index: index,
        );
      },
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
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
