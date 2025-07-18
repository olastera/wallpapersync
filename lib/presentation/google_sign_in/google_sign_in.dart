import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';

class GoogleSignIn extends StatefulWidget {
  const GoogleSignIn({Key? key}) : super(key: key);

  @override
  State<GoogleSignIn> createState() => _GoogleSignInState();
}

class _GoogleSignInState extends State<GoogleSignIn>
    with TickerProviderStateMixin {
  bool _isLoading = false;
  bool _isConnected = true;
  late AnimationController _logoAnimationController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _buttonAnimation;

  // Mock credentials for testing
  final Map<String, String> _mockCredentials = {
    'email': 'usuario@gmail.com',
    'password': 'WallpaperSync123'
  };

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkConnectivity();
  }

  void _initializeAnimations() {
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _logoAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeOutBack,
    ));

    _buttonAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _buttonAnimationController,
      curve: Curves.easeOut,
    ));

    _logoAnimationController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      _buttonAnimationController.forward();
    });
  }

  Future<void> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  Future<void> _handleGoogleSignIn() async {
    if (!_isConnected) {
      _showConnectivityError();
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate authentication delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication success
      HapticFeedback.lightImpact();

      Fluttertoast.showToast(
        msg: "Inicio de sesión exitoso",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppTheme.getSuccessColor(
            Theme.of(context).brightness == Brightness.light),
        textColor: Colors.white,
      );

      // Navigate to album selection
      Navigator.pushReplacementNamed(context, '/album-selection');
    } catch (e) {
      _showAuthenticationError();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showAuthenticationError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Error de autenticación',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          'No se pudo conectar con Google. Verifica tus credenciales:\nEmail: ${_mockCredentials['email']}\nContraseña: ${_mockCredentials['password']}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showConnectivityError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Sin conexión a internet',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: 'airplanemode_active',
              size: 48,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            SizedBox(height: 2.h),
            Text(
              'Necesitas una conexión a internet para iniciar sesión con Google.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _checkConnectivity();
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicy() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 12.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Text(
                'Política de Privacidad',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Text(
                    '''WallpaperSync accede a tus fotos de Google Photos únicamente para:

• Mostrar álbumes disponibles para selección
• Descargar imágenes seleccionadas para fondos de pantalla
• Sincronizar cambios automáticos según tu configuración

Nunca modificamos, eliminamos o compartimos tus fotos. El acceso es de solo lectura y puedes revocarlo en cualquier momento desde la configuración de tu cuenta de Google.

Datos almacenados localmente:
• Preferencias de configuración
• Caché temporal de imágenes
• Historial de fondos aplicados

No recopilamos información personal adicional ni compartimos datos con terceros.''',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Entendido'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: Column(
            children: [
              // Back button for iOS style
              if (Theme.of(context).platform == TargetPlatform.iOS)
                Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo animation
                    AnimatedBuilder(
                      animation: _logoAnimation,
                      builder: (context, child) => Transform.scale(
                        scale: _logoAnimation.value,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(4.w),
                          ),
                          child: Center(
                            child: CustomIconWidget(
                              iconName: 'wallpaper',
                              size: 10.w,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Welcome message
                    Text(
                      '¡Bienvenido a WallpaperSync!',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 2.h),

                    Text(
                      'Automatiza tus fondos de pantalla con tus fotos favoritas de Google Photos',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 6.h),

                    // Sign in button animation
                    AnimatedBuilder(
                      animation: _buttonAnimation,
                      builder: (context, child) => Transform.scale(
                        scale: _buttonAnimation.value,
                        child: SizedBox(
                          width: double.infinity,
                          height: 6.h,
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleGoogleSignIn,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              foregroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3.w),
                              ),
                            ),
                            child: _isLoading
                                ? SizedBox(
                                    width: 5.w,
                                    height: 5.w,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomIconWidget(
                                        iconName: 'login',
                                        size: 5.w,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        'Iniciar sesión con Google',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Privacy notice
                    GestureDetector(
                      onTap: _showPrivacyPolicy,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(2.w),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'privacy_tip',
                                  size: 4.w,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                SizedBox(width: 2.w),
                                Expanded(
                                  child: Text(
                                    'Acceso de solo lectura a Google Photos',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Solo accedemos a tus fotos para mostrar álbumes y aplicar fondos. Toca para ver la política de privacidad completa.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Connection status indicator
              if (!_isConnected)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(3.w),
                  margin: EdgeInsets.only(bottom: 2.h),
                  decoration: BoxDecoration(
                    color: AppTheme.getWarningColor(
                            Theme.of(context).brightness == Brightness.light)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                    border: Border.all(
                      color: AppTheme.getWarningColor(
                          Theme.of(context).brightness == Brightness.light),
                    ),
                  ),
                  child: Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'wifi_off',
                        size: 4.w,
                        color: AppTheme.getWarningColor(
                            Theme.of(context).brightness == Brightness.light),
                      ),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          'Sin conexión a internet',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppTheme.getWarningColor(
                                        Theme.of(context).brightness ==
                                            Brightness.light),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: _checkConnectivity,
                        child: Text(
                          'Reintentar',
                          style: TextStyle(
                            color: AppTheme.getWarningColor(
                                Theme.of(context).brightness ==
                                    Brightness.light),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
