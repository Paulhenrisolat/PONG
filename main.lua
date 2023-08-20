-- pad(raquette) property
pad = {}
pad.x = 10
pad.y = 250
pad.width = 20
pad.length = 80

padSec = {}
padSec.x = 770
padSec.y = 250
padSec.width = 20
padSec.length = 80

-- ball property
ball = {}
ball.x = 50
ball.y = 50
ball.width = 20
ball.length = 20
ball.speedX = 2
ball.speedY = 2

-- moving the pad
function MovePad()
  --Player 1
  if (love.keyboard.isDown("down") or love.keyboard.isDown("s")) and pad.y < screenHeight - pad.length then
    pad.y = pad.y + 5
   --print("maxheight=".. screenHeight .." pad1height=".. pad.y + pad.length)
  end
  if (love.keyboard.isDown("up") or love.keyboard.isDown("z")) and pad.y > 0 then
      pad.y = pad.y - 5
  end
  --Player 2
  if (love.keyboard.isDown("down") or love.keyboard.isDown("m")) and padSec.y < screenHeight - padSec.length then
    padSec.y = padSec.y + 5
   --print("maxheight=".. screenHeight .." pad1height=".. pad.y + pad.length)
  end
  if (love.keyboard.isDown("up") or love.keyboard.isDown("p")) and padSec.y > 0 then
      padSec.y = padSec.y - 5
  end
end

-- moving the ball
function BallMovement()
  ball.x = ball.x + ball.speedX
  ball.y = ball.y + ball.speedY
  
  -- Reverse speed if its collide limit of the screen
  if  ball.x < 0 then
    ball.speedX = ball.speedX * -1
  end
  if  ball.y < 0 then
    ball.speedY = ball.speedY * -1
  end
  if  ball.x > screenWidth - ball.width then
    ball.speedX = ball.speedX * -1
  end
  if  ball.y > screenHeight - ball.length then
    ball.speedY = ball.speedY * -1
  end
  
  -- Reverse speed if its collide the pad
  if ball.x <= pad.x + pad.width then
    if ball.y + ball.length > pad.y and ball.y < pad.y + pad.length then
      ball.speedX = ball.speedX * -1
      ball.x = pad.x + pad.width
    end
  elseif ball.x + ball.width > padSec.x then
    if ball.y + ball.length > padSec.y and ball.y < padSec.y + padSec.length then
      ball.speedX = ball.speedX * -1
    end
  end
end

-- match gameplay
function Match()
  if ball.x >= screenWidth - ball.width then
    print("p1 win !")
    CenterBall()
  end
  if ball.x <= 0 then
    print("p2 win !")
    CenterBall()
  end
end
-- center the ball on screen
function CenterBall()  
  ball.x = screenWidth / 2
  ball.x = ball.x - ball.width / 2
  ball.y = screenHeight / 2
  ball.y = ball.y - ball.length / 2
end
-- Starting script loading one time only
function love.load()
  -- screen property
  screenHeight = love.graphics.getHeight()
  screenWidth = love.graphics.getWidth()
  print("Screen H:"..screenHeight.." W:"..screenWidth)
  -- center ball on screen
  CenterBall()
end

-- Updating script refresh each frame 
function love.update()
  MovePad()
  BallMovement()
  Match()
end

-- Drawing script draw the game in the Love2D 'engine' 
function love.draw()
  love.graphics.rectangle("fill", pad.x, pad.y, pad.width, pad.length)
  love.graphics.rectangle("fill", padSec.x, padSec.y, padSec.width, padSec.length)
  love.graphics.rectangle("fill", ball.x, ball.y, ball.width, ball.length)
end
