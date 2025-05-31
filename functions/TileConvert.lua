local TileConvert = {}

function TileConvert.pixToTile(x, y)
    return({math.floor(x/MapTileSize), math.floor(y/MapTileSize)})
end

function TileConvert.tileToPix(x, y)
    return({x*MapTileSize, y*MapTileSize})
end

return TileConvert