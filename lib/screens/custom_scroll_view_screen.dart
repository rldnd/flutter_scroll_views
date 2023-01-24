import 'package:flutter/material.dart';
import 'package:flutter_scroll/constants/colors.dart';

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  // MEMO: 최대 높이
  double get maxExtent => maxHeight;

  @override
  // MEMO: 최소 높이
  double get minExtent => minHeight;

  @override
  // MEMO: covariant => 상속된 클래스도 사용 가능 ( SliverPersistentHeaderDelegate를 상속한 클래스도 될 수 있다 )
  // MEMO: oldDelegate => build가 실행이 됐을 때 이전 Delegate
  // MEMO: this => 새로운 delegate
  // MEMO: shouldRebuild => 새로 build를 해야 할지 말지 결정 ( true: 빌드 다시 함 )
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(100, (index) => index);

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppbar(),
          renderHeader(),
          renderSliverGridBuilder(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderSliverGridBuilder(),
        ],
      ),
    );
  }

  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              '신기하지?',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        maxHeight: 200,
        minHeight: 50,
      ),
    );
  }

  // MEMO: AppBar
  SliverAppBar renderSliverAppbar() {
    return const SliverAppBar(
      // MEMO: 스크롤 했을 때 리스트의 중간에도 AppBar가 내려오게 할 수 있음
      floating: true,
      // MEMO: fixed
      // pinned: true,
      // MEMO: 자석 효과 ( floating이 true인 경우에만 )
      snap: true,
      stretch: true,
      expandedHeight: 200,
      collapsedHeight: 150,
      flexibleSpace: FlexibleSpaceBar(
        background: Text('1'),
      ),
      title: Text('CustomScrollViewScreen'),
    );
  }

  // MEMO: GridView.builder 와 유사함
  SliverGrid renderSliverGridBuilder() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: RAINBOW_COLORS[index % RAINBOW_COLORS.length],
            index: index,
          );
        },
        childCount: 100,
      ),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150.0,
      ),
    );
  }

  // MEMO: GridView.count 와 유사함
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (number) => renderContainer(
                color: RAINBOW_COLORS[number % RAINBOW_COLORS.length],
                index: number,
              ),
            )
            .toList(),
      ),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }

  // MEMO: ListView.builder 생성자와 유사함
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        childCount: 100,
        (context, index) {
          return renderContainer(
            color: RAINBOW_COLORS[index % RAINBOW_COLORS.length],
            index: index,
          );
        },
      ),
    );
  }

  // MEMO: ListView 기본 생성자와 유사함
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (number) => renderContainer(
                color: RAINBOW_COLORS[number % RAINBOW_COLORS.length],
                index: number,
              ),
            )
            .toList(),
      ),
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
