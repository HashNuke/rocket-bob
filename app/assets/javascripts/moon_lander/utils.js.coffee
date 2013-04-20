class ML.Utils
  @randomInt: (min, max)->
    Math.floor(Math.random() * (max - min + 1)) + min

  @isIpad: ->
    navigator.userAgent.match(/iPad/i) != null

  @hasWebgl: ->
    try
      if window.WebGLRenderingContext? && document.createElement('canvas').getContext('experimental-webgl')?
        return true
      else
        return false
    catch error
      return false
