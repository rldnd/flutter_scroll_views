import 'package:flutter/material.dart';
import 'package:flutter_scroll/constants/colors.dart';
import 'package:flutter_scroll/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListView',
      body: renderSeparated(),
    );
  }

  Widget renderDefault() {
    return ListView(
        children: numbers
            .map((number) => renderContainer(
                color: RAINBOW_COLORS[number % RAINBOW_COLORS.length],
                index: number))
            .toList());
  }

  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: RAINBOW_COLORS[index % RAINBOW_COLORS.length],
          index: index,
        );
      },
    );
  }

  Widget renderSeparated() {
    return ListView.separated(
      itemCount: 100,
      separatorBuilder: (context, index) {
        index += 1;
        // 5개의 아이템마다 배너 보여주기
        if (index % 5 == 0) {
          return renderContainer(
            color: Colors.black,
            index: index,
            height: 100.0,
          );
        }

        return Container();
      },
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
