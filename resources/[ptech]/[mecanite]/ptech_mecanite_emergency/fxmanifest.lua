fx_version 'cerulean'
game 'gta5'

author 'P-Tech adaptation; original model by SAS994 & ShaoyeBen and credited contributors'
description 'P-Tech Mecanite Emergency: EMS Blazer Aqua and low-impact water mooring assist'
version '0.1.0'

files {
    'data/vehicles.meta',
    'data/handling.meta',
    'data/carcols.meta',
    'data/carvariations.meta',
    'data/vehiclelayouts.meta',
    'data/mecanite_emergency_blazer_game.dat151.rel'
}

data_file 'VEHICLE_LAYOUTS_FILE' 'data/vehiclelayouts.meta'
data_file 'HANDLING_FILE' 'data/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'data/vehicles.meta'
data_file 'CARCOLS_FILE' 'data/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'data/carvariations.meta'
data_file 'AUDIO_GAMEDATA' 'data/mecanite_emergency_blazer_game.dat'

client_scripts {
    'config/config.lua',
    'main/client/weapon_safety.lua',
    'main/client/mooring.lua'
}
