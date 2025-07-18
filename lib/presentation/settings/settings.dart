import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/frequency_picker_widget.dart';
import './widgets/settings_item_widget.dart';
import './widgets/settings_section_widget.dart';
import './widgets/theme_selection_widget.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> with TickerProviderStateMixin {
  late TabController _tabController;

  // Settings state variables
  String _updateFrequency = 'daily';
  bool _isRandomMode = true;
  bool _wifiOnlyUpdates = false;
  String _themeMode = 'system';
  String _wallpaperTarget = 'both';
  String _imageQuality = 'high';
  bool _offlineMode = false;
  String _cacheSize = '0 MB';
  bool _isLoading = false;

  // Mock user data
  final Map<String, dynamic> _userData = {
    "name": "María González",
    "email": "maria.gonzalez@gmail.com",
    "avatar":
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
    "accountType": "Google",
    "joinDate": "Enero 2024"
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this, initialIndex: 5);
    _loadSettings();
    _calculateCacheSize();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _updateFrequency = prefs.getString('update_frequency') ?? 'daily';
      _isRandomMode = prefs.getBool('random_mode') ?? true;
      _wifiOnlyUpdates = prefs.getBool('wifi_only') ?? false;
      _themeMode = prefs.getString('theme_mode') ?? 'system';
      _wallpaperTarget = prefs.getString('wallpaper_target') ?? 'both';
      _imageQuality = prefs.getString('image_quality') ?? 'high';
      _offlineMode = prefs.getBool('offline_mode') ?? false;
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('update_frequency', _updateFrequency);
    await prefs.setBool('random_mode', _isRandomMode);
    await prefs.setBool('wifi_only', _wifiOnlyUpdates);
    await prefs.setString('theme_mode', _themeMode);
    await prefs.setString('wallpaper_target', _wallpaperTarget);
    await prefs.setString('image_quality', _imageQuality);
    await prefs.setBool('offline_mode', _offlineMode);

    Fluttertoast.showToast(
      msg: "Configuración guardada",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  Future<void> _calculateCacheSize() async {
    // Simulate cache calculation
    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      _cacheSize = "127 MB";
    });
  }

  Future<void> _clearCache() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate cache clearing
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _cacheSize = "0 MB";
      _isLoading = false;
    });

    Fluttertoast.showToast(
      msg: "Caché limpiado exitosamente",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _signOut() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Cerrar Sesión',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            '¿Estás seguro de que quieres cerrar sesión?',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/google-sign-in',
                  (route) => false,
                );
              },
              child: Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        title: Text(
          'Configuración',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: AppTheme.lightTheme.tabBarTheme.labelColor,
          unselectedLabelColor:
              AppTheme.lightTheme.tabBarTheme.unselectedLabelColor,
          indicatorColor: AppTheme.lightTheme.tabBarTheme.indicatorColor,
          tabs: [
            Tab(text: 'Inicio'),
            Tab(text: 'Álbumes'),
            Tab(text: 'Vista Previa'),
            Tab(text: 'Historial'),
            Tab(text: 'Sincronización'),
            Tab(text: 'Configuración'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPlaceholderTab('Inicio'),
          _buildPlaceholderTab('Álbumes'),
          _buildPlaceholderTab('Vista Previa'),
          _buildPlaceholderTab('Historial'),
          _buildPlaceholderTab('Sincronización'),
          _buildSettingsContent(),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String tabName) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'settings',
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'Pestaña $tabName',
            style: AppTheme.lightTheme.textTheme.headlineSmall,
          ),
          SizedBox(height: 1.h),
          Text(
            'Contenido disponible próximamente',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsContent() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Automation Section
            SettingsSectionWidget(
              title: 'Automatización',
              children: [
                SettingsItemWidget(
                  title: 'Frecuencia de Actualización',
                  subtitle: _getFrequencyText(_updateFrequency),
                  leadingIcon: 'schedule',
                  onTap: () => _showFrequencyPicker(),
                ),
                SettingsItemWidget(
                  title: 'Modo de Selección',
                  subtitle: _isRandomMode ? 'Aleatorio' : 'Secuencial',
                  leadingIcon: 'shuffle',
                  trailing: Switch(
                    value: _isRandomMode,
                    onChanged: (value) {
                      setState(() {
                        _isRandomMode = value;
                      });
                      _saveSettings();
                    },
                  ),
                ),
                SettingsItemWidget(
                  title: 'Solo WiFi',
                  subtitle: 'Actualizar solo con conexión WiFi',
                  leadingIcon: 'wifi',
                  trailing: Switch(
                    value: _wifiOnlyUpdates,
                    onChanged: (value) {
                      setState(() {
                        _wifiOnlyUpdates = value;
                      });
                      _saveSettings();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Display Section
            SettingsSectionWidget(
              title: 'Pantalla',
              children: [
                SettingsItemWidget(
                  title: 'Tema',
                  subtitle: _getThemeText(_themeMode),
                  leadingIcon: 'palette',
                  onTap: () => _showThemeSelector(),
                ),
                SettingsItemWidget(
                  title: 'Aplicar Fondo a',
                  subtitle: _getTargetText(_wallpaperTarget),
                  leadingIcon: 'wallpaper',
                  onTap: () => _showTargetSelector(),
                ),
                SettingsItemWidget(
                  title: 'Calidad de Imagen',
                  subtitle: _getQualityText(_imageQuality),
                  leadingIcon: 'high_quality',
                  onTap: () => _showQualitySelector(),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Storage Section
            SettingsSectionWidget(
              title: 'Almacenamiento',
              children: [
                SettingsItemWidget(
                  title: 'Uso de Caché',
                  subtitle: _cacheSize,
                  leadingIcon: 'storage',
                  trailing: _isLoading
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : TextButton(
                          onPressed: _clearCache,
                          child: Text('Limpiar'),
                        ),
                ),
                SettingsItemWidget(
                  title: 'Modo Offline',
                  subtitle: 'Usar solo imágenes en caché',
                  leadingIcon: 'offline_bolt',
                  trailing: Switch(
                    value: _offlineMode,
                    onChanged: (value) {
                      setState(() {
                        _offlineMode = value;
                      });
                      _saveSettings();
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Account Section
            SettingsSectionWidget(
              title: 'Cuenta',
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: CustomImageWidget(
                          imageUrl: _userData["avatar"] as String,
                          width: 16.w,
                          height: 16.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userData["name"] as String,
                              style: AppTheme.lightTheme.textTheme.titleMedium,
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              _userData["email"] as String,
                              style: AppTheme.lightTheme.textTheme.bodySmall,
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              'Miembro desde ${_userData["joinDate"]}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SettingsItemWidget(
                  title: 'Cerrar Sesión',
                  leadingIcon: 'logout',
                  onTap: _signOut,
                  textColor: AppTheme.lightTheme.colorScheme.error,
                ),
                SettingsItemWidget(
                  title: 'Política de Privacidad',
                  leadingIcon: 'privacy_tip',
                  onTap: () {
                    // Open privacy policy
                  },
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // About Section
            SettingsSectionWidget(
              title: 'Acerca de',
              children: [
                SettingsItemWidget(
                  title: 'Versión de la App',
                  subtitle: '1.0.0 (Build 1)',
                  leadingIcon: 'info',
                ),
                SettingsItemWidget(
                  title: 'Términos de Servicio',
                  leadingIcon: 'description',
                  onTap: () {
                    // Open terms of service
                  },
                ),
                SettingsItemWidget(
                  title: 'Soporte',
                  leadingIcon: 'support',
                  onTap: () {
                    // Open support
                  },
                ),
              ],
            ),

            SizedBox(height: 4.h),
          ],
        ),
      ),
    );
  }

  void _showFrequencyPicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FrequencyPickerWidget(
        currentFrequency: _updateFrequency,
        onFrequencyChanged: (frequency) {
          setState(() {
            _updateFrequency = frequency;
          });
          _saveSettings();
        },
      ),
    );
  }

  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeSelectionWidget(
        currentTheme: _themeMode,
        onThemeChanged: (theme) {
          setState(() {
            _themeMode = theme;
          });
          _saveSettings();
        },
      ),
    );
  }

  void _showTargetSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildTargetSelector(),
    );
  }

  void _showQualitySelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => _buildQualitySelector(),
    );
  }

  Widget _buildTargetSelector() {
    final targets = [
      {'value': 'home', 'title': 'Pantalla de Inicio', 'icon': 'home'},
      {'value': 'lock', 'title': 'Pantalla de Bloqueo', 'icon': 'lock'},
      {'value': 'both', 'title': 'Ambas Pantallas', 'icon': 'wallpaper'},
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Aplicar Fondo a',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          SizedBox(height: 2.h),
          ...targets.map((target) => ListTile(
                leading: CustomIconWidget(
                  iconName: target['icon'] as String,
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 24,
                ),
                title: Text(target['title'] as String),
                trailing: _wallpaperTarget == target['value']
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _wallpaperTarget = target['value'] as String;
                  });
                  _saveSettings();
                  Navigator.pop(context);
                },
              )),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  Widget _buildQualitySelector() {
    final qualities = [
      {
        'value': 'low',
        'title': 'Baja (Ahorra datos)',
        'icon': 'signal_cellular_1_bar'
      },
      {
        'value': 'medium',
        'title': 'Media (Balanceada)',
        'icon': 'signal_cellular_2_bar'
      },
      {
        'value': 'high',
        'title': 'Alta (Mejor calidad)',
        'icon': 'signal_cellular_4_bar'
      },
    ];

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Calidad de Imagen',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          SizedBox(height: 2.h),
          ...qualities.map((quality) => ListTile(
                leading: CustomIconWidget(
                  iconName: quality['icon'] as String,
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 24,
                ),
                title: Text(quality['title'] as String),
                trailing: _imageQuality == quality['value']
                    ? CustomIconWidget(
                        iconName: 'check',
                        color: AppTheme.lightTheme.colorScheme.primary,
                        size: 20,
                      )
                    : null,
                onTap: () {
                  setState(() {
                    _imageQuality = quality['value'] as String;
                  });
                  _saveSettings();
                  Navigator.pop(context);
                },
              )),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }

  String _getFrequencyText(String frequency) {
    switch (frequency) {
      case 'hourly':
        return 'Cada hora';
      case 'daily':
        return 'Diariamente';
      case 'weekly':
        return 'Semanalmente';
      case 'custom':
        return 'Personalizado';
      default:
        return 'Diariamente';
    }
  }

  String _getThemeText(String theme) {
    switch (theme) {
      case 'light':
        return 'Claro';
      case 'dark':
        return 'Oscuro';
      case 'system':
        return 'Sistema';
      default:
        return 'Sistema';
    }
  }

  String _getTargetText(String target) {
    switch (target) {
      case 'home':
        return 'Pantalla de Inicio';
      case 'lock':
        return 'Pantalla de Bloqueo';
      case 'both':
        return 'Ambas Pantallas';
      default:
        return 'Ambas Pantallas';
    }
  }

  String _getQualityText(String quality) {
    switch (quality) {
      case 'low':
        return 'Baja';
      case 'medium':
        return 'Media';
      case 'high':
        return 'Alta';
      default:
        return 'Alta';
    }
  }
}
