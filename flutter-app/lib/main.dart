import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synapseos_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:synapseos_flutter/features/auth/presentation/pages/login_page.dart';
import 'package:synapseos_flutter/features/workspace/presentation/pages/workspace_home_page.dart';

void main() {
  runApp(const SynapseOSApp());
}

class SynapseOSApp extends StatelessWidget {
  const SynapseOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: 'SynapseOS',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: SynapseColors.primary,
            brightness: Brightness.dark,
            surface: SynapseColors.background,
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: SynapseColors.background,
          textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return const WorkspaceHomePage();
            }
            return const LoginPage();
          },
        ),
      ),
    );
  }
}
