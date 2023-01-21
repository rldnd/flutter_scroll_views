import 'package:flutter/material.dart';
import 'package:flutter_scroll/constants/colors.dart';
import 'package:flutter_scroll/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPerformance(),
    );
  }

  // MEMO: 기본 렌더링 방법
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: RAINBOW_COLORS
            .map((color) => renderContainer(color: color))
            .toList(),
      ),
    );
  }

  // MEMO: 화면을 넘어가지 않아도 스크롤 되기 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      // NeverScrollableScrollPhysics
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  // MEMO: 위젯이 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [renderContainer(color: Colors.black)],
      ),
    );
  }

  // MEMO: 여러가지 physics 정리
  Widget renderPhysics() {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: RAINBOW_COLORS
            .map((color) => renderContainer(color: color))
            .toList(),
      ),
    );
  }

  // MEMO: SingleChildScrollView 퍼포먼스
  Widget renderPerformance() {
    return SingleChildScrollView(
      child: Column(
        children: numbers
            .map((number) => renderContainer(
                  color: RAINBOW_COLORS[number % RAINBOW_COLORS.length],
                  index: number,
                ))
            .toList(),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) {
      print(index);
    }
    return Container(height: 300, color: color);
  }
}
