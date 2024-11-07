
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/colors.dart';
import '../route_management/routes.dart';


class MyDrawer extends StatelessWidget {
  var userData = [];
   MyDrawer({Key? key,required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color:AppColors.primary),
            accountName: Text('${userData.isNotEmpty ? userData.first['name'] : ''}'),
            accountEmail: InkWell(
              onTap: () {
                // Get.toNamed();
              },
              child:Text('${userData.isNotEmpty ? userData.first['email'] : ''}'),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage('${userData.isNotEmpty ? userData.first['photoUrl']:'https://image.civitai.com/xG1nkqKTMzGDvpLrqFT7WA/b4f0011d-ebed-45ed-3dc8-b5f8431f4700/width=450/00930-3521799169.jpeg'}'

              ),
            ),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/account_icons/delivery_icon.svg'),
            title: const Text('Address'),
            onTap: () {
            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/account_icons/notification_icon.svg'),
            title: const Text('Notification'),
            onTap: () {

            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/account_icons/about_icon.svg'),
            title: const Text('About Us'),
            onTap: () {

            },
          ),
          ListTile(
            leading: SvgPicture.asset('assets/images/account_icons/help_icon.svg'),
            title: const Text('Contact Us'),
            onTap: () {

            },
          ),
          const Divider(),
          ListTile(
            leading: SvgPicture.asset('assets/images/account_icons/promo_icon.svg'),
            title: const Text('Privacy Policy'),
            onTap: () {

            },
          ),

          ListTile(
            leading: SvgPicture.asset('assets/images/account_icons/help_icon.svg'),
            title: const Text('FAQs'),
            onTap: () async {

            },
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined,),
            title: const Text('Logout'),
            onTap: () async {
              logout();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Follow us on'),
                Row(
                  children: [
                    IconButton(
                      icon: Image.network(
                        'https://logowik.com/content/uploads/images/facebook-round-black-icon4588.logowik.com.webp',
                        height: 35,
                        width: 35,
                      ),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Image.network(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTokAJBQ3G-hzXhwhAv4R2OeGFwSOTCVfQeqw&s',
                        height: 30,
                        width: 30,
                      ),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Image.network(
                        'https://img.freepik.com/premium-vector/new-twitter-vs-xcom-novation-elon-mask-popular-social-media-button-icon-instant-messenger-logo-twitter-editorial-vector_661108-8665.jpg',
                        height: 30,
                        width: 30,
                      ),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Terms and Conditions'),
            trailing: const Text('V 1.0.0'),
            onTap: () {

            },
          ),
        ],
      ),
    );
  }
  Future<void> logout() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();

      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.clear();
      Get.snackbar('Success', 'Logout Successfully');

      Get.offAllNamed(loginScreen);
    } catch (e) {
      Get.snackbar('Error', 'Logout Failed. Please try again.');
      print('Logout error: $e');
    }
  }

}
