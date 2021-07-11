import 'package:flutter/material.dart';
import 'CheckPainter.dart';

class CBoxesAndSlider extends StatefulWidget {
  const CBoxesAndSlider({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<CBoxesAndSlider> createState() => _CBoxesAndSliderState();
}

class _CBoxesAndSliderState extends State<CBoxesAndSlider>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;

  int _selectedIndex = -1;
  int _duration = 200;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: _duration));
    _controller2 = AnimationController(
        vsync: this, duration: Duration(milliseconds: _duration));
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CBox(_duration, 0, _controller, Colors.blue),
                CBox(_duration, 1, _controller2, Colors.green)
              ],
            ),
            buildSlider(),
            Text("${_duration} ms")
          ],
        ),
      ),
    );
  }

  Slider buildSlider() {
    return Slider(
      label: _duration.round().toString(),
      value: _duration.toDouble(),
      min: 200.0,
      max: 2000.0,
      onChanged: (value) {
        setState(() {
          _duration = value.toInt();
          _controller.duration = Duration(milliseconds: _duration);
          _controller2.duration = _controller.duration;
        });
      },
    );
  }

  Widget CBox(
      int duration, int index, AnimationController controller, Color color) {
    var curvedAnimation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeInCirc,
    );
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AnimatedContainer(
          duration: Duration(milliseconds: (duration.toDouble() ~/ 3).toInt()),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(90),
              border: Border.all(
                color: color,
                width: index == _selectedIndex
                    ? (-(1 - controller.value - 2 / 3) *
                            (1 -
                                controller.value -
                                2 / 3) * // border animation curve
                            10 +
                        10)
                    : 3,
              )),
          child: ScaleTransition(
              scale: curvedAnimation,
              child: Container(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      border: Border.all(color: color),
                      borderRadius: BorderRadius.circular(90),
                      color: color),
                  child: CustomPaint(
                    painter: CheckPainter(),
                  ))),
        ),
      ),
      onTap: () {
        if (_selectedIndex != index) {
          _selectedIndex = index;
          if (index == 0) {
            setState(() {
              _controller.animateTo(1);

              _controller2.animateTo(0);
            });
          } else if (index == 1) {
            setState(() {
              _controller.animateTo(0);
              _controller2.animateTo(1);
            });
          }
          Future.delayed(Duration(milliseconds: duration - 20), () {
            setState(() {});
          });
        }
      },
    );
  }
}
