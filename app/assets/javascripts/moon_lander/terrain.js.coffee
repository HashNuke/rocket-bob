class ML.Terrain

  constructor: (@world)->
    materials = for color in [0xEBEBEB, 0xF0F0F0, 0xF5F5F5]
      materialOptions = { color: color }
      new THREE.MeshBasicMaterial(materialOptions)
    geometry = new THREE.PlaneGeometry(50, 50, 50, 50)

    for i in [0...geometry.faces.length]
      geometry.faces[i].materialIndex = ML.Utils.randomInt(0, materials.length - 1)

    object3d = new THREE.Mesh(geometry, new THREE.MeshFaceMaterial(materials))
    object3d.rotation.x = -Math.PI/2
    object3d.position = {x: 0, y: 0, z: 0}
    @world.scene.add object3d
