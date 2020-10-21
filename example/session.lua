--[[

if ngx.var.request_uri:match("/suproxy/manage/session/kill") then
    local sid=utils.getArgsFromRcequest("sid")
    local uid=utils.getArgsFromRequest("uid")
    if not sid and not uid then 
    elseif sid then 
        result=sessionMan:kill(sid) 
    else
        result=sessionMan:killSessionOfUser(uid)
    end
    ngx.say(result.." items is removed")
elseif ngx.var.request_uri:match("/suproxy/manage/session/get") then
    local sid=utils.getArgsFromRequest("sid")
    local uid=utils.getArgsFromRequest("uid")
    if not sid and not uid then ngx.say("valid sid or uid should be provided") return  end
    local result
    if sid then 
        result=sessionMan:get(sid) 
    else
        result=sessionMan:getSessionOfUser(uid)
        result=cjson.encode(result)
    end
    ngx.say(result)
elseif ngx.var.request_uri:match("/suproxy/manage/session/all") then
    local result,count=sessionMan:getAll()
    ngx.say(cjson.encode(result))
end

