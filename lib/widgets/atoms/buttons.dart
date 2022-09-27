import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.text, this.onPressed, this.color})
      : super(key: key);
  final Widget text;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondaryContainer),
            borderRadius: BorderRadius.circular(16)),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  onPressed?.call();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: text,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                ))));
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton(
      {Key? key, required this.text, required this.onPressed, this.color})
      : super(key: key);
  final String text;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(20)),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  onPressed();
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: TextStyle(
                        color: (color != null)
                            ? color
                            : Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withAlpha(100)),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 25.0 / 2),
                ))));
  }
}

// ignore: must_be_immutable
class IconButtonWidget extends StatefulWidget {
  IconButtonWidget({
    Key? key,
    this.onPressed,
    this.color,
    required this.icon,
  }) : super(key: key);
  final Color? color;
  final IconData icon;
  final Function? onPressed;
  late Function onTap;
  set setonTap(func) {
    onTap = func;
  }

  @override
  _IconButtonWidgetState createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  @override
  void initState() {
    super.initState();
    if (widget.onPressed != null) {
      widget.onTap = widget.onPressed!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 5, bottom: 10),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.secondaryContainer),
            borderRadius: BorderRadius.circular(16),
            color: widget.color ?? Theme.of(context).colorScheme.primary),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  widget.onTap();
                },
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                ))));
  }
}
