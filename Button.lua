name = "Text"

boxes = {
    ["Red"] = "2e8a96",
    ["Yellow"] = "6d3a47",
    ["Green"] = "d62c97",
    ["Blue"] = "548984",
}

-- returns the color of the box
function calculateButtonPlace(button_position)
    for color, id in pairs(boxes) 
    do
        box = getObjectFromGUID(id)
        if calculateCollision(box, button_position) then
            return color
        end
    end
    return ""

end

-- calculates if a given box (object) collides with the given button_position (object_position)
-- does not consider collision on the y axis
-- returns true on collision otherwise false
function calculateCollision(box, button_position)
    position = box.getPosition()
    scale = box.getScale()
    x_bot = position[1] - scale[1] / 2
    x_top = position[1] + scale[1] / 2
    z_bot = position[3] - scale[3] / 2
    z_top = position[3] + scale[3] / 2
    return  button_position[1] > x_bot and button_position[1] < x_top and button_position[3] > z_bot and button_position[3] < z_top
end

--Activates when + is hit. Adds 1 to 'count' then updates the display button.
function modify_value(_obj, _color, alt_click)
    local button_color = calculateButtonPlace(self.getPosition())

    -- checks if the owner of the button and adjusts accordingly the message
    local from_player = ""
    local playerActingStr = _color:upper()
    local msgColor = button_color
    if playerActingStr:lower() ~= button_color:lower() then
        from_player = "(from " .. playerActingStr .. ")"
        msgColor = "Pink"
    end

    -- calculates the value
    if alt_click and count > 0 then
        count = count - 1
    elseif not alt_click then
        count = count + 1
    end
    updateDisplay()
    onSave()

    -- broadcasts the message depending on the value
    if count ~= old_count then
        if scheduledInQueue ~= nil then
            Wait.stop(scheduledInQueue)
        end

        scheduledInQueue = Wait.time(function()
        local delta = count - old_count

        if delta < 0 then
            broadcastToAll(("%s spend %d %s %s"):format(button_color, delta, name, from_player), msgColor)
        end
        if delta > 0 then
            broadcastToAll(("%s received %d %s %s"):format(button_color, delta, name, from_player), msgColor)
        end
        old_count = count

        onSave()
    end, 1)
end
end

--Saves the count value into a table (data_to_save) then encodes it into the Tabletop save
    function onSave()
        local data_to_save = {saved_count = count, saved_old_count = old_count}
        saved_data = JSON.encode(data_to_save)
        self.script_state = saved_data
    end
    
    --Loads the saved data then creates the buttons
    function onload(saved_data)
    
        generateButtonParamiters()
        --Checks if there is a saved data. If there is, it gets the saved value for 'count'
        count = 0
        old_count = 0
        if saved_data ~= '' then
            local loaded_data = JSON.decode(saved_data)
            count = loaded_data.saved_count
            old_count = loaded_data.saved_old_count
        end

    --Generates the buttons after putting the count value onto the 'display' button
    b_display.label = tostring(count)
    if count >= 100 then
        b_display.font_size = 360
    else
        b_display.font_size = 500
    end  
    self.createButton(b_display)
end

--function that updates the display. I trigger it whenever I change 'count'
function updateDisplay()
    --If statement to resize font size if it gets too long
    if count >= 100 then
        b_display.font_size = 360
    else
        b_display.font_size = 500
    end
    b_display.label = tostring(count)
    self.editButton(b_display)
end

--This is activated when onload runs. This sets all paramiters for our buttons.
--I do not have to put this all into a function, but I prefer to do it this way.
function generateButtonParamiters()
    b_display = {
        index = 0, click_function = 'modify_value', function_owner = self, label = '',
        position = {0,0.1,0}, width = 600, height = 600, font_size = 500
    }
end