module GamesHelper
  def captured_class(game)
    game.captured ? "capture-status-captured" : "capture-status-inprogress"
  end
end
