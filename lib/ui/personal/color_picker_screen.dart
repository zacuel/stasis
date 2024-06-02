import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/authentication/auth_controller.dart';
import '../../navigation.dart';


class ColorPickerScreen extends ConsumerStatefulWidget {
  const ColorPickerScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends ConsumerState<ColorPickerScreen> {
  Color _selectedColor = Colors.red;

  @override
  void initState() {
    super.initState();
    getFavColor();
  }

  void getFavColor() {
    final person = ref.read(personProvider);
    _selectedColor = person!.favoriteColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            navigateToHome(context);
          },
        ),
        title: const Text(''),
      ),
      body: Center(
        child: ListTile(
          title: const Text('click the color to open the color picker'),
          subtitle: Text(' ${ColorTools.materialName(_selectedColor)} '),
          trailing: Stack(children: [
            ColorIndicator(
              width: 44,
              height: 44,
              borderRadius: 4,
              color: _selectedColor,
              onSelectFocus: false,
              onSelect: () async {
                final Color colorBeforeDialog = _selectedColor;

                final newColor = await showColorPickerDialog(context, colorBeforeDialog);
                setState(() {
                  _selectedColor = newColor;
                });
                ref.read(authControllerProvider.notifier).changeFavoriteColor(newColor);
              },
            )
          ]),
        ),
      ),
    );
  }
}
