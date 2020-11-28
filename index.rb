require 'ruby2d'

require_relative './gameData/ball.rb'
require_relative './gameData/paddle.rb'

set background: 'black'

ball_velocity = 8

PONG_SOUND = Sound.new('./gameData/soundFiles/pong.wav')
PING_SOUND = Sound.new('./gameData/soundFiles/ping.wav')

player = Paddle.new(:left, 5)
oponent = Paddle.new(:right, 5)
ball = Ball.new(ball_velocity)

music = Music.new('./gameData/soundFiles/music.wav')
music.loop = true
music.play

update do
    clear

    if player.hit_ball?(ball)
        ball.bounce(player)
        PING_SOUND.play
    end

    if oponent.hit_ball?(ball)
        ball.bounce(oponent)
        PING_SOUND.play
    end

    player.move
    player.draw
    
    oponent.track_ball(ball)
    oponent.draw

    ball.move
    ball.draw

    if ball.out_of_bounds?
        ball = Ball.new(ball_velocity)
    end

end

on :key_held do |event|
    if event.key == 'up'
        player.direction = :up
    elsif event.key == 'down'
        player.direction = :down
    end
end

on :key_up do |event|
    player.direction = nil
end

show