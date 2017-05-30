require "json"
require 'open-uri'
require 'soda'
require 'nokogiri'
require 'csv'
require 'openssl'


 client = SODA::Client.new({:domain => "XXXX", :username => "XXXX", :password => "XXXX", :app_token => "XXXX"})


OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
doc = Nokogiri::HTML open('XXXX', :http_basic_authentication => ["XXXX", "XXXX"])
out = JSON.parse(doc)

obj = out["chargePoints"]

@rows = []

# dummy input to avoid hitting API during testing
#json = File.read('/var/www/rails_apps/traffic/ev/output.json')
#obj = JSON.parse(json)
#obj =  obj["chargePoints"]


obj.each do |a|
   

	id = a["id"] 
	bayNo = a["bayNo"]
	lat = a["lat"]
	lon = a["lon"]
	bayCount = a["bayCount"]
	chargerType = a["chargerType"]
	lastStatusUpdateTs = a["lastStatusUpdateTs"]
	lastKnownStatus = a["lastKnownStatus"]
	powerOutput = a["powerOutput"]
	socketType = a["socketType"]
	description = a["description"]
	siteName = a["siteName"]
	address1 = a["address1"]
	address2 = a["address2"]
	city = a["city"]
	county = a["county"]
	postcode = a["postcode"]
	inService = a["inService"]
	paygAvailable = a["paygAvailable"]
	showOnMap = a["showOnMap"]
	instructionBeforeStart = a["instructionBeforeStart"]
	instructionToStart = a["instructionToStart"]
	instructionBeforeStop = a["instructionBeforeStop"]
	instructionToStop = a["instructionToStop"]
	tariffDescription = a["tariffDescription"]
	tariffUnit = a["tariffUnit"]
	tariffPrice = a["tariffPrice"] 
	hostNotes = a["hostNotes"]
	connectorStatus = a["connectorStatus"]
	connector1_socketType = connectorStatus["1"]["socketType"]
  	connector1_status = connectorStatus["1"]["status"]
	connector1_lastUpdate = connectorStatus["1"]["lastConnectorStatusUpdateTs"]
	connector1_powerOutput = connectorStatus["1"]["powerOutput"]
if
 connectorStatus["2"] != nil
	connector2_socketType = connectorStatus["2"]["socketType"]
        connector2_status = connectorStatus["2"]["status"]
        connector2_lastUpdate = connectorStatus["2"]["lastConnectorStatusUpdateTs"]
        connector2_powerOutput = connectorStatus["2"]["powerOutput"]

end

if
 connectorStatus["3"] != nil
        connector3_socketType = connectorStatus["3"]["socketType"]
        connector3_status = connectorStatus["3"]["status"]
        connector3_lastUpdate = connectorStatus["3"]["lastConnectorStatusUpdateTs"]
        connector3_powerOutput = connectorStatus["3"]["powerOutput"]

end

if
 connectorStatus["4"] != nil
        connector4_socketType = connectorStatus["4"]["socketType"]
        connector4_status = connectorStatus["4"]["status"]
        connector4_lastUpdate = connectorStatus["4"]["lastConnectorStatusUpdateTs"]
        connector4_powerOutput = connectorStatus["4"]["powerOutput"]
end



 @rows <<  [id,bayNo,lat,lon,bayCount,chargerType,lastStatusUpdateTs,lastKnownStatus,powerOutput,socketType,description,siteName,address1,address2,city,county,postcode,inService,paygAvailable,showOnMap,instructionBeforeStart,instructionToStart,instructionBeforeStop,instructionToStop,tariffDescription,tariffUnit,tariffPrice,hostNotes,connector1_socketType,connector1_status,connector1_lastUpdate,connector1_powerOutput,connector2_socketType,connector2_status,connector2_lastUpdate,connector2_powerOutput,connector3_socketType,connector3_status,connector3_lastUpdate,connector3_powerOutput,connector4_socketType,connector4_status,connector4_lastUpdate,connector4_powerOutput]


end


  update = []
 @rows.each do |x|

# create rows in format that can be uploadd by SODA

     update << {
	"id" => x[0],
	"bay_no" => x[1],
	"lat" => x[2],
	"lon" => x[3],
	"bay_count" => x[4],
	"charger_type" => x[5],
	"last_status_update" => x[6],
	"last_known_status" => x[7],
	"power_output" => x[8],
	"socket_type" => x[9],
	"description" => x[10],
	"site_name" => x[11],
	"address1" => x[12],
	"address2" => x[13],
	"city" => x[14],
	"county" => x[15],
	"postcode" => x[16],
	"in_service" => x[17],
	"payg_available" => x[18],
	"show_on_map" => x[19],
	"instruction_before_start" => x[20],
        "instruction_to_start" => x[21],
        "instruction_before_stop" => x[22],
        "instruction_to_stop" => x[23],
        "tariff_description" => x[24],
        "tariff_unit" => x[25],
        "tariff_price" => x[26],
        "host_notes" => x[27],
	"connector1_socket_type" => x[28],
	"connector1_status" => x[29],
	"connector1_last_update" => x[30],
	"connector1_power_output" => x[31],
	"connector2_socket_type" => x[32],
        "connector2_status" => x[33],
        "connector2_last_update" => x[34],
        "connector2_power_output" => x[35],
	"connector3_socket_type" => x[36],
        "connector3_status" => x[37],
        "connector3_last_update" => x[38],
        "connector3_power_output" => x[39],
	"connector4_socket_type" => x[40],
        "connector4_status" => x[41],
        "connector4_last_update" => x[42],
        "connector4_power_output" => x[43],
	"location_1" => {
	"longitude" => x[3],
	"latitude" => x[2]
    }
} 

end

puts update

#amend dataset IDs to match yours 

# put creates the "snapshot" of latest condition
    
 @response = client.put("XXXX-XXXX", update)


# post updates the historic file with latest conditions appended
#  @response = client.post("xxxx-xxxx", update)
