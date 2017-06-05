clearMessageStudio = (authorField, contentField, messageInfo)->
  authorField.style.display = 'block'
  contentField.style.display = 'none'
  authorField.value = ''
  contentField.value = ''
  messageInfo.style.display = 'none'

initializeMessageStudio = ->
  message = {}
  messageAuthorField = document.getElementById('message-author')
  messageContentField = document.getElementById('message-content')
  messageInfo = document.getElementById('message-info')

  clearMessageStudio(messageAuthorField, messageContentField, messageInfo)

  messageAuthorField.addEventListener 'keydown', (e) ->
    # If press enter
    if 13 == e.keyCode
      messageAuthorField.style.display = 'none'
      messageContentField.style.display = 'block'
      messageInfo.innerHTML = 'You\'re writing as ' + messageAuthorField.value + '. Press Esc to cancel'
      messageInfo.style.display = 'block'
      messageContentField.focus();
      e.preventDefault()
    return


  messageContentField.addEventListener 'keydown', (e) ->
    # If press enter
    if 13 == e.keyCode
      message.author = messageAuthorField.value
      message.content = messageContentField.value

      today = new Date
      hours = today.getHours()
      minutes = if today.getMinutes() < 10 then '0' + today.getMinutes() else today.getMinutes()
      message.time =  hours + ':' + minutes
      messageContentField.style.display = 'none'
      messageInfo.innerHTML = 'Message sent! Press Esc to start over'
      messageInfo.style.display = 'block'

      request = new XMLHttpRequest
      request.open 'POST', 'https://old.studio.freshair.org.uk/api/messages/submit', true
      request.setRequestHeader 'Content-Type', 'application/json; charset=UTF-8'
      request.send message
      e.preventDefault()
    return

  document.body.addEventListener 'keydown', (e) ->
    # If press Esc
    if 27 == e.keyCode
      clearMessageStudio(messageAuthorField, messageContentField, messageInfo)
      messageAuthorField.focus()
      e.preventDefault()

    return


  return

$(document).ready(initializeMessageStudio);
$(document).on "turbolinks:load", -> initializeMessageStudio()
