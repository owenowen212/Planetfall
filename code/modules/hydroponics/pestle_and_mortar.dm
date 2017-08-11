/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle
	name = "mortar and pestle"
	icon = 'icons/obj/hydroponics/equipment.dmi'
	icon_state = "pestleandmortar"
	item_state = null
	lefthand_file = 'icons/mob/inhands/items_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/items_righthand.dmi'
	var/operating = FALSE
	resistance_flags = ACID_PROOF
	volume = 100
	amount_per_transfer_from_this = 5
	var/limit = 10
	desc = "A device used to grind things."
	w_class = WEIGHT_CLASS_NORMAL


	var/static/list/blend_items = list(
			/obj/item/stack/sheet/mineral/plasma = list("plasma" = 20),
			/obj/item/stack/sheet/metal = list("iron" = 20),
			/obj/item/stack/sheet/plasteel = list("iron" = 20, "plasma" = 20),
			/obj/item/stack/sheet/mineral/wood = list("carbon" = 20),
			/obj/item/stack/sheet/glass = list("silicon" = 20),
			/obj/item/stack/sheet/rglass = list("silicon" = 20, "iron" = 20),
			/obj/item/stack/sheet/mineral/uranium = list("uranium" = 20),
			/obj/item/stack/sheet/mineral/bananium = list("banana" = 20),
			/obj/item/stack/sheet/mineral/silver = list("silver" = 20),
			/obj/item/stack/sheet/mineral/gold = list("gold" = 20),
			/obj/item/stack/sheet/bluespace_crystal = list("bluespace" = 20),
			/obj/item/weapon/ore/bluespace_crystal = list("bluespace" = 20),
			/obj/item/weapon/grown/nettle/basic = list("sacid" = 0),
			/obj/item/weapon/grown/nettle/death = list("facid" = 0, "sacid" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/soybeans = list("soymilk" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/tomato = list("ketchup" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/wheat = list("flour" = -5),
			/obj/item/weapon/reagent_containers/food/snacks/grown/oat = list("flour" = -5),
			/obj/item/weapon/reagent_containers/food/snacks/grown/rice = list("rice" = -5),
			/obj/item/weapon/reagent_containers/food/snacks/donut = list("sprinkles" = -2, "sugar" = 1),
			/obj/item/weapon/reagent_containers/food/snacks/grown/cherries = list("cherryjelly" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/bluecherries = list("bluecherryjelly" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/egg = list("eggyolk" = -5),
			/obj/item/weapon/reagent_containers/food/snacks/grown/coffee/robusta = list("coffeepowder" = 0, "morphine" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/coffee = list("coffeepowder" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/tea/astra = list("teapowder" = 0, "salglu_solution" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/tea = list("teapowder" = 0),
			/obj/item/slime_extract = list(),
			/obj/item/weapon/reagent_containers/pill = list(),
			/obj/item/weapon/reagent_containers/food = list(),
			/obj/item/weapon/reagent_containers/honeycomb = list(),
			/obj/item/toy/crayon = list())

	var/static/list/dried_items = list(
			//Grinder stuff, but only if dry,
			/obj/item/weapon/reagent_containers/food/snacks/grown/coffee/robusta = list("coffeepowder" = 0, "morphine" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/coffee = list("coffeepowder" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/tea/astra = list("teapowder" = 0, "salglu_solution" = 0),
			/obj/item/weapon/reagent_containers/food/snacks/grown/tea = list("teapowder" = 0))

	var/list/holdingitems = list()



/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/attackby(obj/item/I, mob/user, params)
		if(is_type_in_list(I, dried_items))
				if(istype(I, /obj/item/weapon/reagent_containers/food/snacks/grown))
						var/obj/item/weapon/reagent_containers/food/snacks/grown/G = I
						if(!G.dry)
								to_chat(user, "<span class='warning'>You must dry that first!</span>")
								return 1

		if(holdingitems && holdingitems.len >= limit)
				to_chat(user, "The mortar cannot hold any more items.")
				return 1

		//Fill machine with a bag!
		if(istype(I, /obj/item/weapon/storage/bag))
				var/obj/item/weapon/storage/bag/B = I
				for (var/obj/item/weapon/reagent_containers/food/snacks/grown/G in B.contents)
						B.remove_from_storage(G, src)
						holdingitems += G
						if(holdingitems && holdingitems.len >= limit) //Sanity checking so the blender doesn't overfill
								to_chat(user, "<span class='notice'>You fill the mortar to the brim.</span>")
								break

				if(!I.contents.len)
						to_chat(user, "<span class='notice'>You empty the plant bag into the mortar.</span>")

				updateUsrDialog()
				return 1

		if (!is_type_in_list(I, blend_items))
				if(user.a_intent == INTENT_HARM)
						return ..()
				else
						to_chat(user, "<span class='warning'>Cannot refine that into a reagent!</span>")
						return 1

		if(user.drop_item())
				I.loc = src
				holdingitems += I
				src.updateUsrDialog()
				return 0

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/attack_self(mob/user)
	if(!holdingitems.len)
		to_chat(user, "<span class='warning'>There is nothing in the mortar to grind!</span>")
	else
		playsound(src.loc, 'sound/effects/mortar_and_pestle.ogg', 75, 1)
		to_chat(user, "<span class='notice'>You start to grind up the contents of the mortar.</span>")
		if(do_after(user, 50, target = user.loc))
			grind()
			to_chat(user, "<span class='notice'>You grind up the contents of the mortar.</span>")

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/proc/is_allowed(obj/item/weapon/reagent_containers/O)
		for (var/i in blend_items)
				if(istype(O, i))
						return TRUE
		return FALSE

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/proc/get_allowed_by_id(obj/item/O)
		for (var/i in blend_items)
				if (istype(O, i))
						return blend_items[i]

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/proc/get_allowed_snack_by_id(obj/item/weapon/reagent_containers/food/snacks/O)
		for(var/i in blend_items)
				if(istype(O, i))
						return blend_items[i]

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/proc/get_grownweapon_amount(obj/item/weapon/grown/O)
		if (!istype(O) || !O.seed)
				return 5
		else if (O.seed.potency == -1)
				return 5
		else
				return round(O.seed.potency)

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/proc/remove_object(obj/item/O)
	holdingitems -= O
	QDEL_NULL(O)

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/verb/ejectcontents(mob/user)
	var/response = alert(user, "Are you sure you wish to tip the contents out?", "Eject ingredients?", "Yes", "No")
	set name = "Eject ingredients"
	if (user.stat != 0)
		return
	if (holdingitems && holdingitems.len == 0)
		return
	if(response == "Yes")
		for(var/obj/item/O in holdingitems)
			O.loc = get_turf(user.loc)
			holdingitems -= O
		holdingitems = list()
		updateUsrDialog()

//Snacks and Plants
/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/proc/grind()
	for (var/obj/item/weapon/reagent_containers/food/snacks/O in holdingitems)
		if (reagents.total_volume >= reagents.maximum_volume)
			break

		var/allowed = get_allowed_snack_by_id(O)
		if(isnull(allowed))
			break

		for (var/r_id in allowed)

			var/space = reagents.maximum_volume - reagents.total_volume
			var/amount = allowed[r_id]
			if(amount <= 0)
				if(amount == 0)
					if (O.reagents != null && O.reagents.has_reagent("nutriment"))
						reagents.add_reagent(r_id, min(O.reagents.get_reagent_amount("nutriment"), space))
						O.reagents.remove_reagent("nutriment", min(O.reagents.get_reagent_amount("nutriment"), space))
					else
						if (O.reagents != null && O.reagents.has_reagent("nutriment"))
							reagents.add_reagent(r_id, min(round(O.reagents.get_reagent_amount("nutriment")*abs(amount)), space))
							O.reagents.remove_reagent("nutriment", min(O.reagents.get_reagent_amount("nutriment"), space))

				else
					O.reagents.trans_id_to(src, r_id, min(amount, space))

				if (reagents.total_volume >= reagents.maximum_volume)
					break

		if(O.reagents.reagent_list.len == 0)
			remove_object(O)

//Sheets
	for (var/obj/item/stack/sheet/O in holdingitems)
		var/allowed = get_allowed_by_id(O)
		if (reagents.total_volume >= reagents.maximum_volume)
			break
		for(var/i = 1; i <= round(O.amount, 1); i++)
			for (var/r_id in allowed)
				var/space = reagents.maximum_volume - reagents.total_volume
				var/amount = allowed[r_id]
				reagents.add_reagent(r_id,min(amount, space))
				if (space < amount)
					break
				if (i == round(O.amount, 1))
					remove_object(O)
					break

//Plants
	for (var/obj/item/weapon/grown/O in holdingitems)
		if (reagents.total_volume >= reagents.maximum_volume)
			break
		var/allowed = get_allowed_by_id(O)
		for (var/r_id in allowed)
			var/space = reagents.maximum_volume - reagents.total_volume
			var/amount = allowed[r_id]
			if (amount == 0)
				if (O.reagents != null && O.reagents.has_reagent(r_id))
					reagents.add_reagent(r_id,min(O.reagents.get_reagent_amount(r_id), space))
				else
					reagents.add_reagent(r_id,min(amount, space))

				if (reagents.total_volume >= reagents.maximum_volume)
					break
					remove_object(O)

//Slime Extractis
	for (var/obj/item/slime_extract/O in holdingitems)
		if (reagents.total_volume >= reagents.maximum_volume)
			break
		var/space = reagents.maximum_volume - reagents.total_volume
		if (O.reagents != null)
			var/amount = O.reagents.total_volume
			O.reagents.trans_to(src, min(amount, space))
		if (O.Uses > 0)
			reagents.add_reagent("slimejelly", min(20, space))
		remove_object(O)

//Everything else
	for (var/obj/item/weapon/reagent_containers/O in holdingitems)
		if (reagents.total_volume >= reagents.maximum_volume)
			break
		var/amount = O.reagents.total_volume
		O.reagents.trans_to(src, amount)
		if(!O.reagents.total_volume)
			remove_object(O)

	for (var/obj/item/toy/crayon/O in holdingitems)
		if (reagents.total_volume >= reagents.maximum_volume)
			break
		for (var/r_id in O.reagent_contents)
			var/space = reagents.maximum_volume - reagents.total_volume
			if (space == 0)
				break
			reagents.add_reagent(r_id, min(O.reagent_contents[r_id], space))
			remove_object(O)

/obj/item/weapon/reagent_containers/glass/beaker/mortar_and_pestle/update_icon()
	cut_overlays()
	if(reagents.total_volume)
		var/mutable_appearance/filling = mutable_appearance('icons/obj/hydroponics/equipment.dmi', "pestleandmortar_contents")
		filling.color = mix_color_from_reagents(reagents.reagent_list)
		add_overlay(filling)
