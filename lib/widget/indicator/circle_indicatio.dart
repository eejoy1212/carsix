import 'package:flutter/material.dart';

class CircleIndicator extends Decoration {
  final Color color;

  CircleIndicator({required this.color});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;

  _CirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Paint paint = Paint()
      ..color = color
      ..isAntiAlias = true;

    final Offset circleOffset = Offset(
      offset.dx + configuration.size!.width / 2, // 탭 중앙 X 좌표
      configuration.size!.height - 4, // 탭 하단에서 조금 위로
    );

    // 4x4 원 그리기
    canvas.drawCircle(circleOffset, 4, paint);
  }
}
