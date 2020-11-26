require 'ruby2d'

require_relative './gameData/ball.rb'
require_relative './gameData/paddle.rb'

set background: 'black'

player = Paddle.new(:left, 5)
oponent = Paddle.new(:right, 5)
ball = Ball.new()

update do
    clear

    if player.hit_ball?(ball)
        ball.bounce
    end

    player.move
    player.draw
    
    oponent.draw
    ball.draw
    ball.move
end

on :key_down do |event|
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