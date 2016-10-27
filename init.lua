print('Connect to wifi')
wifi.setmode(wifi.STATION)
wifi.sta.config("106/113","12345678")
print('Start process')
-- dofile("temp.lua")

-- pin 1 = GPIO5
pin = 1
status, temp, humi, temp_dec, humi_dec = dht.read(pin)
if status == dht.OK then
    -- Float firmware using this example
    print("DHT Temperature:"..temp..";".."Humidity:"..humi)

elseif status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error." )
elseif status == dht.ERROR_TIMEOUT then
    print( "DHT timed out." )
end
-- initiate the mqtt client and set keepalive timer to 120sec
mqtt = mqtt.Client("Node_MCU", 120)

mqtt:on("connect", function(con) print ("connected") end)
mqtt:on("offline", function(con) print ("offline") end)

-- on receive message
mqtt:on("message", function(conn, topic, data)
  print(topic .. ":" )
  if data ~= nil then
    print(data)
  end
end)

mqtt:connect("localhost", 8883, 0, function(conn)
--mqtt:connect("iot.eclipse.org", 1883, 0, function(conn)
  
    print("connected")
    -- while(1)
    -- do
        tmr.register(0,1000, tmr.ALARM_AUTO, function() 
--            print("hey there") 
           -- mqtt:publish("/ThirawatB/temp",temp,0,0)
           -- mqtt:publish("/ThirawatB/humi",humi,0,0)
            status, temp, humi, temp_dec, humi_dec = dht.read(pin)
            print("DHT Temperature:"..temp..";".."Humidity:"..humi)
            mqtt:publish("/ThirawatB/temp",temp,0,0)
            mqtt:publish("/ThirawatB/humi",humi,0,0)
        end)
        tmr.start(0)
--        mqtt:publish("/test",temp,0,0)
--        tmr.delay(1000)
    
    -- end
-- subscribe topic with qos = 0
--  mqtt:subscribe("/test",0, function(conn) 
    -- publish a message with data = my_message, QoS = 0, retain = 0
--    mqtt:publish("/test",temp,0,0)
--    while(1) 
--    do
--        mqtt:publish("/test",temp,0,0)
        -- print("sent")
--        tmr.delay(1000)
--        status, temp, humi, temp_dec, humi_dec = dht.read(pin)
--        print("DHT Temperature:"..temp..";".."Humidity:"..humi)
--    end
--  end)
end)
