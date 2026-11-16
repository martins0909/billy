import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/billy_colors.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const BillyApp());
}

class BillyApp extends StatelessWidget {
  const BillyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);

    OutlineInputBorder inputBorder(Color c, [double w = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: c, width: w),
        );

    return MaterialApp(
      title: 'Billy',
      debugShowCheckedModeBanner: false,
      theme: base.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: BillyColors.background,
        primaryColor: BillyColors.primary,
        canvasColor: BillyColors.surface,
        colorScheme: const ColorScheme.dark(
          primary: BillyColors.primary,
          secondary: BillyColors.primaryLight,
          surface: BillyColors.surface,
          onSurface: Colors.white,
          error: BillyColors.error,
        ),
        textTheme: base.textTheme.apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        dividerColor: BillyColors.borderSoft,
        dividerTheme: const DividerThemeData(color: BillyColors.borderSoft),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          foregroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        cardTheme: CardThemeData(
          color: BillyColors.surface,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: BillyColors.borderSoft),
          ),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: BillyColors.surfaceHigh,
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: BillyColors.border),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(color: BillyColors.textSecondary, fontSize: 14),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: BillyColors.surface,
          surfaceTintColor: Colors.transparent,
          modalBackgroundColor: BillyColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: BillyColors.surfaceHigh,
          contentTextStyle: const TextStyle(color: Colors.white),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: BillyColors.border),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: BillyColors.surface,
          hintStyle: const TextStyle(color: BillyColors.textMuted),
          labelStyle: const TextStyle(color: BillyColors.textSecondary),
          prefixIconColor: BillyColors.textMuted,
          suffixIconColor: BillyColors.textMuted,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: inputBorder(BillyColors.borderSoft),
          enabledBorder: inputBorder(BillyColors.borderSoft),
          focusedBorder: inputBorder(BillyColors.primaryLight, 1.5),
          errorBorder: inputBorder(BillyColors.error),
          focusedErrorBorder: inputBorder(BillyColors.error, 1.5),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: BillyColors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: BillyColors.surfaceHigh,
            disabledForegroundColor: BillyColors.textMuted,
            elevation: 0,
            shadowColor: BillyColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: BillyColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(color: BillyColors.primaryLight),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: BillyColors.primaryLight),
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: BillyColors.primaryLight,
          textColor: Colors.white,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? Colors.white : BillyColors.textMuted,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (s) => s.contains(WidgetState.selected) ? BillyColors.primary : BillyColors.surfaceHigh,
          ),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: BillyColors.primaryLight),
      ),
      home: const SplashScreen(),
    );
  }
}
