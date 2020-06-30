/*
	ArmA 3 Fishers Life
	Code written by ArmA 3 Fishers Life Development Team
	@Copyright ArmA 3 Fishers Life (https://www.arma3fisherslife.net)
	YOU ARE NOT ALLOWED TO COPY OR DISTRIBUTE THE CONTENT OF THIS FILE WITHOUT AUTHOR AGREEMENT
	More informations : https://www.bistudio.com/community/game-content-usage-rules
*/

Config_Vehicles_Admin = [
	["A3PL_Drill",["Trailer"]],
	["A3PL_Tanker",["Trailer"]],
	["A3PL_Small_Boat",["Trailer"]],
	["A3PL_Box",["Trailer"]],
	["Jonzie",["Ambulance"]],
	["A3PL_Pierce",["Ladder","Pumper","Heavy_Ladder","Rescue"]],
	["A3PL_BMW",["X5","M3"]],
	["A3PL",["Silverado_PD","Silverado","Silverado_PD_ST","Silverado_FD","Silverado_FD_Brush","911GT2","Charger15","Charger15_PD","Charger15_PD_ST","Charger15_FD","Charger69","VetteZR1","Mailtruck","Gallardo","Cessna172","Lowloader","Mustang","Mustang_PD","Mustang_PD_Slicktop","F150","F150_Marker","F150_Marker_PD","Ram","Wrangler","Charger","E350","Tahoe_FD","Tahoe_PD","Tahoe_PD_Slicktop","Tahoe","CVPI","CVPI_Taxi","CVPI_PD","CVPI_PD_Slicktop","Charger_PD","Charger_PD_Slicktop","P362","P362_TowTruck","P362_Garbage_Truck","Rover","Camaro","RBM","Motorboat","RHIB","Fuel_Van","MiniExcavator","CRX","Challenger_Hellcat","Car_Trailer","Yacht","Yacht_Pirate","Challenger_Hellcat","Gallardo","Suburban","CLS63","Fatboy","1100R","Knucklehead","Monster","Kx","Urus","Cessna172","Goose_Base","Goose_USCG","Jayhawk","Taurus","Taurus_PD","Taurus_PD_ST","Taurus_FD","Raptor","Raptor_PD","Raptor_PD_ST","GMCVandura"]],
	["A3FL",["LCM"]],
	["M",["explorer"]],
	["Heli_Medium01",["H","Luxury_H","Medic_H","Military_H","Veteran_H","Coastguard_H","Sheriff_H"]],
	["C",["Heli_Light_01_civil_F","Van_02_transport_F"]],
	["K",["Scooter_DarkBlue"]]
];
publicVariable "Config_Vehicles_Admin";

