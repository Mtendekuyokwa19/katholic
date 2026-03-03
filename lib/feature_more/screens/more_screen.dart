import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/strings.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(colors),
              const SizedBox(height: 32),
              _buildSection(
                title: 'App Settings',
                colors: colors,
                children: [
                  _SettingsTile(
                    icon: FIcons.bell,
                    title: 'Notifications',
                    subtitle: 'Daily reading reminders',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.moon,
                    title: 'Appearance',
                    subtitle: 'Dark mode, theme settings',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.globe,
                    title: 'Language',
                    subtitle: 'English, Chichewa',
                    colors: colors,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'Readings',
                colors: colors,
                children: [
                  _SettingsTile(
                    icon: FIcons.bookOpen,
                    title: 'Daily Readings',
                    subtitle: 'View all daily readings',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.calendar,
                    title: 'Liturgical Calendar',
                    subtitle: 'Full liturgical year',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.heart,
                    title: 'Favorites',
                    subtitle: 'Saved readings',
                    colors: colors,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'Prayers',
                colors: colors,
                children: [
                  _SettingsTile(
                    icon: FIcons.cross,
                    title: Strings.wayOfTheCross,
                    subtitle: '14 stations of the cross',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.sparkles,
                    title: 'Novenas',
                    subtitle: 'Special prayers',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.heart,
                    title: 'Daily Prayers',
                    subtitle: 'Morning & evening prayers',
                    colors: colors,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                title: 'About',
                colors: colors,
                children: [
                  _SettingsTile(
                    icon: FIcons.info,
                    title: 'About App',
                    subtitle: 'Version 1.0.0',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.star,
                    title: 'Rate App',
                    subtitle: 'Share your feedback',
                    colors: colors,
                    onTap: () {},
                  ),
                  _SettingsTile(
                    icon: FIcons.share,
                    title: 'Share App',
                    subtitle: 'Invite others',
                    colors: colors,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 32),
              _buildFooter(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(FColors colors) {
    return Row(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: colors.primary.withAlpha(25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(FIcons.personStanding, color: colors.primary, size: 36),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Njira ya Mtanda',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: colors.foreground,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Catholic Daily Readings',
              style: TextStyle(fontSize: 14, color: colors.mutedForeground),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required FColors colors,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: colors.mutedForeground,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: colors.secondary.withAlpha(20),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildFooter(FColors colors) {
    return Center(
      child: Column(
        children: [
          Text(
            'Made with love for the Church',
            style: TextStyle(fontSize: 12, color: colors.mutedForeground),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FIcons.heart, color: colors.primary, size: 14),
              const SizedBox(width: 4),
              Text(
                'Catholic App',
                style: TextStyle(fontSize: 12, color: colors.mutedForeground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final FColors colors;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: colors.primary.withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: colors.primary, size: 20),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colors.foreground,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 13,
                        color: colors.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                FIcons.chevronRight,
                color: colors.mutedForeground,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
