local tileConvert = {}

function tileConvert.pixToTile(x, y)
    return({math.floor(x/MapTileSize), math.floor(y/MapTileSize)})
end

function tileConvert.tileToPix(x, y)
    return({x*MapTileSize, y*MapTileSize})
end

return tileConvert