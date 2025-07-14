import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:search_appp/core/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            final newLocale = context.locale == const Locale('ar')
                ? const Locale('en')
                : const Locale('ar');
            context.setLocale(newLocale);
          }, child: Text('language'.tr(),style: TextStyle(color: Colors.white),),)
        ],
        automaticallyImplyLeading: false,
        title: Text('home_title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildActionItem(
              context,
              icon: Icons.search,
              title: 'search'.tr(),
              subtitle: 'search_subtitle'.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.search);
              },
            ),
            const SizedBox(height: 16),
            _buildActionItem(
              context,
              icon: Icons.list_alt,
              title: 'all_orders'.tr(),
              subtitle: 'all_orders_subtitle'.tr(),
              onTap: () {
                Navigator.pushNamed(context, Routes.getAllOrders);
              },
            ),
            const SizedBox(height: 16),
            _buildActionItem(
              context,
              icon: Icons.print_rounded,
              title: 'no_print_orders'.tr(),
              subtitle: 'no_print_orders_subtitle'.tr(),
              onTap: () {
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
