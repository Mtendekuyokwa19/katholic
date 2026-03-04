import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../common/providers/settings_provider.dart';
import '../../constants/strings.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.theme.colors;

    final contributors = [
      {'name': 'Vincent Chilemba', 'role': 'Liturgical Director'},
      {'name': 'Mtende Kuyokwa', 'role': 'Developer'},
      {'name': 'Tamandani Nsiku', 'role': 'Lead Coordinator'},
    ];

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _buildDonationsSection(colors),
              const SizedBox(height: 32),
              _buildContributorsSection(colors, contributors),
              const SizedBox(height: 32),
              _buildSettingsSection(colors, context),

              const SizedBox(height: 32),
              _buildShareSection(colors),
              const SizedBox(height: 32),
              _buildFooter(colors),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDonationsSection(FColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.supportUs,
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
            color: colors.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.primary.withAlpha(50)),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {},
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: colors.primary.withAlpha(30),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        FIcons.heart,
                        color: colors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.makeDonation,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colors.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Strings.donationDescription,
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(FIcons.chevronRight, color: colors.primary, size: 22),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContributorsSection(
    FColors colors,
    List<Map<String, String>> contributors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Strings.contributors,
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
          child: Column(
            children: contributors.asMap().entries.map((entry) {
              final index = entry.key;
              final contributor = entry.value;
              final isLast = index == contributors.length - 1;
              return Column(
                children: [
                  Padding(
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
                          child: Center(
                            child: Text(
                              contributor['name']!.substring(0, 1),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: colors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                contributor['name']!,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: colors.foreground,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                contributor['role']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colors.mutedForeground,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isLast)
                    Divider(
                      height: 1,
                      color: colors.border,
                      indent: 16,
                      endIndent: 16,
                    ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildShareSection(FColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: colors.secondary.withAlpha(20),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.border),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Share.share(
                'Check out this amazing Catholic app for daily readings and Way of the Cross: ${Strings.appName} - ${Strings.appSubtitle}. \n you can become a contributor too. checkout the github: https://github.com/mtendekuyokwa19/katholic ',
              ),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Strings.shareWithFriends,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: colors.foreground,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            Strings.spreadTheWord,
                            style: TextStyle(
                              fontSize: 14,
                              color: colors.mutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(FIcons.share, color: colors.primary, size: 22),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection(FColors colors, BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Strings.settings,
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
              child: Column(
                children: [
                  // Font Size
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.fontSize,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors.foreground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              Strings.small,
                              style: TextStyle(color: colors.mutedForeground),
                            ),
                            Expanded(
                              child: Slider(
                                value: settingsProvider.fontSizeFactor,
                                onChanged: (value) =>
                                    settingsProvider.setFontSizeFactor(value),
                                min: 0.8,
                                max: 1.5,
                                divisions: 7,
                                label:
                                    '${(settingsProvider.fontSizeFactor * 100).round()}%',
                              ),
                            ),
                            Text(
                              Strings.large,
                              style: TextStyle(color: colors.mutedForeground),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: colors.border,
                    indent: 16,
                    endIndent: 16,
                  ),
                  // Color Scheme
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.colorScheme,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors.foreground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<ColorSchemeType>(
                          value: settingsProvider.colorScheme,
                          onChanged: (value) {
                            if (value != null) {
                              settingsProvider.setColorScheme(value);
                            }
                          },
                          items: ColorSchemeType.values.map((scheme) {
                            return DropdownMenuItem(
                              value: scheme,
                              child: Text(
                                scheme.name[0].toUpperCase() +
                                    scheme.name.substring(1),
                              ),
                            );
                          }).toList(),
                          isExpanded: true,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: colors.border,
                    indent: 16,
                    endIndent: 16,
                  ),
                  // Brightness
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.brightness,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: colors.foreground,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => settingsProvider.setBrightness(
                                  BrightnessType.light,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      settingsProvider.brightness ==
                                          BrightnessType.light
                                      ? colors.primary
                                      : colors.secondary,
                                ),
                                child: const Text(Strings.light),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => settingsProvider.setBrightness(
                                  BrightnessType.dark,
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      settingsProvider.brightness ==
                                          BrightnessType.dark
                                      ? colors.primary
                                      : colors.secondary,
                                ),
                                child: const Text(Strings.dark),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFooter(FColors colors) {
    return Center(
      child: Column(
        children: [
          Text(
            Strings.madeWithLove,
            style: TextStyle(fontSize: 12, color: colors.mutedForeground),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(FIcons.heart, color: colors.primary, size: 14),
              const SizedBox(width: 4),
              Text(
                Strings.catholicApp,
                style: TextStyle(fontSize: 12, color: colors.mutedForeground),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
