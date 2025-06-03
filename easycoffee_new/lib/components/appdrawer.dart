import 'package:flutter/material.dart';
import '../themes/colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigate(BuildContext context, String route) {
    Navigator.pop(context);
    if (ModalRoute.of(context)?.settings.name != route) {
      Navigator.pushReplacementNamed(context, route);
    }
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Çıkış'),
          content: const Text('Çıkmak istediğinize emin misiniz?'),
          actions: [
            TextButton(
              child: const Text('İptal'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Evet'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Çıkış yapıldı')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
      width: 250,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [

          ListTile(
            leading: const Icon(Icons.menu_book, color: Colors.white),
            title: const Text("Menü", style: TextStyle(color: Colors.white)),
            onTap: () => _navigate(context, '/menupage'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.white),
            title: const Text("Sepetim", style: TextStyle(color: Colors.white)),
            onTap: () => _navigate(context, '/cartpage'),
          ),
          const Divider(color: Colors.white),
          ListTile(
            leading: Icon(Icons.person, color: Colors.white),
            title: Text("Profil", style: TextStyle(color: Colors.white)),
            onTap: () => _navigate(context, '/profilepage'),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.white),
            title: const Text("Çıkış Yap", style: TextStyle(color: Colors.white)),
            onTap: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
