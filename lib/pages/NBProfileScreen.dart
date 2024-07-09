import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/modelgen/ogrenci.g.dart';
import 'package:flutter_app/utils/NBColors.dart';
import 'package:flutter_app/utils/NBImages.dart';
import 'package:nb_utils/nb_utils.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class NBProfileScreen extends StatefulWidget {
  static String tag = '/NBProfileScreen';

  @override
  NBProfileScreenState createState() => NBProfileScreenState();
}

class NBProfileScreenState extends State<NBProfileScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;
  User? user;
  List<Ogrenci> ogrenci = [];

  @override
  void initState() {
    super.initState();
    init();
    fetchUser();
  }

  Future<void> init() async {
    tabController = TabController(length: 3, vsync: this);
  }

  Future<void> fetchUser() async {
    user = supabase.auth.currentUser;
    if (user == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: NestedScrollView(
        physics: const ScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 330,
              backgroundColor: white,
              title: Text('Profile', style: boldTextStyle(size: 20, color: black)),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      CircleAvatar(backgroundImage: AssetImage(NBProfileImage), radius: 50),
                      8.height,
                      Text(user!.email ?? 'No Email', style: boldTextStyle(size: 20)),
                      16.height,
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(user!.id ?? "id", style: boldTextStyle(color: NBPrimaryColor)),
                              Text(user!.phone ?? 'phone', style: boldTextStyle()),
                            ],
                          ).expand(),
                          Column(
                            children: [
                              Text(user!.createdAt ?? "createdAt", style: boldTextStyle(color: NBPrimaryColor)),
                              Text(user!.lastSignInAt ?? "lastSignIn", style: boldTextStyle()),
                            ],
                          ).onTap(() {
                          }).expand(),
                          Column(
                            children: [
                              Text(user!.role ?? 'role', style: boldTextStyle(color: NBPrimaryColor)),
                              Text(user!.updatedAt ?? 'updateAt', style: boldTextStyle()),
                            ],
                          ).onTap(
                            () {
                            },
                          ).expand(),
                        ],
                      ),
                      64.height,
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: tabController,
          children: [
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  bool _redirecting = false;
  late final TextEditingController _emailController = TextEditingController();
  late final StreamSubscription<AuthState> _authStateSubscription;

  Future<void> _signIn() async {
    try {
      setState(() {
        _isLoading = true;
      });
      await supabase.auth.signInWithOtp(
        email: _emailController.text.trim(),
        emailRedirectTo:
            kIsWeb ? null : 'io.supabase.flutterquickstart://login-callback/',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Check your email for a login link!')),
        );
        _emailController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Unexpected error occurred'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      if (_redirecting) return;
      final session = data.session;
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacementNamed('/account');
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        children: [
          const Text('Sign in via the magic link with your email below'),
          const SizedBox(height: 18),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          const SizedBox(height: 18),
          ElevatedButton(
            onPressed: _isLoading ? null : _signIn,
            child: Text(_isLoading ? 'Loading' : 'Send Magic Link'),
          ),
        ],
      ),
    );
  }
}
