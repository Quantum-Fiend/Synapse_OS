import 'package:flutter/material.dart';
import 'package:synapseos_flutter/core/theme/synapse_design.dart';

class WhiteboardPage extends StatefulWidget {
  const WhiteboardPage({super.key});

  @override
  State<WhiteboardPage> createState() => _WhiteboardPageState();
}

class _WhiteboardPageState extends State<WhiteboardPage> {
  List<Offset?> points = [];
  Color selectedColor = Colors.white;
  double strokeWidth = 3.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Creative Canvas'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () => setState(() => points.clear()), icon: const Icon(Icons.delete_sweep_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_rounded)),
        ],
      ),
      body: Stack(
        children: [
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                RenderBox renderBox = context.findRenderObject() as RenderBox;
                points.add(renderBox.globalToLocal(details.globalPosition));
              });
            },
            onPanEnd: (details) => points.add(null),
            child: CustomPaint(
              painter: DrawingPainter(points: points, color: selectedColor, strokeWidth: strokeWidth),
              size: Size.infinite,
            ),
          ),
          Positioned(
            left: 20,
            bottom: 40,
            right: 20,
            child: _buildToolbar(),
          ),
        ],
      ),
    );
  }

  Widget _buildToolbar() {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      borderRadius: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildColorPicker(Colors.white),
          _buildColorPicker(Colors.redAccent),
          _buildColorPicker(Colors.blueAccent),
          _buildColorPicker(Colors.greenAccent),
          _buildColorPicker(Colors.yellowAccent),
          const VerticalDivider(color: Colors.white24),
          IconButton(
            icon: Icon(Icons.line_weight_rounded, color: Colors.white.withOpacity(0.8)),
            onPressed: () => setState(() => strokeWidth = (strokeWidth % 10) + 2),
          ),
          IconButton(
            icon: Icon(Icons.undo_rounded, color: Colors.white.withOpacity(0.8)),
            onPressed: () {
              if (points.isNotEmpty) setState(() => points.removeLast());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildColorPicker(Color color) {
    return GestureDetector(
      onTap: () => setState(() => selectedColor = color),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.white : Colors.white24,
            width: selectedColor == color ? 3 : 1,
          ),
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<Offset?> points;
  final Color color;
  final double strokeWidth;

  DrawingPainter({required this.points, required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) => true;
}
