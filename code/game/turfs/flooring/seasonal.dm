var/world_time_season
var/world_time_year
var/world_time_month
var/world_time_day

/proc/setup_season()
	world_time_month = text2num(time2text(world.timeofday, "MM")) 	// get the current month
	switch(world_time_month)
		if(1 to 2)
			world_time_season = "winter"
		if(3 to 5)
			world_time_season = "spring"
		if(6 to 8)
			world_time_season = "summer"
		if(9 to 11)
			world_time_season = "autumn"
		if(12)
			world_time_season = "winter"
	world_time_day = text2num(time2text(world.timeofday, "DD"))
	world_time_year = text2num(time2text(world.timeofday, "YYYY"))

/turf/simulated/floor/outdoors/grass/seasonal
	name = "grass"
	icon = 'icons/seasonal/turf.dmi'
	icon_state = "s-grass"

	icon_edge = 'icons/seasonal/turf_edge.dmi'

	initial_flooring = /decl/flooring/grass/seasonal_grass

	grass_types = list()
	var/static/list/overlays_cache = list()
	var/animal_chance = 0.5
	var/animal_types = list()
	var/tree_chance = 1
	var/tree_types = list()
	var/snow_chance = 10
	var/preset_season = null
	var/skipseason = null
	var/replacement_season = null

