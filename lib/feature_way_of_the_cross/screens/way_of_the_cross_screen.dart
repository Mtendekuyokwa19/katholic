import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:njirayamtanda/constants/app_images.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:njirayamtanda/feature_way_of_the_cross/models/way_of_the_cross_model.dart';
import 'package:njirayamtanda/feature_way_of_the_cross/providers/way_of_the_cross_provider.dart';
import 'package:njirayamtanda/feature_way_of_the_cross/screens/search_stations_screen.dart';
import 'package:provider/provider.dart';

class WayOfTheCrossScreen extends StatefulWidget {
  const WayOfTheCrossScreen({super.key});

  @override
  State<WayOfTheCrossScreen> createState() => _WayOfTheCrossScreenState();
}

class _WayOfTheCrossScreenState extends State<WayOfTheCrossScreen>
    with SingleTickerProviderStateMixin {
  WayOfTheCrossData? _data;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 350),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.1), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await WayOfTheCrossData.load();
    setState(() {
      _data = data;
    });
    _animationController.forward();
  }

  void _nextStation() {
    if (_data == null) return;
    final provider = Provider.of<WayOfTheCrossProvider>(context, listen: false);
    if (provider.currentStationIndex >= _data!.stations.length - 1) {
      return;
    }
    _animationController.reset();
    provider.nextStation(_data!.stations.length);
    _animationController.forward();
  }

  void _previousStation() {
    if (_data == null) return;
    final provider = Provider.of<WayOfTheCrossProvider>(context, listen: false);
    if (provider.currentStationIndex <= 0) {
      return;
    }
    _animationController.reset();
    provider.previousStation();
    _animationController.forward();
  }

  void _openSearch() {
    if (_data == null) return;
    final provider = Provider.of<WayOfTheCrossProvider>(context, listen: false);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SearchStationsScreen(
          data: _data!,
          onStationSelected: (index) {
            _animationController.reset();
            provider.setStationIndex(index);
            _animationController.forward();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WayOfTheCrossProvider>(
      builder: (context, stationProvider, child) {
        final colors = context.theme.colors;

        if (_data == null) {
          return _LoadingScreen(colors: colors);
        }

        final station = _data!.stations[stationProvider.currentStationIndex];

        return Scaffold(
          backgroundColor: colors.background,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(colors),
                            _buildFeaturedImage(
                              colors,
                              station,
                              stationProvider.currentStationIndex,
                            ),
                            _buildProgressBar(
                              colors,
                              stationProvider.currentStationIndex,
                            ),
                            const SizedBox(height: 20),
                            _buildContentSection(colors, station),
                            const SizedBox(height: 100),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                _buildBottomNavigation(
                  colors,
                  stationProvider.currentStationIndex,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(FColors colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Spacer(),
          Column(
            children: [
              Text(
                Strings.wayOfTheCross.toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: colors.primary,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'Lenten Meditation',
                style: TextStyle(fontSize: 11, color: colors.mutedForeground),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _openSearch(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: colors.primary.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(FIcons.search, color: colors.primary, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedImage(
    FColors colors,
    Station station,
    int currentIndex,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage(AppImages.crossCrusader),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black54, BlendMode.overlay),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.primary.withAlpha(40),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.transparent, colors.background.withAlpha(200)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: colors.primary.withAlpha(180),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${Strings.station} ${currentIndex + 1}',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.primaryForeground,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                station.title,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: colors.foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressBar(FColors colors, int currentIndex) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Strings.stationProgress,
                style: TextStyle(fontSize: 11, color: colors.mutedForeground),
              ),
              Text(
                '${currentIndex + 1} of ${_data!.stations.length}',
                style: TextStyle(fontSize: 11, color: colors.mutedForeground),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (currentIndex + 1) / _data!.stations.length,
              backgroundColor: colors.border,
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSection(FColors colors, Station station) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCallAndResponse(colors, station),
          const SizedBox(height: 16),
          _buildScriptureCard(colors, station),
          const SizedBox(height: 16),
          _buildMeditativePrayer(colors, station),
        ],
      ),
    );
  }

  Widget _buildCallAndResponse(FColors colors, Station station) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CALL & RESPONSE',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.primary,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 12),
          _buildCallResponseLine(
            'Pr.:',
            '${station.adoration.split('.').first}.',
            colors,
          ),
          const SizedBox(height: 8),
          _buildCallResponseLine(
            'All:',
            'Because, by Your holy cross, You have redeemed the world.',
            colors,
            isResponse: true,
          ),
        ],
      ),
    );
  }

  Widget _buildCallResponseLine(
    String prefix,
    String text,
    FColors colors, {
    bool isResponse = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          prefix,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isResponse ? colors.foreground : colors.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: colors.foreground,
              fontStyle: isResponse ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildScriptureCard(FColors colors, Station station) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.secondary.withAlpha(40),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FIcons.book, color: colors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'SCRIPTURE READING',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              station.reflection,
              style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditativePrayer(FColors colors, Station station) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colors.primary.withAlpha(15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colors.primary.withAlpha(40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(FIcons.sparkles, color: colors.primary, size: 18),
                const SizedBox(width: 8),
                Text(
                  'MEDITATIVE PRAYER',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colors.primary,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              station.prayer,
              style: TextStyle(
                fontSize: 14,
                height: 1.7,
                color: colors.foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation(FColors colors, int currentIndex) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: colors.background,
        border: Border(top: BorderSide(color: colors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildNavButton(
              icon: FIcons.chevronLeft,
              label: Strings.previous,
              isGhost: true,
              colors: colors,
              onPressed: currentIndex > 0 ? _previousStation : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildNavButton(
              icon: FIcons.chevronRight,
              label: Strings.nextStation,
              isGhost: false,
              colors: colors,
              onPressed: currentIndex < _data!.stations.length - 1
                  ? _nextStation
                  : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required IconData icon,
    required String label,
    required bool isGhost,
    required FColors colors,
    VoidCallback? onPressed,
  }) {
    final isDisabled = onPressed == null;

    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isGhost
              ? Colors.transparent
              : (isDisabled
                    ? colors.mutedForeground.withAlpha(20)
                    : colors.primary),
          borderRadius: BorderRadius.circular(12),
          border: isGhost
              ? Border.all(color: isDisabled ? colors.border : colors.primary)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDisabled
                  ? colors.mutedForeground
                  : (isGhost ? colors.primary : colors.primaryForeground),
              size: 18,
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDisabled
                    ? colors.mutedForeground
                    : (isGhost ? colors.primary : colors.primaryForeground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingScreen extends StatelessWidget {
  final FColors colors;

  const _LoadingScreen({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FIcons.cross, color: colors.primary, size: 48),
            const SizedBox(height: 24),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Loading Stations...',
              style: TextStyle(color: colors.mutedForeground, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
