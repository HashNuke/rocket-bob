class ML.Terrain

  constructor: (@world)->
    @map = []
    for i in [-12..12]
      @map[i] = []
      for j in [-6..6]
        @map[i][j] = 1
        voxel = new ML.Voxel("white", 5, {name: "destination"})
        voxel.position = { x: 0+(i*5), y: @world.basePlatformHeight, z: 0+(j*5) }
        @world.scene.add voxel

        voxel = new ML.Voxel("green", 5)
        voxel.position = { x: 0+(i*5), y: @world.secondPlatformHeight, z: 0+(j*5) }
        @world.scene.add voxel


    for i in [0..40]
      voxel = new ML.Voxel("brown", 5, {name: "debris"})
      ML.Utils.randomInt(-12 * 5, 12 * 5)
      voxel.position =
        x: ML.Utils.randomInt(-12 * 5, 12 * 5)
        y: ML.Utils.randomInt(@world.basePlatformHeight, @world.secondPlatformHeight)
        z: ML.Utils.randomInt(-6 * 5,  6 * 5)
      @world.scene.add voxel
