@openTab = (evt, tabName) ->
  # Get all elements with class="tabcontent" and hide them
  tabcontent = document.getElementsByClassName('tabcontent')
  i = 0
  while i < tabcontent.length
    tabcontent[i].style.display = 'none'
    i++
  # Get all elements with class="tablinks" and remove the class "active"
  tablinks = document.getElementsByClassName('tablinks')
  i = 0
  while i < tablinks.length
    tablinks[i].className = tablinks[i].className.replace(' selected', '')
    i++
  # Show the current tab, and add an "active" class to the button that opened the tab
  document.getElementById(tabName).style.display = 'block'
  evt.currentTarget.className += ' selected'
  return
