class PlayProceed
  def initialize(play)
    @play = play
  end

  def proceed
    proceed_play_to_next_month
  end

  private

  def proceed_play_to_next_month
    if @play.current_month < 60
      next_month = @play.current_month + 1
      @play.update(current_month: next_month)
    else
      next_month = @play.current_month + 1
      @play.update(current_month: next_month, finished_at: Time.now)
    end
  end
end
