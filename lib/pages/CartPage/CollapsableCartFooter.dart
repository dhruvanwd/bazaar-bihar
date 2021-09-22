import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';

class CollapsableCartFooter extends StatefulWidget {
  final Widget childWidget;
  const CollapsableCartFooter(this.childWidget);

  @override
  _CollapsableCartFooterState createState() => _CollapsableCartFooterState();
}

class _CollapsableCartFooterState extends State<CollapsableCartFooter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final containerHeight = 200.0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        value: 0.1,
        lowerBound: 0.1,
        duration: Duration(
          seconds: 1,
        ));

    _animationController.addListener(() {
      print(_animationController.value);
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Container(),
      builder: (context, child) {
        final bool isClosed = _animationController.value < 0.2;
        return Stack(
          children: [
            SizedBox(
              height: containerHeight * _animationController.value,
              child: isClosed ? Container() : widget.childWidget,
            ),
            Positioned(
              top: -15,
              right: 8,
              child: IconButton(
                onPressed: () {
                  if (isClosed)
                    _animationController.forward();
                  else
                    _animationController.reverse();
                },
                icon: isClosed
                    ? Icon(FontAwesome.angle_up)
                    : Icon(
                        FontAwesome.angle_down,
                        color: Colors.deepOrange,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
