import 'package:flutter/material.dart';
import 'package:paper_recycling_shopper/common/custom_appbar.dart';
import 'package:paper_recycling_shopper/features/account/widgets/profile_menu.dart';
import 'package:paper_recycling_shopper/features/account/widgets/profile_pic.dart';
import 'package:paper_recycling_shopper/features/auth/screens/auth_screen.dart';
import 'package:paper_recycling_shopper/providers/user_provider.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('x-auth-token');
    // ignore: use_build_context_synchronously
     PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: const AuthScreen(),
        withNavBar: false, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: CustomAppBar(user: user),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const ProfilePic(),
            const SizedBox(height: 20),
            ProfileMenu(
              text: "Personal Info",
              icon: const Icon(Icons.account_circle_outlined),
              press: () => {},
            ),
            // ProfileMenu(
            //   text: "Notifications",
            //   icon: Icon(Icons.circle_notifications_outlined),
            //   press: () {},
            // ),
            ProfileMenu(
              text: "Settings",
              icon: const Icon(Icons.settings_applications_outlined),
              press: () {},
            ),
            ProfileMenu(
              text: "Help Center",
              icon: const Icon(Icons.help_center_outlined),
              press: () {},
            ),
            ProfileMenu(
              text: "Log Out",
              icon: const Icon(Icons.logout_rounded),
              press: () => logOut(),
            ),
          ],
        ),
      ),
    );
  }
}
