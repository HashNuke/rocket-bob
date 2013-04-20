class ML.Terrain

  constructor: (@world)->
    @map = []
    for i in [-12..12]
      @map[i] = []
      for j in [-6..6]
        @map[i][j] = 1
        voxel = new ML.Voxel("white", 5)
        voxel.position = { x: 0+(i*5), y: 0, z: 0+(j*5) }
        @world.scene.add voxel
