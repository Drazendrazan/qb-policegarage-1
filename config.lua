Config = {}

Config.ped = { -- qb-target
  model = `cs_jimmyboston`, -- ped model 
  coords = vector3(458.37, -1022.56, 27.31), -- ped coords
  heading = 30.4, -- ped heading
  label = 'Get Vehicle', -- target label
  icon = 'fas fa-warehouse', -- target icon
  job = 'police', -- job need 
  distance = 1.5 -- target distance use
}
Config.paywith = 'bank' -- pay with (cash or bank)
Config.busmodel = 'pbus' -- the bus name to make sure it not spawn
Config.Vehicleslist = { -- make sure you add the vehicle in the qb-core vehicles shared
    ['police'] = {
        label = 'Ford victoria', -- you can set any label here
        price = 8000, -- price of vehicle
        coords = vector3(456.71, -1024.57, 28.44), -- police coords
        heading = 50.0, -- vehicle heading
        coordsradius = 4, -- for vehicle that block spawn point
    },
    ['pbus'] = {
        label = 'Police Bus',
        price = 0, -- price of vehicle
        coords = vector3(450.87, -1019.8, 28.44), -- bus coords
        heading = 91.38, -- vehicle heading
        coordsradius = 4, -- for vehicle that block spawn point
    },
}
