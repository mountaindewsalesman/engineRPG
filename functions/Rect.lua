local Rect = {}

function Rect.colliding(rect1, rect2)
    if not rect1 or not rect2 then
        print("Nil rectangle in collision check")
        return false
    end

    --print(rect1.x, rect1.y, rect1.w, rect1.h)
    --print(rect2.x, rect2.y, rect2.w, rect2.h)

    --rect is {x = x, y = y, w = w, h = h}
    if rect1.x < rect2.x + rect2.w and
       rect1.x + rect1.w > rect2.x and
       rect1.y < rect2.y + rect2.h and
       rect1.y + rect1.h > rect2.y then
        return true
    else
        return false
    end

    
end

return Rect