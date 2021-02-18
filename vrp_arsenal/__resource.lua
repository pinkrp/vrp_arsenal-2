resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page "client/html/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client/client.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server/server.lua"
}

files {
	"client/html/mtar21.png",
	"client/html/style.css",
	"client/html/jquery.js",
	"client/html/index.html",
	"client/html/auto.html",
	"client/html/semi.html",
	"client/html/equip.html",
	"client/html/ammo.html",
	"client/html/img/*",


}