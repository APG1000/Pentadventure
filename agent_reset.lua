pos_adventurer = {-32.00, 0.96, -8.00}
adventurer_id = "ac2dcc"


pos_agent = {
    ["Yellow"] = {
        {48.00, 3.05, 18.00}, {48.00, 3.04, 20.00}, {48.00, 3.04, 22.00}, {48.00, 3.03, 24.00}
    },
    ["Blue"] = {
        {-70.00, 1.94, -28.00}, {-70.00, 1.94, -26.00}, {-70.00, 1.94, -24.00}, {-70.00, 1.94, -22.00}
    },
    ["Green"] = {
        {48.00, 2.87, -28.00}, {48.00, 2.87, -26.00}, {48.00, 2.87, -24.00}, {48.00, 2.87, -22.00}
    },
    ["Red"] = {
        {-69.99, 2.95, 17.98}, {-69.99, 2.95, 19.98}, {-69.99, 2.95, 21.98}, {-69.99, 2.95, 23.98}
    }
}

agent_ids = {
    ["Red"] = {
        "d2ed1e", "585557", "abb7a2", "0981f1"
    },
    ["Blue"] = {
        "cd0c82", "e294a7", "7a4d25", "08708e"
    },
    ["Green"] = {
        "3f76e1", "39f89e", "dd1fc0", "f64bf8"
    },
    ["Yellow"] = {
        "963e5e", "c532aa", "a97cf8", "80a9a1"
    }
}

-- Recalls all agent to their spots
function recall()

    for i,agent_id in ipairs(agent_ids["Red"]) 
    do
        if getObjectFromGUID(agent_id) then
            getObjectFromGUID(agent_id).setPositionSmooth(pos_agent["Red"][i])
            getObjectFromGUID(agent_id).setRotationSmooth({0, 0, 0})
            local Time = os.clock() + 0.1
            while os.clock() < Time do coroutine.yield() end
        end
    end

    for i,agent_id in ipairs(agent_ids["Yellow"]) 
    do
        if getObjectFromGUID(agent_id) then
            getObjectFromGUID(agent_id).setPositionSmooth(pos_agent["Yellow"][i])
            getObjectFromGUID(agent_id).setRotationSmooth({0, 0, 0})
            local Time = os.clock() + 0.1
            while os.clock() < Time do coroutine.yield() end
        end
    end

    for i,agent_id in ipairs(agent_ids["Green"]) 
    do
        if getObjectFromGUID(agent_id) then
            getObjectFromGUID(agent_id).setPositionSmooth(pos_agent["Green"][i])
            getObjectFromGUID(agent_id).setRotationSmooth({0, 0, 0})
            local Time = os.clock() + 0.1
            while os.clock() < Time do coroutine.yield() end
        end
    end

    for i,agent_id in ipairs(agent_ids["Blue"]) 
    do
        if getObjectFromGUID(agent_id) then
            getObjectFromGUID(agent_id).setPositionSmooth(pos_agent["Blue"][i])
            getObjectFromGUID(agent_id).setRotationSmooth({0, 0, 0})
            local Time = os.clock() + 0.1
            while os.clock() < Time do coroutine.yield() end
        end
    end

    if getObjectFromGUID(adventurer_id) then
        getObjectFromGUID(adventurer_id).setPositionSmooth(pos_adventurer)
        getObjectFromGUID(adventurer_id).setRotationSmooth({0, 0, 0})
        local Time = os.clock() + 0.1
        while os.clock() < Time do coroutine.yield() end
    end


    return 1
end

-- start recall subrotine
function subroutine() 
    startLuaCoroutine(self, "recall")
end

function activateButton()
        self.createButton({
            click_function = "subroutine",
            function_owner = self,
            rotation = {0, 0, 0},
            label = "RECALL",
            position = {0, 0.2, 0},
            scale = {1.3, 1, 1.3},
            width = 600,
            height = 310,
            font_size = 120
        })
end
    
function onLoad()
        activateButton()
end