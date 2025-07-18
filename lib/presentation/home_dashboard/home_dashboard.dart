import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/current_wallpaper_card_widget.dart';
import './widgets/quick_actions_widget.dart';
import './widgets/recent_history_widget.dart';
import './widgets/status_section_widget.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({Key? key}) : super(key: key);

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = false;
  bool _isAutomationEnabled = true;
  String _selectedAlbum = "Paisajes Naturales";
  int _nextUpdateMinutes = 45;

  // Mock data for current wallpaper and history
  final Map<String, dynamic> _currentWallpaper = {
    "id": 1,
    "imageUrl":
        "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "title": "Montañas al Amanecer",
    "album": "Paisajes Naturales",
    "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
  };

  final List<Map<String, dynamic>> _recentHistory = [
    {
      "id": 1,
      "imageUrl":
          "https://images.pexels.com/photos/417074/pexels-photo-417074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Montañas al Amanecer",
      "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
    },
    {
      "id": 2,
      "imageUrl":
          "https://images.pixabay.com/photo-2015/04/23/22/00/tree-736885_1280.jpg",
      "title": "Árbol Solitario",
      "timestamp": DateTime.now().subtract(Duration(hours: 2)),
    },
    {
      "id": 3,
      "imageUrl":
          "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80",
      "title": "Lago Sereno",
      "timestamp": DateTime.now().subtract(Duration(hours: 4)),
    },
    {
      "id": 4,
      "imageUrl":
          "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      "title": "Bosque Místico",
      "timestamp": DateTime.now().subtract(Duration(hours: 6)),
    },
    {
      "id": 5,
      "imageUrl":
          "https://images.pixabay.com/photo-2016/05/05/02/37/sunset-1373171_1280.jpg",
      "title": "Atardecer Dorado",
      "timestamp": DateTime.now().subtract(Duration(hours: 8)),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _startCountdownTimer();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _startCountdownTimer() {
    // Simulate countdown timer
    Future.delayed(Duration(seconds: 60), () {
      if (mounted && _nextUpdateMinutes > 0) {
        setState(() {
          _nextUpdateMinutes--;
        });
        _startCountdownTimer();
      }
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _nextUpdateMinutes = 60; // Reset timer
    });
  }

  void _changeWallpaperNow() async {
    HapticFeedback.mediumImpact();
    setState(() {
      _isLoading = true;
    });

    // Simulate wallpaper change
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isLoading = false;
      _nextUpdateMinutes = 60; // Reset timer
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Fondo de pantalla cambiado exitosamente'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showWallpaperContextMenu() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'favorite',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Marcar como Favorito'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Agregado a favoritos')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Compartir Imagen'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Compartiendo imagen...')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'fullscreen',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Ver Tamaño Completo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/wallpaper-preview');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'WallpaperSync',
          style: AppTheme.lightTheme.textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'notifications',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sin notificaciones nuevas')),
              );
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: CustomIconWidget(
                iconName: 'home',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 20,
              ),
              text: 'Inicio',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'photo_library',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              text: 'Álbumes',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'history',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              text: 'Historial',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'settings',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              text: 'Ajustes',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Home Tab
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current Wallpaper Card
                      CurrentWallpaperCardWidget(
                        wallpaper: _currentWallpaper,
                        onLongPress: _showWallpaperContextMenu,
                      ),

                      SizedBox(height: 3.h),

                      // Status Section
                      StatusSectionWidget(
                        isAutomationEnabled: _isAutomationEnabled,
                        selectedAlbum: _selectedAlbum,
                        nextUpdateMinutes: _nextUpdateMinutes,
                        onAutomationToggle: (value) {
                          setState(() {
                            _isAutomationEnabled = value;
                          });
                        },
                        onAlbumTap: () {
                          Navigator.pushNamed(context, '/album-selection');
                        },
                      ),

                      SizedBox(height: 3.h),

                      // Change Now Button
                      SizedBox(
                        width: double.infinity,
                        height: 6.h,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _changeWallpaperNow,
                          child: _isLoading
                              ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppTheme.lightTheme.colorScheme.onPrimary,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Cambiar Ahora',
                                  style: AppTheme
                                      .lightTheme.textTheme.labelLarge
                                      ?.copyWith(
                                    color: AppTheme
                                        .lightTheme.colorScheme.onPrimary,
                                  ),
                                ),
                        ),
                      ),

                      SizedBox(height: 3.h),

                      // Quick Actions
                      QuickActionsWidget(
                        onPreviewTap: () {
                          Navigator.pushNamed(context, '/wallpaper-preview');
                        },
                        onShuffleTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Modo aleatorio activado')),
                          );
                        },
                        onAlbumSwitchTap: () {
                          Navigator.pushNamed(context, '/album-selection');
                        },
                      ),

                      SizedBox(height: 3.h),

                      // Recent History
                      RecentHistoryWidget(
                        historyItems: _recentHistory,
                        onRestoreTap: (wallpaper) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Restaurando: ${wallpaper["title"]}'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Albums Tab Placeholder
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'photo_library',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 48,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Álbumes',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                SizedBox(height: 1.h),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/album-selection');
                  },
                  child: Text('Ir a Selección de Álbumes'),
                ),
              ],
            ),
          ),

          // History Tab Placeholder
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'history',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 48,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Historial',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Aquí verás tu historial completo',
                  style: AppTheme.lightTheme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // Settings Tab Placeholder
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'settings',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 48,
                ),
                SizedBox(height: 2.h),
                Text(
                  'Configuración',
                  style: AppTheme.lightTheme.textTheme.headlineSmall,
                ),
                SizedBox(height: 1.h),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Text('Ir a Configuración'),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/wallpaper-preview');
        },
        child: CustomIconWidget(
          iconName: 'preview',
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          size: 24,
        ),
      ),
    );
  }
}
