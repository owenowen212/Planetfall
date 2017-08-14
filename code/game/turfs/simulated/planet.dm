/turf/open/floor/planet
	icon_state = "dirt"
	initial_gas_mix = PLANET_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/planet/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/stack/tile))
		if(!broken && !burnt)
			var/obj/item/stack/tile/W = C
			if(!W.use(1))
				return
			var/turf/open/floor/T = ChangeTurf(W.turf_type)
			if(istype(W, /obj/item/stack/tile/light)) //TODO: get rid of this ugly check somehow
				var/obj/item/stack/tile/light/L = W
				var/turf/open/floor/light/F = T
				F.state = L.state
			playsound(src, 'sound/weapons/genhit.ogg', 50, 1)
	else if(istype(C, /obj/item/weapon/crowbar))
		return
	else if(istype(C, /obj/item/weapon/shovel) && params)
		return
	else
		..()

////////////GRASS///////////////

/turf/open/floor/planet/grass
	icon_state = "grass"
	var/ore_type = /obj/item/weapon/ore/glass
	var/turfverb = "uproot"

/turf/open/floor/planet/grass/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/shovel) && params)
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, 1)
		if(do_after(user, 20, target = src))
			new ore_type(src)
			new ore_type(src) //Make some sand if you shovel grass
			user.visible_message("<span class='notice'>[user] digs up [src].</span>", "<span class='notice'>You [src.turfverb] [src].</span>")
			make_plating()
	else
		..()

/////////////DIRT///////////

/turf/open/floor/planet/dirt

/turf/open/floor/planet/greenerdirt
	icon_state = "greenerdirt"
	var/ore_type = /obj/item/weapon/ore/glass
	var/turfverb = "uproot"

/turf/open/floor/planet/greenerdirt/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/shovel) && params)
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, 1)
		if(do_after(user, 20, target = src))
			new ore_type(src)
			new ore_type(src) //Make some sand if you shovel grass
			user.visible_message("<span class='notice'>[user] digs up [src].</span>", "<span class='notice'>You [src.turfverb] [src].</span>")
			make_plating()
	else
		..()

///////////WOOD////////////

/turf/open/floor/planet/wood
	icon_state = "wood"
	floor_tile = /obj/item/stack/tile/wood
	broken_states = list("wood-broken", "wood-broken2", "wood-broken3", "wood-broken4", "wood-broken5", "wood-broken6", "wood-broken7")

/turf/open/floor/planet/wood/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/screwdriver))
		pry_tile(C, user)
		return
	else if(intact && istype(C, /obj/item/weapon/crowbar))
		return pry_tile(C, user)
	else if(istype(C, /obj/item/stack/tile))
		return
	else
		..()

///////////SAND///////////

/turf/open/floor/planet/sand
	icon_state = "sand"
	var/ore_type = /obj/item/weapon/ore/glass
	var/turfverb = "dig up"

/turf/open/floor/planet/sand/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/shovel) && params)
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, 1)
		if(do_after(user, 20, target = src))
			new ore_type(src)
			new ore_type(src) //Make some sand if you shovel grass
			user.visible_message("<span class='notice'>[user] digs up [src].</span>", "<span class='notice'>You [src.turfverb] [src].</span>")
			make_plating()
	else
		..()

/turf/open/floor/planet/fine_sand
	icon_state = "asteroid"
	var/ore_type = /obj/item/weapon/ore/glass
	var/turfverb = "dig up"

/turf/open/floor/planet/fine_sand/attackby(obj/item/C, mob/user, params)
	if(istype(C, /obj/item/weapon/shovel) && params)
		playsound(src, 'sound/effects/shovel_dig.ogg', 50, 1)
		if(do_after(user, 20, target = src))
			new ore_type(src)
			new ore_type(src) //Make some sand if you shovel grass
			user.visible_message("<span class='notice'>[user] digs up [src].</span>", "<span class='notice'>You [src.turfverb] [src].</span>")
			make_plating()
	else
		..()

//////////WALLS//////////

/turf/closed/wall/planet
	initial_gas_mix = PLANET_DEFAULT_ATMOS

/turf/closed/wall/planet/wood_wall
	name = "wooden wall"
	desc = "A wall with wooden plating. Stiff."
	icon = 'icons/turf/walls/wood_wall.dmi'
	icon_state = "wood"
	sheet_type = /obj/item/stack/sheet/mineral/wood
	hardness = 70
	explosion_block = 0
	canSmoothWith = list(/turf/closed/wall/mineral/wood, /obj/structure/falsewall/wood)

/turf/closed/wall/planet/shuttle
	icon = 'icons/turf/shuttle.dmi'

/turf/closed/wall/planet/indestructible
	explosion_block = 50

/turf/closed/wall/planet/indestructible/acid_act(acidpwr, acid_volume, acid_id)
	return 0

/turf/closed/wall/planet/indestructible/rock
	name = "dense rock"
	desc = "An extremely densely-packed rock, most mining tools or explosives would never get through this."
	icon = 'icons/turf/mining.dmi'
	icon_state = "rock"
