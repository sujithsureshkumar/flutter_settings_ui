import 'package:flutter/material.dart';
import 'package:flutter_settings_ui/src/tiles/abstract_settings_tile.dart';
import 'package:flutter_settings_ui/src/tiles/platforms/android_settings_tile.dart';
import 'package:flutter_settings_ui/src/tiles/platforms/ios_settings_tile.dart';
import 'package:flutter_settings_ui/src/tiles/platforms/web_settings_tile.dart';
import 'package:flutter_settings_ui/src/utils/platform_utils.dart';
import 'package:flutter_settings_ui/src/utils/settings_theme.dart';

enum SettingsTileType { simpleTile, switchTile, navigationTile, popupTile }

class SettingsTile<T> extends AbstractSettingsTile {
  SettingsTile({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.descriptionInlineIos = false,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    Key? key,
  }) : super(key: key) {
    onToggle = null;
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.simpleTile;
    initialValueForPopupMenu = null;
    itemBuilderForPopupMenu = null;
    onSelectedForPopupMenu = null;
    childForPopupMenu = null;
  }

  SettingsTile.navigation({
    this.leading,
    this.trailing,
    this.value,
    required this.title,
    this.description,
    this.descriptionInlineIos = false,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    Key? key,
  }) : super(key: key) {
    onToggle = null;
    initialValue = null;
    activeSwitchColor = null;
    tileType = SettingsTileType.navigationTile;
    initialValueForPopupMenu = null;
    itemBuilderForPopupMenu = null;
    onSelectedForPopupMenu = null;
    childForPopupMenu = null;
  }

  SettingsTile.switchTile({
    required this.initialValue,
    required this.onToggle,
    this.descriptionInlineIos = false,
    this.activeSwitchColor,
    this.leading,
    this.trailing,
    required this.title,
    this.description,
    this.onPressed,
    this.enabled = true,
    this.backgroundColor,
    Key? key,
  }) : super(key: key) {
    value = null;
    tileType = SettingsTileType.switchTile;
    initialValueForPopupMenu = null;
    itemBuilderForPopupMenu = null;
    onSelectedForPopupMenu = null;
    childForPopupMenu = null;
  }

  SettingsTile.popUpTile({
    required this.initialValueForPopupMenu,
    required this.itemBuilderForPopupMenu,
    required this.onSelectedForPopupMenu,
    required this.childForPopupMenu,
    this.descriptionInlineIos = false,
    this.leading,
    required this.title,
    this.description,
    this.enabled = true,
    this.backgroundColor,
    Key? key,
  }) : super(key: key) {
    value = null;
    tileType = SettingsTileType.popupTile;
    initialValue = null;
    onToggle = null;
    onPressed = null;
    trailing = null;
    activeSwitchColor = null;
  }

  /// The widget at the beginning of the tile
  final Widget? leading;

  /// The Widget at the end of the tile
  late final Widget? trailing;

  /// The widget at the center of the tile
  final Widget title;

  /// The widget at the bottom of the [title]
  final Widget? description;

  final bool descriptionInlineIos;

  final Color? backgroundColor;

  /// A function that is called by tap on a tile
  late final Function(BuildContext context)? onPressed;

  late final Color? activeSwitchColor;
  late final Widget? value;
  late final Function(bool value)? onToggle;
  late final SettingsTileType tileType;
  late final bool? initialValue;
  late final bool enabled;

  late final List<PopupMenuEntry<T>> Function(BuildContext)?
      itemBuilderForPopupMenu;
  late final Widget? childForPopupMenu;
  late final T? initialValueForPopupMenu;
  late final void Function(dynamic)? onSelectedForPopupMenu;

  @override
  Widget build(BuildContext context) {
    final theme = SettingsTheme.of(context);

    switch (theme.platform) {
      case DevicePlatform.android:
      case DevicePlatform.fuchsia:
      case DevicePlatform.linux:
        return AndroidSettingsTile(
          description: description,
          onPressed: onPressed,
          onToggle: onToggle,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          enabled: enabled,
          activeSwitchColor: activeSwitchColor,
          initialValue: initialValue ?? false,
          trailing: trailing,
          backgroundColor: backgroundColor,
        );
      case DevicePlatform.iOS:
      case DevicePlatform.macOS:
      case DevicePlatform.windows:
        return IOSSettingsTile(
          description: description,
          descriptionInline: descriptionInlineIos,
          onPressed: onPressed,
          onToggle: onToggle,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          trailing: trailing,
          enabled: enabled,
          activeSwitchColor: activeSwitchColor,
          initialValue: initialValue ?? false,
          backgroundColor: backgroundColor,
          initialValueForPopupMenu: initialValueForPopupMenu,
          itemBuilderForPopupMenu: itemBuilderForPopupMenu,
          onSelectedForPopupMenu: onSelectedForPopupMenu,
          childForPopupMenu: childForPopupMenu,
        );
      case DevicePlatform.web:
        return WebSettingsTile(
          description: description,
          onPressed: onPressed,
          onToggle: onToggle,
          tileType: tileType,
          value: value,
          leading: leading,
          title: title,
          enabled: enabled,
          trailing: trailing,
          activeSwitchColor: activeSwitchColor,
          initialValue: initialValue ?? false,
        );
      case DevicePlatform.device:
        throw Exception(
          "You can't use the DevicePlatform.device in this context. "
          'Incorrect platform: SettingsTile.build',
        );
    }
  }
}
