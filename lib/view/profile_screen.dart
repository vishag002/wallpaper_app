import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:wallpaper_app/controller/theme_controller.dart';
import 'package:wallpaper_app/utilis/text_const.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: theme.primary,
          appBar: AppBar(
            title: Text("Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .15,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: theme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 35,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "email@here.com",
                          style: TextStyles.subtitle.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Settings",
                  style: TextStyles.heading.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Themes",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildThemeButton(
                      context,
                      "System",
                      themeProvider.themeMode == AdaptiveThemeMode.system,
                      () => themeProvider.setThemeMode(
                          context, AdaptiveThemeMode.system),
                    ),
                    _buildThemeButton(
                      context,
                      "Light",
                      themeProvider.themeMode == AdaptiveThemeMode.light,
                      () => themeProvider.setThemeMode(
                          context, AdaptiveThemeMode.light),
                    ),
                    _buildThemeButton(
                      context,
                      "Dark",
                      themeProvider.themeMode == AdaptiveThemeMode.dark,
                      () => themeProvider.setThemeMode(
                          context, AdaptiveThemeMode.dark),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeButton(
      BuildContext context, String text, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 100,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            // isSelected
            //     ? Theme.of(context).colorScheme.secondary
            //     : Colors.grey,
            width: .5,
          ),
          color: isSelected
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyles.body.copyWith(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
