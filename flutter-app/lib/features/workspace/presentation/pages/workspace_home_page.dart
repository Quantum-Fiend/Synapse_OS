import 'package:flutter/material.dart';
import 'package:synapseos_flutter/core/theme/synapse_design.dart';
import 'package:synapseos_flutter/features/chat/presentation/pages/chat_page.dart';
import 'package:synapseos_flutter/features/whiteboard/presentation/pages/whiteboard_page.dart';
import 'package:synapseos_flutter/features/tasks/presentation/pages/kanban_page.dart';

class WorkspaceHomePage extends StatelessWidget {
  const WorkspaceHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SynapseColors.background,
      appBar: AppBar(
        title: const Text('SynapseOS', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1.2)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          const CircleAvatar(
            radius: 16,
            backgroundColor: SynapseColors.secondary,
            child: Icon(Icons.person, size: 20, color: Colors.white),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Color(0xFF16161D)],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildSectionTitle('Digital Workspace'),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                children: [
                  _buildToolCard(
                    context,
                    'Messages',
                    Icons.forum_outlined,
                    Colors.blueAccent,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChatPage())),
                  ),
                  _buildToolCard(
                    context,
                    'Creative Canvas',
                    Icons.brush_rounded,
                    Colors.pinkAccent,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WhiteboardPage())),
                  ),
                  _buildToolCard(
                    context,
                    'Strategy Board',
                    Icons.view_kanban_outlined,
                    Colors.orangeAccent,
                    () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KanbanPage())),
                  ),
                  _buildToolCard(
                    context,
                    'Knowledge Base',
                    Icons.article_outlined,
                    Colors.tealAccent,
                    () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildSectionTitle('Active Collaborators'),
              const SizedBox(height: 16),
              _buildPresenceList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning,',
          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
        ),
        const Text(
          'Alexander',
          style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: const TextStyle(
        color: SynapseColors.secondary,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        fontSize: 12,
      ),
    );
  }

  Widget _buildToolCard(BuildContext context, String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPresenceList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(5, (index) => _buildPresenceItem(index)),
      ),
    );
  }

  Widget _buildPresenceItem(int index) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: SynapseColors.glass,
                child: Icon(Icons.person_outline, color: Colors.white.withOpacity(0.3)),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    shape: BoxShape.circle,
                    border: Border.all(color: SynapseColors.background, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('User $index', style: const TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }
}
