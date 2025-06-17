import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/theme_cubit.dart';

class MenuScreen extends StatefulWidget {
  final VoidCallback onToggleTheme;

  const MenuScreen({Key? key, required this.onToggleTheme}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return Material(
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome 👋",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "TailMate User",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Divider(color: Colors.grey.shade300),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Dark Theme", style: TextStyle(fontSize: 16)),
                  Switch.adaptive(
                    value: isDark,
                    onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
                  ),
                ],
              ),
              const Spacer(), // pushes below content to the bottom
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "v1.0.0 © TailMate",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // return Material(
    //   child: SizedBox(
    //     height: MediaQuery.of(context).size.height,
    //     child: SafeArea(
    //       child: SingleChildScrollView(
    //         child: Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    //           child: Column(
    //             children: [
    //               Expanded(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     const Row(
    //                       children: [
    //                         CircleAvatar(
    //                           radius: 30,
    //                           backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
    //                         ),
    //                         SizedBox(width: 12),
    //                         Column(
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Text(
    //                               "Welcome 👋",
    //                               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //                             ),
    //                             Text(
    //                               "TailMate User",
    //                               style: TextStyle(color: Colors.grey),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     const SizedBox(height: 40),
    //                     Divider(color: Colors.grey.shade300),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         const Text("Dark Theme", style: TextStyle(fontSize: 16)),
    //                         Switch.adaptive(
    //                           value: isDark,
    //                           onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               Center(
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(bottom: 16.0),
    //                   child: Text(
    //                     "v1.0.0 © TailMate",
    //                     style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //
    //           // child: Column(
    //           //   crossAxisAlignment: CrossAxisAlignment.start,
    //           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //   children: [
    //           //     Column(
    //           //       children: [
    //           //         const Row(
    //           //           children: [
    //           //             CircleAvatar(
    //           //               radius: 30,
    //           //               backgroundImage: NetworkImage("https://i.pravatar.cc/150?img=3"),
    //           //             ),
    //           //             SizedBox(width: 12),
    //           //             Column(
    //           //               crossAxisAlignment: CrossAxisAlignment.start,
    //           //               children: [
    //           //                 Text(
    //           //                   "Welcome 👋",
    //           //                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //           //                 ),
    //           //                 Text(
    //           //                   "TailMate User",
    //           //                   style: TextStyle(color: Colors.grey),
    //           //                 ),
    //           //               ],
    //           //             ),
    //           //           ],
    //           //         ),
    //           //         const SizedBox(height: 40),
    //           //         Divider(color: Colors.grey.shade300),
    //           //         Row(
    //           //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //           children: [
    //           //             const Text("Dark Theme", style: TextStyle(fontSize: 16)),
    //           //             Switch.adaptive(
    //           //               value: isDark,
    //           //               onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
    //           //             ),
    //           //           ],
    //           //         ),
    //           //       ],
    //           //     ),
    //           //
    //           //     Center(
    //           //       child: Text(
    //           //         "v1.0.0 © TailMate",
    //           //         style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
    //           //       ),
    //           //     ),
    //           //   ],
    //           // ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
