class @Player 
  @player

  constructor: (@player) ->
    if @player  is 'x' then @opponent = 'o' else @opponent = 'x'

  choose_move: (board) ->
    unless board.game_over()
      @negascout(board, 2, -Number.MAX_VALUE, Number.MAX_VALUE, true)
  
  pick_random: (board) ->
    possible_moves = board.possible_moves()
    possible_moves[Math.floor(Math.random() * possible_moves.length)]

  negascout: (board, depth, alpha, beta, maximizing_player) ->
    best_score = alpha
    best_move = []
    
    for move in board.possible_moves()
      best_move = move unless best_move.length
      board.set_at move, @player
      score = -@negascout_helper(board, depth, alpha, beta, not maximizing_player)
      if score > best_score or ((score is best_score) and (Math.random() < 0.5))
          best_score = score
          best_move = move
      board.undo()
    best_move

  negascout_helper: (board, depth, alpha, beta, maximizing_player) ->
    turn = if maximizing_player then @player else @opponent
    if depth is 0
      return @evaluate_score board, turn

    possible_moves = board.possible_moves()
    for move in possible_moves
      board.set_at move, turn
      if (move isnt possible_moves[0])
        score = -@negascout_helper(board, depth - 1, -alpha - 1, -alpha, not maximizing_player)
        if (alpha < score < beta)
          score = -@negascout_helper(board, depth - 1, -beta, -score, not maximizing_player)
      else
        score = -@negascout_helper(board, depth - 1, -beta, -alpha, not maximizing_player)
      board.undo()

      alpha = Math.max(alpha, score)
      if alpha >= beta
        break
    alpha

  evaluate_score: (board, player) ->
    opponent = if player is 'x' then 'o' else 'x'

    player_score = 0
    opponent_score = 0

    winner = board.get_board_winner()
    if winner is @player
      player_score += 9001 #It's over 9000!
    else if winner is @opponent
      opponent_score += 9001

    [blocked_player, blocked_opponent] = board.get_blocked_lines(player, opponent)

    player_score += 100 * (board.blocks_won @player) + 10 * blocked_player +  board.corners_marked @player
    opponent_score += 100 * (board.blocks_won @opponent) + 10 * blocked_opponent + board.corners_marked @opponent 

    if player is @player
      player_score - opponent_score
    else
      opponent_score - player_score