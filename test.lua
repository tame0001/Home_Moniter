print('test time interval')
tmr.register(0, 500, tmr.ALARM_AUTO, 
    function() 
        print("hey there") 
    end)
-- tmr.start(0)