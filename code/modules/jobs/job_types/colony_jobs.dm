/*
Colony Director
*/
/datum/job/colony_director
	title = "Colony Director"
	faction = "Colony"
	flag = CAPTAIN
	department_flag = ENGSEC
	total_positions = 1
	spawn_positions = 1
	selection_color = "#ff8668"
	req_admin_notify = TRUE
	minimal_player_age = 0 // 30 after testing

	outfit = /datum/outfit/job/colony_director

/datum/outfit/job/colony_director
	name = "Colony Director"
	jobtype = /datum/job/colony_director

	uniform =  /obj/item/clothing/under/rank/colony_director
	shoes = /obj/item/clothing/shoes/sneakers/brown
	backpack_contents = list(/obj/item/weapon/storage/box/papersack/colonybag=1, /obj/item/weapon/paper/colonyobjectives=1)

/*
Assistant Director
*/

/datum/job/assistant_director
	title = "Assistant Director"
	faction = "Colony"
	flag = HOP
	department_flag = CIVILIAN
	total_positions = 2
	spawn_positions = 2
	supervisors = "the colony director"
	selection_color = "#ffbdad"
	req_admin_notify = TRUE
	minimal_player_age = 0 // 15 after testing

	outfit = /datum/outfit/job/assistant_director

/datum/outfit/job/assistant_director
	name = "Assistant Director"
	jobtype = /datum/job/assistant_director

	uniform = /obj/item/clothing/under/rank/colony_director
	shoes = /obj/item/clothing/shoes/sneakers/brown
	backpack_contents = list(/obj/item/weapon/storage/box/papersack/colonybag=1, /obj/item/weapon/paper/colonyobjectives=1)

/*
Basic Colonist
*/
/datum/job/colonist
	title = "Colonist"
	faction = "Colony"
	flag = ASSISTANT
	department_flag = CIVILIAN
	total_positions = -1
	spawn_positions = -1
	supervisors = "the colony director"
	selection_color = "#dddddd"
	outfit = /datum/outfit/job/colonist

/datum/outfit/job/colonist
  name = "Colonist"
  backpack_contents = list(/obj/item/weapon/storage/box/papersack/colonybag=1, /obj/item/weapon/paper/colonyobjectives=1)
  jobtype = /datum/job/colonist
  uniform = /obj/item/clothing/under/color/random
