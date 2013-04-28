class ML.KeyboardControls

  constructor: (@world)->
    @registerEvents()


  registerEvents: ()=>

    $("body").keydown (e)=>
      switch String.fromCharCode(e.keyCode)
        when "W", "w" then @world.player.moveForward()
        when "S", "s" then @world.player.moveBackward()
        when "A", "a" then @world.player.moveLeft()
        when "D", "d" then @world.player.moveRight()


    $("body").keyup (e)=>
      if ["W", "w", "S", "s", "A", "a", "D", "d"].indexOf(String.fromCharCode(e.keyCode)) != -1
        @world.player.stopMovement()
