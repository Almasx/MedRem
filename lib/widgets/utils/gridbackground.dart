import 'package:flutter/material.dart';

class LinesPainter extends CustomPainter {
  LinesPainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final width = size.width - 53;

    for (int i = 0; i < 5; i++) {
      canvas.drawLine(Offset(25 + i * width / 3, 0),
          Offset(26 + i * width / 3, size.height), Paint()..color = color);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class GridBackground extends StatelessWidget {
  const GridBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List<Expanded>.generate(
        4,
        (int index) => Expanded(
          child: VerticalDivider(
            thickness: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    ]);
  }
}
