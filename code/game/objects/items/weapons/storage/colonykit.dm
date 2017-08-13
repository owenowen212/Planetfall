/* Basic survival kits for colonists to spawn with in either bags or boxes

Contents:

Standard survival bag

*/

//Standard Colony bag

/obj/item/weapon/storage/box/papersack/colonybag
  name = "colonist's kit"
  desc = "A standard issue colonist kit for new colonists"

/obj/item/weapon/storage/box/papersack/colonybag/PopulateContents()
  new /obj/item/weapon/paper/guides/for_colonists(src)
  new /obj/item/weapon/reagent_containers/food/snacks/grown/apple(src)
  new /obj/item/weapon/reagent_containers/food/snacks/grown/banana(src)
  new /obj/item/weapon/reagent_containers/food/snacks/candy(src)
