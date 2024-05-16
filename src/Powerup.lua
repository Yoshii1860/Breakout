--[[
    GD50
    Breakout Remake

    -- Powerup Class --

    Author: Andreas Antoniol
    andreas@antoniol.de

    Represents a power up that will fall from up to down. When it collides
    with the paddle, 2 more balls will spawn and the powerup disappears. 
    When it falls through, it will disappear.
]]

Powerup = Class{}

function Powerup:init(num, x,y)
    -- simple dimensional variables
    self.width = 16
    self.height = 16

    -- simple position variable
    self.x = x
    self.y = y

    -- variable to show and hide powerups
    self.inPlay = true
    self.active = false

    -- this variable is for velocity on y axis
    self.dy = 100
    self.type = num -- 1 is powerup and 2 is key
end

--[[
    Expects an argument with a bounding box, be that a paddle or a brick,
    and returns true if the bounding boxes of this and the argument overlap.
]]
function Powerup:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    self.inPlay = false
    self.active = true
    return true
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt

    if self.y >= VIRTUAL_HEIGHT then
        self.inPlay = false
    end
end

function Powerup:render()
    -- gTexture is our global texture for all blocks
    -- gFrames is a table of quads mapping to each individual powerup in the texture
    if self.inPlay then
        if self.type == 1 then
            love.graphics.draw(gTextures['main'], gFrames['powerups'][7], self.x, self.y)
        elseif self.type == 2 then
            love.graphics.draw(gTextures['main'], gFrames['powerups'][10], self.x, self.y)
        end
    end
end