import 'dart:math';

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:icon/controller/pos_controller.dart';
import 'package:icon/controller/product_all_controller.dart';
import 'package:icon/screen/auth_screen.dart';
import 'package:icon/screen/home_page.dart';
import 'package:icon/screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';



enum ParticleType {
  Shape,
  Image,
}

class Splash extends StatefulWidget {
  @override
  _Splash createState() => new _Splash();
}

class _Splash extends State<Splash> with SingleTickerProviderStateMixin {
  static const numBehaviours = 6;
  PosController posController = Get.put(PosController());
  ProductAllController proAllController = Get.put(ProductAllController());
  // Particles
  ParticleType? _particleType = ParticleType.Image;
  Image _image = Image.asset('assets/images/logo.png');

  ParticleOptions particleOptions = ParticleOptions(
    image: Image.asset('assets/images/logo.png'),
    baseColor: Colors.blue,
    spawnOpacity: 0.0,
    opacityChangeRate: 0.25,
    minOpacity: 0.1,
    maxOpacity: 0.4,
    spawnMinSpeed: 30.0,
    spawnMaxSpeed: 70.0,
    spawnMinRadius: 7.0,
    spawnMaxRadius: 15.0,
    particleCount: 40,
  );

  var particlePaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1.0;

  // Lines

  var _lineDirection = LineDirection.Ltr;
  int _lineCount = 50;

  // Bubbles
  BubbleOptions _bubbleOptions = BubbleOptions();

  // General Variables
  int _behaviourIndex = 0;
  Behaviour? _behaviour;

  bool _showSettings = false;
  late Timer timer;
  String? auth;
  String? user;
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      auth = prefs.getString('baseurl');
      user = prefs.getString('user');
    });

  }

  @override
  void initState() {
    posController.getLang(context);
    proAllController.getLang(context);

    getToken();
    timer = Timer.periodic(Duration(seconds: 5), (_) {
      if (auth == null) {

     setState(() {
          timer.cancel();
          // percent=0;
        });
     Get.offAll(()=>AuthPage());

      }else if(user==null){
        setState(() {
          timer.cancel();
          // percent=0;
        });
        Get.offAll(()=>LoginPage());
      }else{
        setState(() {
          timer.cancel();
          // percent=0;
        });
        Get.offAll(()=>HomePage());
      }
    });
    //  navigationPage();
  }

  Behaviour _buildBehaviour() {
    switch (_behaviourIndex) {
      case 0:
        return RandomParticleBehaviour(
          options: particleOptions,
          paint: particlePaint,
        );
      case 1:
        return RainParticleBehaviour(
          options: particleOptions,
          paint: particlePaint,
          enabled: !_showSettings,
        );
      case 2:
        return RectanglesBehaviour();
      case 3:
        return RacingLinesBehaviour(
          direction: _lineDirection,
          numLines: _lineCount,
        );
      case 4:
        return BubblesBehaviour(
          options: _bubbleOptions,
        );
      case 5:
        return SpaceBehaviour();
    }

    return RandomParticleBehaviour(
      options: particleOptions,
      paint: particlePaint,
    );
  }

  @override
  Widget build(BuildContext contextt) {
    return new Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF2e7ee1).withOpacity(0.2),
                Color(0xFF2e7eed).withOpacity(0.5),
                Color(0xFF2e7eed).withOpacity(0.7),
              ],
              end: const Alignment(0.0, 0.6),
              begin: const Alignment(0.0, -1),
            ),
          ),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', width: 250),

            ],
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ),
        AnimatedBackground(
          behaviour: _behaviour = _buildBehaviour(),
          vsync: this,
          child: Text(''),
        ),
      ],
    ));
  }
}

class RainParticleBehaviour extends RandomParticleBehaviour {
  static Random random = Random();

  bool enabled;

  RainParticleBehaviour({
    ParticleOptions options = const ParticleOptions(),
    Paint? paint,
    this.enabled = true,
  }) : super(options: options, paint: paint);

  @override
  void initPosition(Particle p) {
    p.cx = random.nextDouble() * size!.width;
    if (p.cy == 0.0)
      p.cy = random.nextDouble() * size!.height;
    else
      p.cy = random.nextDouble() * size!.width * 0.2;
  }

  @override
  void initDirection(Particle p, double speed) {
    double dirX = (random.nextDouble() - 0.5);
    double dirY = random.nextDouble() * 0.5 + 0.5;
    double magSq = dirX * dirX + dirY * dirY;
    double mag = magSq <= 0 ? 1 : sqrt(magSq);

    p.dx = dirX / mag * speed;
    p.dy = dirY / mag * speed;
  }

  @override
  Widget builder(
      BuildContext context, BoxConstraints constraints, Widget child) {
    return GestureDetector(
      onPanUpdate: enabled
          ? (details) => _updateParticles(context, details.globalPosition)
          : null,
      onTapDown: enabled
          ? (details) => _updateParticles(context, details.globalPosition)
          : null,
      child: ConstrainedBox(
        // necessary to force gesture detector to cover screen
        constraints: BoxConstraints(
            minHeight: double.infinity, minWidth: double.infinity),
        child: super.builder(context, constraints, child),
      ),
    );
  }

  void _updateParticles(BuildContext context, Offset offsetGlobal) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.globalToLocal(offsetGlobal);
    particles!.forEach((particle) {
      var delta = (Offset(particle.cx, particle.cy) - offset);
      if (delta.distanceSquared < 70 * 70) {
        var speed = particle.speed;
        var mag = delta.distance;
        speed *= (70 - mag) / 70.0 * 2.0 + 0.5;
        speed = max(options.spawnMinSpeed, min(options.spawnMaxSpeed, speed));
        particle.dx = delta.dx / mag * speed;
        particle.dy = delta.dy / mag * speed;
      }
    });
  }
}
