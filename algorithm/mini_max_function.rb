module MiniMaxFunction
  ##
  # Method performing the minimax algorithm   for next step prediction
  # ++node++::: the current node for which we are calculating the minimax function
  # ++alpha+:: the alpha value used by alpha beta prunning
  # ++beta++:: the beta value used by alpha beta prunning
  # Based on: {Minimax description}[http://web.cs.ucla.edu/~rosen/161/notes/alphabeta.html]
  def minimax(node, depth, alpha = -Float::INFINITY, beta = Float::INFINITY, maximizing_player = true)
    if depth == 0 || node.children.empty?
      return node.value = node.evaluate
    end

    if maximizing_player
      best_value = -Float::INFINITY

      node.children.each do |child|
        child_value = minimax(child, depth - 1, alpha, beta, false)
        best_value = [best_value, child_value].max
        alpha = [alpha, best_value].max
        # alpha-beta prunning 'optimatization'
        break if beta <= alpha
      end
    else
      best_value = Float::INFINITY

      node.children.each do |child|
        child_value = minimax(child, depth - 1, alpha, beta, true)
        best_value = [best_value, child_value].min
        beta = [beta, best_value].min
        break if beta <= alpha
      end
    end

    node.value = best_value
  end
end