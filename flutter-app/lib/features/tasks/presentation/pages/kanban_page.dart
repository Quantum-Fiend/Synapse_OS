import 'package:flutter/material.dart';
import 'package:synapseos_flutter/core/theme/synapse_design.dart';

class KanbanPage extends StatelessWidget {
  const KanbanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SynapseColors.background,
      appBar: AppBar(
        title: const Text('Project Strategy'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildColumn('Pending', [
              _buildTaskCard('Integrate Akka Streams', 'High priority sync task'),
              _buildTaskCard('Optimize Flutter Canvas', 'Improve whiteboard FPS'),
            ]),
            _buildColumn('Active', [
              _buildTaskCard('Production UI Audit', 'Applying visual excellence phase'),
            ]),
            _buildColumn('Completed', [
              _buildTaskCard('JWT Auth Skeleton', 'Backend auth implemented'),
              _buildTaskCard('Sync Engine Core', 'WebSocket broadcasting active'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildColumn(String title, List<Widget> tasks) {
    return Container(
      width: 300,
      margin: const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(color: SynapseColors.secondary, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add, color: Colors.grey, size: 20)),
            ],
          ),
          const SizedBox(height: 12),
          ...tasks,
        ],
      ),
    );
  }

  Widget _buildTaskCard(String title, String desc) {
    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(radius: 12, backgroundColor: Colors.deepPurple, child: Icon(Icons.person, size: 14)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(6)),
                child: const Text('2 days left', style: TextStyle(color: Colors.grey, fontSize: 10)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const GlassContainer({super.key, required this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: SynapseColors.glass,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: child,
    );
  }
}
