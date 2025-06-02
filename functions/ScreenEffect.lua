local ScreenEffect = {}

ScreenEffect.currentEffects = {}
--each has a {type = "transition", timeActive = { += dt every frame }, duration}
ScreenEffect.dtMult = 1

function ScreenEffect:addEffect(effectType, duration)
    --add a new effect to the current effects
    local effect = {
        type = effectType,
        timeActive = 0,
        duration = duration
    }
    table.insert(ScreenEffect.currentEffects, effect)
end

function ScreenEffect:update(dt)
    ScreenEffect.dtMult = 1

    --update everything
    for i = 1, #ScreenEffect.currentEffects do
        ScreenEffect.currentEffects[i].timeActive = ScreenEffect.currentEffects[i].timeActive + dt
        local effect = ScreenEffect.currentEffects[i]
        if effect.type == "transition" then
            ScreenEffect.dtMult = 0
        end

        --clamp to 1 to ensure that 0 second animations work
        if effect.timeActive >= effect.duration then
            --remove effect
            table.remove(ScreenEffect.currentEffects, i)
            i = i - 1
        end
        
    end
end

function ScreenEffect:draw()
    for i = 1, #ScreenEffect.currentEffects do
        local effect = ScreenEffect.currentEffects[i]

        if effect.type == "transition" then
            local d = effect.duration
            local x = effect.timeActive
            local alpha = (4*x*(d-x))/math.pow(d, 2)
            love.graphics.setColor(0, 0, 0, alpha)
            love.graphics.rectangle("fill", 0, 0, GameWidth, GameHeight)
            love.graphics.setColor(1, 1, 1)
        end
        
    end
end

return ScreenEffect