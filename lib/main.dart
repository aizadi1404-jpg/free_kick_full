import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: FreeKickGame(),
    ),
  );
}

class FreeKickGame extends FlameGame with TapDetector, HasGameRef {
  late Ball ball;
  late Goal goal;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(Vector2(400, 800));

    ball = Ball()
      ..position = Vector2(200, 700)
      ..anchor = Anchor.center;

    goal = Goal()
      ..position = Vector2(200, 100)
      ..anchor = Anchor.center;

    add(ball);
    add(goal);
  }

  @override
  void onTapUp(TapUpInfo info) {
    final target = info.eventPosition.game;
    ball.kickTo(target);
  }
}

class Ball extends SpriteComponent with HasGameRef<FreeKickGame> {
  Vector2 velocity = Vector2.zero();
  final double speed = 450;

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ball.');
    size = Vector2(80, 80);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += velocity * dt;

    if (velocity.length > 0) {
      velocity *= 0.98;
      if (velocity.length < 1) {
        velocity = Vector2.zero();
      }
    }

    if
