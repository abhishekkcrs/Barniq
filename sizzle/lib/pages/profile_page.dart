import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizzle/providers/auth_provider.dart';
import 'package:sizzle/routes.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: authState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                // Profile Header
                SliverAppBar(
                  expandedHeight: 200,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: authState.user?.photoUrl !=
                                          null
                                      ? NetworkImage(authState.user!.photoUrl!)
                                      : null,
                                  child: authState.user?.photoUrl == null
                                      ? const Icon(Icons.person, size: 40)
                                      : null,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  authState.user?.name ?? 'Guest User',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  authState.user?.email ?? 'Not logged in',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Profile Content
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Stats Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                context,
                                'Orders',
                                '0',
                                Icons.shopping_bag,
                              ),
                              _buildStatItem(
                                context,
                                'Wishlist',
                                '0',
                                Icons.favorite,
                              ),
                              _buildStatItem(
                                context,
                                'Addresses',
                                '0',
                                Icons.location_on,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Settings Section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              _buildSettingItem(
                                context,
                                'My Orders',
                                Icons.shopping_bag,
                                () {},
                              ),
                              const SizedBox(height: 16),
                              _buildSettingItem(
                                context,
                                'My Addresses',
                                Icons.location_on,
                                () {},
                              ),
                              const SizedBox(height: 16),
                              _buildSettingItem(
                                context,
                                'Payment Methods',
                                Icons.payment,
                                () {},
                              ),
                              const SizedBox(height: 16),
                              _buildSettingItem(
                                context,
                                'Notifications',
                                Icons.notifications,
                                () {},
                              ),
                              const SizedBox(height: 16),
                              _buildSettingItem(
                                context,
                                'About',
                                Icons.info_outline,
                                () {},
                              ),
                              const SizedBox(height: 24),
                              if (authState.user != null)
                                Center(
                                  child: ElevatedButton.icon(
                                    onPressed: () async {
                                      try {
                                        await ref
                                            .read(authProvider.notifier)
                                            .signOut();
                                        if (context.mounted) {
                                          Navigator.of(context)
                                              .pushNamedAndRemoveUntil(
                                                  AppRoutes.login,
                                                  (Route<dynamic> route) =>
                                                      false);
                                        }
                                      } catch (e) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Error signing out: $e')),
                                          );
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Colors.red.withOpacity(0.1),
                                      foregroundColor: Colors.red,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 32,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: const BorderSide(
                                            color: Colors.red, width: 1),
                                      ),
                                      elevation: 2,
                                    ),
                                    icon: const Icon(Icons.logout, size: 20),
                                    label: const Text(
                                      'Sign Out',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Icon(
              icon,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.chevron_right,
            color: Theme.of(context).textTheme.bodyMedium?.color,
          ),
        ],
      ),
    );
  }
}

class ProfileBackgroundPainter extends CustomPainter {
  final Color color;

  ProfileBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final path = Path();
    const spacing = 20.0;

    for (var i = 0.0; i < size.width; i += spacing) {
      path.moveTo(i, 0);
      path.lineTo(i, size.height);
    }

    for (var i = 0.0; i < size.height; i += spacing) {
      path.moveTo(0, i);
      path.lineTo(size.width, i);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(ProfileBackgroundPainter oldDelegate) =>
      color != oldDelegate.color;
}
