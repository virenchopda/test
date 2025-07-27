       showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  titlePadding: const EdgeInsets.all(0),
                  contentPadding: const EdgeInsets.all(0),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: widget.pickerColor,
                      onColorChanged: widget.onColorChanged,
                      colorPickerWidth: 300,
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: _enableAlpha,
                      labelTypes: _labelTypes,
                      displayThumbColor: _displayThumbColor,
                      paletteType: _paletteType,
                      pickerAreaBorderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(2),
                        topRight: Radius.circular(2),
                      ),
                      hexInputBar: _displayHexInputBar,
                      colorHistory: widget.colorHistory,
                      onHistoryChanged: widget.onHistoryChanged,
                    ),
                  ),
                );
              },
            );
    
