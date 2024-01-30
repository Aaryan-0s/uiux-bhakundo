import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nba_hub/features/profile/presentation/view/profile_menu.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../viewmodel/profile_view_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileInfoViewModelProvider.notifier).getProfile();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final internetStatus = ref.watch(connectivityStatusProvider);
    var profile = ref.watch(profileInfoViewModelProvider);

    if (profile.profile.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: ClipOval(
                          child: internetStatus ==
                                  ConnectivityStatus.isConnected
                              ? Image.network(
                                  'http://10.0.2.2:3001/uploads/${profile.profile[0].image}',
                                  // "http://192.168.137.1:3001/uploads/${profile.profile[0].image}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/barsa.png',
                                      width: 50.0,
                                      height: 50.0,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                              : Image.asset(
                                  'assets/images/barsa.png',
                                  width: 50.0,
                                  height: 50.0,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        child: Text(
                          profile.profile[0].fname,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Text(
                        profile.profile[0].lname,
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                  title: "Settings",
                  icon: Icons.settings,
                  onPress: () {
                    Navigator.pushNamed(context, AppRoute.updateProfile,
                        arguments: profile.profile[0]);
                  },
                ),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                  title: "Logout",
                  icon: Icons.logout,
                  textColor: const Color.fromARGB(255, 12, 9, 9),
                  endIcon: false,
                  onPress: () {
                    ref
                        .watch(profileViewModelProvider.notifier)
                        .logout(context);
                  },
                ),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                  title: "Contact us",
                  icon: Icons.contact_mail,
                  textColor: const Color.fromARGB(255, 12, 9, 9),
                  endIcon: false,
                  onPress: () {
                     Navigator.pushNamed(context, AppRoute.contact,
                       );

                    
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
