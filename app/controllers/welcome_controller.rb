class WelcomeController < ApplicationController
  @@players = []

  def index
    @messages = Message.all.order('created_at DESC').limit(50)
    @@players += [current_or_guest_player.email.gsub(/[^0-9A-Za-z]/, '')]
    @players = @@players
    @thisplayer = current_or_guest_player.email.gsub(/[^0-9A-Za-z]/, '')
    if @players.include?(@thisplayer)
      @players = @players - [@thisplayer]
    end
  end

  def new_message
    @message = Message.new
    @message.content = params[:message][:content]
    @message.name = current_or_guest_player.email
    @message.player_id = current_or_guest_player.id
    @message.save!
    return render :nothing => true
  end
end
