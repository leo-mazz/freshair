initializePlayer = ->
  # https://github.com/turbolinks/turbolinks/issues/157
  radio = new Audio('http://studio.freshair.org.uk:8000/radio')

  ctrl = document.getElementById('audio-control')
  ctrl_txt = document.getElementById('audio-control-txt')
  play_icon = document.getElementById('play-icon')


  ctrl.onclick = ->
    if radio.paused
      radio.play()
      ctrl_txt.innerHTML = 'Pause'
      play_icon.innerHTML = '<i class="fa fa-pause" aria-hidden="true"></i>'
    else
      radio.pause()
      ctrl_txt.innerHTML = 'Play now'
      play_icon.innerHTML = '<i class="fa fa-play" aria-hidden="true"></i>'
    return

$(document).ready(initializePlayer)