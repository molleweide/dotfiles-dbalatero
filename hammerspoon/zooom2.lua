local Resizer = {}

local dragTypes = {
  move = 1,
  resize = 2,
}

local function createResizeCanvas()
  local canvas = hs.canvas.new{}

  canvas:insertElement(
    {
      id = 'opaque_layer',
      action = 'fill',
      type = 'rectangle',
      fillColor = { red = 0, green = 0, blue = 0, alpha = 0.3 },
      roundedRectRadii = { xRadius = 5.0, yRadius = 5.0 },
    },
    1
  )

  return canvas
end

local function getWindowUnderMouse()
  -- Invoke `hs.application` because `hs.window.orderedWindows()` doesn't do it
  -- and breaks itself
  local _ = hs.application

  local my_pos = hs.geometry.new(hs.mouse.absolutePosition())
  local my_screen = hs.mouse.getCurrentScreen()

  return hs.fnutils.find(hs.window.orderedWindows(), function(w)
    return my_screen == w:screen() and my_pos:inside(w:frame())
  end)
end

-- Usage:
--   resizer = Resizer:new({
--     moveModifiers = {'cmd', 'shift'},
--     resizeModifiers = {'ctrl', 'shift'}
--   })
--
function Resizer:new(options)
  options = options or {}

  local resizer = {
    dragging = false,
    dragType = nil,
    moveModifiers = options.moveModifiers or {'cmd', 'shift'},
    resizeCanvas = createResizeCanvas(),
    resizeModifiers = options.resizeModifiers or {'ctrl', 'shift'},
    targetWindow = nil,
  }

  setmetatable(resizer, self)
  self.__index = self

  resizer.clickHandler = hs.eventtap.new(
    { hs.eventtap.event.types.leftMouseDown },
    resizer:handleClick()
  )

  resizer.cancelHandler = hs.eventtap.new(
    { hs.eventtap.event.types.leftMouseUp },
    resizer:handleCancel()
  )

  resizer.dragHandler = hs.eventtap.new(
    { hs.eventtap.event.types.leftMouseDragged },
    resizer:handleDrag()
  )

  resizer.clickHandler:start()

  return resizer
end

function Resizer:stop()
  self.dragging = false
  self.dragType = nil

  self.resizeCanvas:hide()
  self.cancelHandler:stop()
  self.dragHandler:stop()
  self.clickHandler:start()
end

function Resizer:isResizing()
  return self.dragType == dragTypes.resize
end

function Resizer:isMoving()
  return self.dragType == dragTypes.move
end

function Resizer:handleDrag()
  return function(event)
    if not self.dragging then return nil end

    local dx = event:getProperty(hs.eventtap.event.properties.mouseEventDeltaX)
    local dy = event:getProperty(hs.eventtap.event.properties.mouseEventDeltaY)

    if self:isMoving() then
      self.targetWindow:move({dx, dy}, nil, false, 0)
      return true
    elseif self:isResizing() then
      local currentSize = self.resizeCanvas:size()

      self.resizeCanvas:size({
        w = currentSize.w + dx,
        h = currentSize.h + dy
      })

      return true
    else
      return nil
    end
  end
end

function Resizer:handleCancel()
  return function()
    if not self.dragging then return end

    if self:isResizing() then
      self:resizeWindowToCanvas()
    end

    self:stop()
  end
end

function Resizer:resizeCanvasToWindow()
  local position = self.targetWindow:topLeft()
  local size = self.targetWindow:size()

  self.resizeCanvas:topLeft({ x = position.x, y = position.y })
  self.resizeCanvas:size({ w = size.w, h = size.h })
end

function Resizer:resizeWindowToCanvas()
  if not self.targetWindow then return end
  if not self.resizeCanvas then return end

  local size = self.resizeCanvas:size()
  self.targetWindow:setSize(size.w, size.h)
end

function Resizer:handleClick()
  return function(event)
    if self.dragging then return true end

    local flags = event:getFlags()

    local isMoving = flags:containExactly(self.moveModifiers)
    local isResizing = flags:containExactly(self.resizeModifiers)

    if isMoving or isResizing then
      self.dragging = true
      self.targetWindow = getWindowUnderMouse()

      if isMoving then
        self.dragType = dragTypes.move
      else
        self.dragType = dragTypes.resize

        self:resizeCanvasToWindow()
        self.resizeCanvas:show()
      end

      self.cancelHandler:start()
      self.dragHandler:start()
      self.clickHandler:stop()

      -- Prevent selection
      return true
    else
      return nil
    end
  end
end

return Resizer