Config_Vehicles_Capacity = [
	["A3PL_Fatboy",20],

	["K_Scooter_DarkBlue",25],
	["C_Quadbike_01_F",40],

	["A3PL_VetteZR1",140],
	["A3PL_911GT2",140],
	["A3PL_Gallardo",140],

	["A3PL_Camaro",160],
	["A3PL_Charger69",160],
	["A3PL_Mustang",160],
	["A3PL_Mustang_PD",160],
	["A3PL_Mustang_PD_Slicktop",160],
	["A3PL_BMW_M3",160],
	["A3PL_Challenger_Hellcat",160],
	["A3PL_CLS63",160],

	["A3PL_CRX",180],
	["A3PL_CVPI_Rusty",180],
	["A3PL_CVPI",180],
	["A3PL_CVPI_Taxi",180],
	["A3PL_CVPI_PD",180],
	["A3PL_CVPI_PD_Slicktop",180],
	["A3PL_Charger",180],
	["A3PL_Charger_PD",180],
	["A3PL_Charger_PD_Slicktop",180],
	["A3PL_Charger15",180],
	["A3PL_Charger15_PD",180],
	["A3PL_Charger15_PD_ST",180],
	["A3PL_Charger15_FD",180],
	["A3PL_Monster",180],
	["A3PL_Taurus",180],
	["A3PL_Taurus_PD",180],
	["A3PL_Taurus_PD_ST",180],
	["A3PL_Taurus_FD",180],

	["A3PL_P362",200],
	["A3PL_P362_TowTruck",500],

	["A3PL_Wrangler",240],
	["A3PL_BMW_X5",240],
	["A3PL_Urus",240],
	["A3PL_MailTruck",240],

	["A3PL_Ram",550],
	["A3PL_Rover",550],

	["A3PL_Tahoe",630],
	["A3PL_Tahoe_FD",620],
	["A3PL_Tahoe_PD",620],
	["A3PL_Tahoe_PD_Slicktop",620],
	["A3PL_Raptor",620],
	["A3PL_Raptor_PD",620],
	["A3PL_Raptor_PD_ST",620],
	["A3PL_F150",620],
	["A3PL_F150_Marker",620],

	["A3PL_Suburban",660],
	["C_Van_02_transport_F",660],
	["A3PL_Silverado",660],
	["A3PL_Silverado_PD",660],
	["A3PL_Silverado_PD_ST",660],
	["A3PL_Silverado_FD",660],
	["A3PL_Silverado_FD_Brush",660],
	["A3PL_E350",660],
	["jonzie_ambulance",660],
	["A3PL_GMCVandura",660],

	["A3PL_MiniExcavator",150],

	["A3PL_Pierce_Ladder",800],
	["A3PL_Pierce_Heavy_Ladder",800],
	["A3PL_Pierce_Pumper",400],
	["A3PL_Pierce_Rescue",800],

	["A3PL_Box_Trailer",950],

	["C_Scooter_Transport_01_F",40],
	["A3PL_RHIB",80],
	["A3PL_Motorboat",160],
	["A3PL_Motorboat_Rescue",160],
	["A3PL_RBM",200],
	["A3PL_Patrol",320],
	["A3PL_Yacht",800],

	["Heli_Medium01_H",100],
	["Heli_Medium01_Military_H",100],
	["Heli_Medium01_Veteran_H",100],
	["Heli_Medium01_Luxury_H",100],
	["Heli_Medium01_Medic_H",100],
	["Heli_Medium01_Coastguard_H",100],
	["A3PL_Jayhawk",40],
	["A3PL_Cessna172",60],
	["A3PL_Goose_Base",80],
	["A3PL_Goose_USCG",80]
];
publicVariable "Config_Vehicles_Capacity";

Config_Vehicles_Insurance = [
	["A3PL_Fatboy",4000],

	["K_Scooter_DarkBlue",2000],
	["C_Quadbike_01_F",2000],

	["A3PL_VetteZR1",25000],
	["A3PL_911GT2",25000],
	["A3PL_Gallardo",30000],

	["A3PL_Camaro",22000],
	["A3PL_Charger69",24000],
	["A3PL_Mustang",21000],
	["A3PL_Mustang_PD",16000],
	["A3PL_Mustang_PD_Slicktop",16000],
	["A3PL_BMW_M3",18000],
	["A3PL_Challenger_Hellcat",20000],
	["A3PL_CLS63",17000],

	["A3PL_CRX",8000],
	["A3PL_CVPI_Rusty",2000],
	["A3PL_CVPI",3000],
	["A3PL_CVPI_Taxi",3000],
	["A3PL_CVPI_PD",3000],
	["A3PL_CVPI_PD_Slicktop",3000],
	["A3PL_Taurus",4500],
	["A3PL_Taurus_PD",4500],
	["A3PL_Taurus_PD_ST",4500],
	["A3PL_Taurus_FD",4500],
	["A3PL_Charger",19000],
	["A3PL_Charger_PD",6500],
	["A3PL_Charger_PD_Slicktop",6500],
	["A3PL_Charger15",21000],
	["A3PL_Monster",38000],

	["A3PL_Fuel_Van",10000],
	["A3PL_Car_Trailer",5000],
	["A3PL_Small_Boat_Trailer",5000],
	["A3PL_Lowloader",8000],
	["A3PL_Drill_Trailer",10000],
	["A3PL_Tanker_Trailer",10000],
	["A3PL_MiniExcavator",6500],
	["A3PL_P362_TowTruck",32000],
	["A3PL_P362",26000],
	["A3PL_1100R",6500],
	["A3PL_Knucklehead",6000],
	["A3PL_Kx",6000],

	["A3PL_Wrangler",16000],
	["A3PL_BMW_X5",20000],
	["A3PL_Urus",34000],
	["A3PL_MailTruck",7000],

	["A3PL_Ram",14000],
	["A3PL_Rover",14000],

	["A3PL_Tahoe",15500],
	["A3PL_Tahoe_FD",5000],
	["A3PL_Tahoe_PD",5000],
	["A3PL_Tahoe_PD_Slicktop",5000],
	["A3PL_F150",13500],
	["A3PL_F150_Marker",14000],
	["A3PL_Raptor",15000],
	["A3PL_Raptor_PD",14000],
	["A3PL_Raptor_PD_ST",14000],

	["A3PL_Suburban",14500],
	["C_Van_02_transport_F",18000],
	["A3PL_Silverado",15000],
	["A3PL_Silverado_PD",15000],
	["A3PL_E350",12000],
	["jonzie_ambulance",12000],
	["A3PL_GMCVandura",12000],

	["A3PL_Pierce_Ladder",12000],
	["A3PL_Pierce_Heavy_Ladder",12000],
	["A3PL_Pierce_Pumper",12000],
	["A3PL_Pierce_Rescue",12000],

	["A3PL_Box_Trailer",12000],

	["C_Scooter_Transport_01_F",6000],
	["A3PL_RHIB",8000],
	["A3PL_Motorboat",16000],
	["A3PL_Motorboat_Rescue",5000],
	["A3PL_RBM",5000],
	["A3PL_Patrol",5000],
	["A3FL_LCM",5000],
	["A3PL_Yacht",100000],

	["Heli_Medium01_H",40000],
	["Heli_Medium01_Military_H",40000],
	["Heli_Medium01_Veteran_H",40000],
	["Heli_Medium01_Luxury_H",40000],
	["Heli_Medium01_Medic_H",15000],
	["Heli_Medium01_Coastguard_H",15000],
	["A3PL_Jayhawk",15000],
	["A3PL_Cessna172",60000],
	["A3PL_Goose_Base",80000],
	["A3PL_Goose_USCG",15000]
];
publicVariable "Config_Vehicles_Insurance";

