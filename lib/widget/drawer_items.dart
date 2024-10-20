import 'package:finance/constant/colors.dart';
import 'package:finance/widget/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Text(
              'Menu',
              style: GoogleFonts.lora(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Responsive(
                mobile: _buildMenuList(context, true),
                tablet: _buildMenuList(context, false),
                desktop: _buildMenuList(context, false),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuList(BuildContext context, bool isMobile) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 10),
      children: [
        _buildMenuItem(
          context,
          icon: Icons.person,
          title: 'Profile',
          onTap: () {},
        ),
        _buildMenuItem(
          context,
          icon: Icons.logout,
          title: 'Logout',
          titleColor: Colors.red,
          onTap: () {
            _showLogoutDialog(context);
          },
        ),
      ],
    );
  }

  Widget _buildMenuItem(BuildContext context,
      {required IconData icon,
      required String title,
      required VoidCallback onTap,
      Color titleColor = Colors.black}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Appcolor.primary, size: 30),
        title: Text(
          title,
          style: GoogleFonts.lora(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        onTap: onTap,
        tileColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout',
            style: GoogleFonts.lora(),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: GoogleFonts.lora(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: GoogleFonts.lora(),
              ),
            ),
            TextButton(
              onPressed: () {
                // Handle logout action
              },
              child: Text(
                'Logout',
                style: GoogleFonts.lora(),
              ),
            ),
          ],
        );
      },
    );
  }
}
