import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget(
      {Key? key,
      required this.icon,
      required this.hint,
      required this.onSave,
      this.inputFormatters,
      this.validator,
      this.label,
      this.inputType = TextInputType.name,
      this.inputAction = TextInputAction.next,
      this.secure = false})
      : super(key: key);

  final IconData icon;
  final String hint;
  final void Function(String) onSave;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool secure;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.secondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextFormField(
            onSaved: (val) {
              onSave(val!);
            },
            inputFormatters: inputFormatters,
            validator: validator,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                labelStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(.33)),
                labelText: label,
                prefixIcon: Icon(
                  icon,
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(.33),
                ),
                hintText: hint),
            obscureText: secure));
  }
}
