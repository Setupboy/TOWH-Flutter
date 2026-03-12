import 'package:flutter/material.dart';

import '../models/game_document.dart';
import '../../features/game/screens/game_view.dart';
import '../../features/game/screens/result_view.dart';
import '../../features/game_setup/screens/new_game_view.dart';
import '../../features/game_setup/screens/ready_to_play_view.dart';

Widget buildGameStageView(GameDocument game) {
  switch (game.stage) {
    case 'players_names':
      return NewGameView(gameId: game.id, initialStep: 1, initialGame: game);
    case 'players_answers':
      return NewGameView(gameId: game.id, initialStep: 2, initialGame: game);
    case 'ready_to_play':
      return ReadyToPlayView(gameId: game.id);
    case 'voting':
      return GameView(gameId: game.id);
    case 'completed':
      return ResultView(gameId: game.id);
    default:
      return const NewGameView();
  }
}
