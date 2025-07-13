import 'package:flutter/material.dart';
import 'package:search_appp/core/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('الصفحة الرئيسية'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildActionItem(
              context,
              icon: Icons.search,
              title: 'بحث',
              subtitle: 'البحث عن طلب',
              onTap: () {
                // Navigate to search screen or show dialog
                Navigator.pushNamed(context, Routes.search);
              },
            ),
            const SizedBox(height: 16),
            _buildActionItem(
              context,
              icon: Icons.list_alt,
              title: 'عرض جميع الطلبات',
              subtitle: 'استرجاع كل الطلبات',
              onTap: () {
                // Fetch all orders
                Navigator.pushNamed(context, Routes.getAllOrders);
              },
            ),
            const SizedBox(height: 16),
            _buildActionItem(
              context,
              icon: Icons.print_rounded,
              title: 'عرض الطلبات غير المطبوعة',
              subtitle: 'استرجاع الطلبات التي لم تُطبع',
              onTap: () {
                // Fetch not printed orders
                Navigator.pushNamed(context, Routes.getAllNoPrintOrderScreen);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
