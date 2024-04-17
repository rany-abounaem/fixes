testWindow = nil
button = nil

-- default button movement function
function moveButton()
  oldPos = button:getPosition()
  windowPos = testWindow:getPosition()
  oldPos.x = oldPos.x - 1
  if oldPos.x < windowPos.x + 10 then
    -- if the button reaches end of parent window, reset (jump)
    jump()
  end
  button:setPosition(oldPos)
  button.moveEvent = scheduleEvent(function() moveButton() end, 200)
end

-- initializing client window
function init()
  testWindow = g_ui.displayUI('test')
  testWindow:hide()
  testButton = modules.client_topmenu.addLeftButton('testWindowButton', tr('Test'), '/images/topbuttons/hotkeys', onClickTest)
  button = testWindow:getChildById('button')
  button.moveEvent = scheduleEvent(function() moveButton() end, 200)
end

-- on clicking the top left button for opening the window
function onClickTest()
  testWindow:show()
end

-- when the window should close
function terminate()
  testWindow:hide()
  testWindow = nil
end

-- jump function, called when it's time to reset (end of parent window),
-- or when the button is clicked
function jump()
  local randY = math.random(testWindow:getPosition().y + 20, testWindow:getPosition().y + testWindow:getHeight() - 20)
  oldPos = button:getPosition()
  oldPos.y = randY
  oldPos.x = windowPos.x + testWindow:getWidth() - button:getWidth() - 10
  button:setPosition(oldPos)
end
