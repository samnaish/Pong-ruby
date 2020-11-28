require 'ruby2d'

require_relative 'paddle.rb'

class Ball
    HEIGHT = 25
    attr_reader :shape, :x_velocity, :y_velocity

    def initialize(speed)
        @x = 320
        @y = 400
        @speed = speed
        @y_velocity = speed
        @x_velocity = -speed
    end

    def move
        if hit_bottom? || hit_top?
            @y_velocity = -@y_velocity
        end
        @x = @x + @x_velocity
        @y = @y + @y_velocity
    end

    def draw
        @shape = Square.new(
            x: @x,
            y: @y,
            size: HEIGHT,
            color: 'white'
        )
    end

    def bounce(paddle)
        if @last_hit_side != paddle.side
            position = ((@shape.y1 - paddle.y1) / Paddle::HEIGHT.to_f)
            angle = position.clamp(0.2, 0.8) * Math::PI

            puts "position #{position}"

            if paddle.side == :left
                @x_velocity = Math.sin(angle) * @speed
                @y_velocity = -Math.cos(angle) * @speed
            else
                @x_velocity = -Math.sin(angle) * @speed
                @y_velocity = -Math.cos(angle) * @speed
            end
    end
      @last_hit_side = paddle.side
    #   @x_velocity = -@x_velocity
    end

    def y_middle
        height = @y + (HEIGHT / 2)
        return height
    end

    def out_of_bounds?
        @x <= 0 || @shape.x2 >= Window.width
    end

    private

    def hit_bottom?
        hit_bottom = @y + HEIGHT >= Window.height
        PONG_SOUND.play
        return hit_bottom
    end

    def hit_top?
        PONG_SOUND.play
        hit_top = @y <= 0
        return hit_top
    end

end