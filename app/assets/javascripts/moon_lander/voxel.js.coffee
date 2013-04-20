class ML.Voxel

  constructor: (@color, @size = 5)->
    if !@color?
      @color = {r: 0, g: 0, b: 0}

    return @["#{@color}Color"].apply(@, [@size])


  createObjectFor: (@size, @materials)->
    @geometry = new THREE.CubeGeometry(@size, @size, @size, 3, 3, 3)

    for i in [0...@geometry.faces.length]
      @geometry.faces[i].materialIndex = ML.Utils.randomInt(0, @materials.length - 1)

    object3d = new THREE.Mesh(@geometry, new THREE.MeshFaceMaterial(@materials))
    object3d.name = "voxel"
    return object3d


  whiteColor: (@size)->
    @materials = for color in [0xEBEBEB, 0xF0F0F0, 0xF5F5F5]
      materialOptions = { color: color }
      new THREE.MeshBasicMaterial(materialOptions)

    @createObjectFor(@size, @materials)


  redColor: (@size)->
    @materials = for color in [0xFF0000, 0xFF0000, 0xFF0000]
      materialOptions = { color: color }
      new THREE.MeshBasicMaterial(materialOptions)

    @createObjectFor(@size, @materials)

  greenColor: (@size)->
    @materials = for color in [0x9ED864, 0x80CC33, 0x33CC33]
      materialOptions = { color: color }
      new THREE.MeshBasicMaterial(materialOptions)

    @createObjectFor(@size, @materials)    


  brownColor: (@size)->
    @materials = for color in [0xD0C48A, 0xE5DEBD, 0xDED5AB]
      materialOptions = { color: color }
      new THREE.MeshBasicMaterial(materialOptions)

    @createObjectFor(@size, @materials)