/turf/simulated/floor/outdoors/grass/seasonal/Initialize()

	var/ourseason = world_time_season

	if(preset_season)
		if(preset_season == "spring" || "summer" || "autumn" || "winter")
			ourseason = preset_season

	switch(ourseason)
		if("spring")
			tree_types = list(
				/obj/structure/flora/tree/bigtree,
				/obj/structure/flora/tree/jungle_small,
				/obj/structure/flora/tree/jungle
			)
			animal_types = list(
				/mob/living/simple_mob/vore/redpanda = 5,
				/mob/living/simple_mob/vore/sheep = 20,
				/mob/living/simple_mob/vore/rabbit/black = 20,
				/mob/living/simple_mob/vore/rabbit/white = 20,
				/mob/living/simple_mob/vore/rabbit/brown = 20,
				/mob/living/simple_mob/vore/leopardmander = 2,
				/mob/living/simple_mob/vore/horse/big = 10,
				/mob/living/simple_mob/vore/bigdragon/friendly = 1,
				/mob/living/simple_mob/vore/alienanimals/dustjumper = 20,
				/mob/living/simple_mob/vore/bee = 20,
				/mob/living/simple_mob/vore/horse/big = 5,
				/mob/living/simple_mob/vore/wolf = 5,
				/mob/living/simple_mob/vore/wolf/direwolf = 1,
				/mob/living/simple_mob/vore/wolf/direwolf/dog = 1,
				/mob/living/simple_mob/vore/squirrel = 20,
				/mob/living/simple_mob/vore/deer = 10
			)
			grass_types = list(
				/obj/structure/flora/ausbushes/sparsegrass,
				/obj/structure/flora/ausbushes/fullgrass,
				/obj/structure/flora/ausbushes/brflowers,
				/obj/structure/flora/ausbushes/genericbush,
				/obj/structure/flora/ausbushes/lavendergrass,
				/obj/structure/flora/ausbushes/leafybush,
				/obj/structure/flora/ausbushes/ppflowers,
				/obj/structure/flora/ausbushes/sunnybush,
				/obj/structure/flora/ausbushes/ywflowers,
				/obj/structure/flora/mushroom
			)
			if(grass_chance)
				grass_chance = 30
		if("summer")
			tree_types = list(
				/obj/structure/flora/tree/bigtree,
				/obj/structure/flora/tree/jungle_small,
				/obj/structure/flora/tree/jungle
			)
			animal_types = list(
				/mob/living/simple_mob/vore/redpanda = 1,
				/mob/living/simple_mob/vore/sheep = 20,
				/mob/living/simple_mob/vore/rabbit/black = 20,
				/mob/living/simple_mob/vore/rabbit/white = 20,
				/mob/living/simple_mob/vore/rabbit/brown = 20,
				/mob/living/simple_mob/vore/leopardmander = 2,
				/mob/living/simple_mob/vore/horse/big = 10,
				/mob/living/simple_mob/vore/bigdragon/friendly = 1,
				/mob/living/simple_mob/vore/alienanimals/dustjumper = 20,
				/mob/living/simple_mob/vore/bee = 5,
				/mob/living/simple_mob/vore/horse/big = 5,
				/mob/living/simple_mob/vore/pakkun = 2,
				/mob/living/simple_mob/vore/fennix = 1,
				/mob/living/simple_mob/vore/wolf/direwolf/dog = 1,
				/mob/living/simple_mob/animal/passive/bird/parrot = 1,
				/mob/living/simple_mob/vore/squirrel = 20,
				/mob/living/simple_mob/vore/deer = 10
			)
			grass_types = list(
				/obj/structure/flora/ausbushes/sparsegrass,
				/obj/structure/flora/ausbushes/fullgrass
			)

		if("autumn")
			tree_types = list(
				/obj/structure/flora/tree/bigtree
			)

			animal_types = list(
				/mob/living/simple_mob/vore/redpanda = 40,
				/mob/living/simple_mob/vore/redpanda/fae = 2,
				/mob/living/simple_mob/vore/sheep = 20,
				/mob/living/simple_mob/vore/rabbit/black = 20,
				/mob/living/simple_mob/vore/rabbit/white = 20,
				/mob/living/simple_mob/vore/rabbit/brown = 20,
				/mob/living/simple_mob/vore/horse/big = 10,
				/mob/living/simple_mob/vore/alienanimals/dustjumper = 20,
				/mob/living/simple_mob/vore/horse/big = 1,
				/mob/living/simple_mob/vore/wolf = 1,
				/mob/living/simple_mob/vore/wolf/direwolf = 1,
				/mob/living/simple_mob/vore/wolf/direwolf/dog = 1,
				/mob/living/simple_mob/vore/squirrel = 20,
				/mob/living/simple_mob/vore/deer = 10
			)
			grass_types = list(
				/obj/structure/flora/ausbushes/sparsegrass,
				/obj/structure/flora/pumpkin,
				/obj/structure/flora/ausbushes
			)
			if(grass_chance)
				grass_chance = 10
			if(animal_chance)
				animal_chance = 0.25
		if("winter")
			grass_chance = 0
			tree_types = list(
				/obj/structure/flora/tree/dead,
				/obj/structure/flora/tree/pine
			)

			animal_types = list(
				/mob/living/simple_mob/vore/rabbit/white = 40,
				/mob/living/simple_mob/vore/redpanda = 10,
				/mob/living/simple_mob/vore/wolf = 10,
				/mob/living/simple_mob/vore/wolf/direwolf = 1,
				/mob/living/simple_mob/vore/wolf/direwolf/dog = 1,
				/mob/living/simple_mob/vore/otie/friendly = 2,
				/mob/living/simple_mob/vore/otie/friendly/chubby = 1,
				/mob/living/simple_mob/vore/otie/red/friendly = 1,
				/mob/living/simple_mob/vore/otie/red/chubby = 1,
				/mob/living/simple_mob/vore/squirrel = 20,
				/mob/living/simple_mob/vore/deer = 10
			)
			if(prob(snow_chance))
				chill()
				return

			grass_types = list(
				/obj/structure/flora/grass/both,
				/obj/structure/flora/grass/brown,
				/obj/structure/flora/grass/green,
				/obj/structure/flora/bush
			)
			if(grass_chance)
				grass_chance = 1
			if(animal_chance)
				animal_chance = 0.1

	if(tree_chance && prob(tree_chance) && !check_density())
		var/tree_type = pickweight(tree_types)
		new tree_type(src)

	if(animal_chance && prob(animal_chance) && !check_density())
		var/animal_type = pickweight(animal_types)
		new animal_type(src)

	. = ..()

/turf/simulated/floor/outdoors/grass/seasonal/proc/update_desc()

	var/ourseason = world_time_season

	if(preset_season)
		if(preset_season == "spring" || "summer" || "autumn" || "winter")
			ourseason = preset_season

	switch(ourseason)
		if("spring")
			desc = "Lush green grass, flourishing! Little flowers peek out from between the blades here and there!"
		if("summer")
			desc = "Bright green grass, a little dry in the summer heat!"
		if("autumn")
			desc = "Golden grass, it's a little crunchy as it prepares for winter!"
		if("winter")
			desc = "Dry, seemingly dead grass! It's too cold for the grass..."