Config_Police_Vehs = [
	"A3PL_Police_Mustang_SE",
	"A3PL_Police_Mustang_Default",
	"A3PL_Engine",
	"A3PL_Ladder",
	"Jonzie_Ambulance",
	"A3PL_CVPI_PD",
	"A3PL_CVPI_PD_Slicktop",
	"A3PL_Pierce_Ladder",
	"A3PL_Pierce_Heavy_Ladder",
	"A3PL_Tahoe_FD",
	"A3PL_Tahoe_PD",
	"A3PL_Tahoe_PD_Slicktop",
	"A3PL_Mustang_PD",
	"A3PL_Mustang_PD_Slicktop",
	"A3PL_Charger_PD",
	"A3PL_Charger_PD_Slicktop",
	"A3PL_Pierce_Pumper",
	"A3PL_P362_TowTruck",
	"A3PL_RBM",
	"A3PL_F150_Marker",
	"A3PL_Silverado_PD",
	"A3PL_VetteZR1_PD",
	"A3PL_E350",
	"A3PL_Pierce_Rescue",
	"A3PL_Raptor_PD",
	"A3PL_Raptor_PD_ST",
	"A3PL_Taurus_PD",
	"A3PL_Taurus_PD_ST",
	"A3PL_Silverado_FD",
	"A3PL_Silverado_FD_Brush",
	"A3PL_Silverado_PD_ST",
	"A3PL_Taurus_FD",
	"A3PL_Charger15_PD",
	"A3PL_Charger15_PD_ST",
	"A3PL_Charger15_FD"
];
publicVariable "Config_Police_Vehs";

Config_Arma_Vehs = [
	"C_Van_02_medevac_F",
	"C_Van_02_service_F",
	"C_Van_02_transport_F",
	"I_C_Van_02_transport_F",
	"C_Van_02_vehicle_F",
	"I_G_Van_02_transport_F",
	"C_IDAP_Van_02_vehicle_F",
	"C_IDAP_Van_02_transport_F",
	"C_Offroad_02_unarmed_white_F",
	"C_Offroad_02_unarmed_red_F",
	"C_Offroad_02_unarmed_orange_F",
	"C_Offroad_02_unarmed_green_F",
	"C_Offroad_02_unarmed_F",
	"C_Offroad_02_unarmed_blue_F",
	"C_Offroad_02_unarmed_black_F"
];
publicVariable "Config_Arma_Vehs";