/turf/simulated/floor/outdoors/grass/seasonal/update_icon(update_neighbors)
	. = ..()
	update_desc()
	var/ourseason = world_time_season

	if(preset_season)
		if(preset_season == "spring" || "summer" || "autumn" || "winter")
			ourseason = preset_season

	else if(skipseason && replacement_season)
		if(ourseason == skipseason)
			if(replacement_season == "spring" || "summer" || "autumn" || "winter")
				ourseason = replacement_season

	switch(ourseason)
		if("spring")
			if(prob(50))
				var/cache_key = "[ourseason]-overlay[rand(1,19)]"
				if(!overlays_cache[cache_key])
					var/image/I = image(icon = src.icon, icon_state = cache_key, layer = ABOVE_TURF_LAYER) // Icon should be abstracted out
					I.plane = TURF_PLANE
					I.color = null
					I.appearance_flags = RESET_COLOR|KEEP_APART|PIXEL_SCALE
					overlays_cache[cache_key] = I
				add_overlay(overlays_cache[cache_key])
		if("summer")
			return
		if("autumn")
			if(prob(33))
				var/cache_key = "[ourseason]-overlay[rand(1,6)]"
				if(!overlays_cache[cache_key])
					var/image/I = image(icon = src.icon, icon_state = cache_key, layer = ABOVE_TURF_LAYER) // Icon should be abstracted out
					I.plane = TURF_PLANE
					I.color = null
					I.appearance_flags = RESET_COLOR|KEEP_APART|PIXEL_SCALE
					overlays_cache[cache_key] = I
				add_overlay(overlays_cache[cache_key])

		if("winter")
			return

/turf/simulated/floor/outdoors/grass/seasonal/notrees
	tree_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/nomobs
	animal_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/notrees_nomobs
	tree_chance = 0
	animal_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/notrees_nomobs_nosnow
	tree_chance = 0
	animal_chance = 0
	snow_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/notrees_nomobs_lowsnow
	tree_chance = 0
	animal_chance = 0
	snow_chance = 1
/turf/simulated/floor/outdoors/grass/seasonal/lowsnow
	snow_chance = 1

/turf/simulated/floor/outdoors/grass/seasonal/dark
	icon_state = "ds-grass"
	edge_blending_priority = 4.01
	initial_flooring = /decl/flooring/grass/seasonal_grass/dark
	tree_chance = 5
/turf/simulated/floor/outdoors/grass/seasonal/dark/notrees
	tree_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/dark/nomobs
	animal_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/dark/notrees_nomobs
	tree_chance = 0
	animal_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/dark/notrees_nomobs_nosnow
	tree_chance = 0
	animal_chance = 0
	snow_chance = 0
/turf/simulated/floor/outdoors/grass/seasonal/dark/notrees_nomobs_lowsnow
	tree_chance = 0
	animal_chance = 0
	snow_chance = 1
/turf/simulated/floor/outdoors/grass/seasonal/dark/lowsnow
	snow_chance = 1

/turf/simulated/floor/water/seasonal/Initialize()
	. = ..()
	switch(world_time_season)
		if("winter")
			if(prob(99))
				ChangeTurf(/turf/simulated/floor/outdoors/ice)

/turf/simulated/floor/water/deep/seasonal/Initialize()
	. = ..()
	switch(world_time_season)
		if("winter")
			if(prob(75))
				ChangeTurf(/turf/simulated/floor/outdoors/ice)

/turf/simulated/floor/outdoors/grass/seasonal/preset/Initialize()
	color = null

	return ..()

/turf/simulated/floor/outdoors/grass/seasonal/preset/spring
	initial_flooring = /decl/flooring/grass/seasonal_grass/spring
	color = "#00ff00"
	preset_season = "spring"

/turf/simulated/floor/outdoors/grass/seasonal/preset/summer
	initial_flooring = /decl/flooring/grass/seasonal_grass/summer
	color = "#007700"
	preset_season = "summer"

/turf/simulated/floor/outdoors/grass/seasonal/preset/autumn
	initial_flooring = /decl/flooring/grass/seasonal_grass/autumn
	color = "#ffae00"
	preset_season = "autumn"

/turf/simulated/floor/outdoors/grass/seasonal/preset/winter
	initial_flooring = /decl/flooring/grass/seasonal_grass/winter
	color = "#0066ff"
	preset_season = "winter"

/turf/simulated/floor/outdoors/grass/seasonal/preset/skipwinter_autumn
	initial_flooring = /decl/flooring/grass/seasonal_grass/skipwinter_autumn
	color = "#ff00c8"
	skipseason = "winter"
	replacement_season = "autumn"
