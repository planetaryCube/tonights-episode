/datum/quirk/water_sponge
	name = "Water Sponge"
	desc = "You can hold lots of water in you! Careful with showers!"
	value = 0 //ERP quirk
	gain_text = "<span class='notice'>You feel absorbant.</span>"
	lose_text = "<span class='notice'>You don't feel absorbant anymore.</span>"
	// HEY NERD, PUT IN MEDICAL TEXT IF YOU ADD THIS BACK!
	mob_trait = TRAIT_WATER_SPONGE

/datum/reagent/water
	var/bloat_coeff = 3.5

/datum/reagent/water/on_mob_add(mob/living/living, amount)
	if(HAS_TRAIT(living, TRAIT_WATER_SPONGE))
		if(iscarbon(living))
			var/mob/living/carbon/carbon = living
			carbon.hider_add(src)
	. = ..()

/datum/reagent/water/on_mob_delete(mob/living/living)
	if(HAS_TRAIT(living, TRAIT_WATER_SPONGE))
		if(iscarbon(living))
			var/mob/living/carbon/carbon = living
			carbon.hider_remove(src)
	. = ..()

/datum/reagent/water/expose_atom(atom/exposed_atom, reac_volume, methods)
	. = ..()
	if (!iscarbon(exposed_atom))
		return
	var/mob/living/carbon/carbon = exposed_atom
	if(HAS_TRAIT(carbon, TRAIT_WATER_SPONGE))
		if(methods & TOUCH)
			carbon.reagents.add_reagent(/datum/reagent/water, reac_volume/2)
		if(methods & VAPOR)
			carbon.reagents.add_reagent(/datum/reagent/water, reac_volume/3)


/datum/reagent/water/proc/fat_hide(mob/living/carbon/user)
	return volume * bloat_coeff

/obj/machinery/shower/process()
	..()
	for(var/atom/movable/moveable_atom in loc)
		if(iscarbon(moveable_atom))
			if(HAS_TRAIT(moveable_atom, TRAIT_WATER_SPONGE))
				var/mob/living/carbon/living = moveable_atom
				living.reagents.add_reagent(/datum/reagent/water, 3)


/obj/item/organ/lungs/proc/consume_water_vapor(mob/living/carbon/breather, datum/gas_mixture/breath, water_vapor_pp, old_water_vapor_pp)
	if(HAS_TRAIT(breather, TRAIT_WATER_SPONGE))
		if(breath)
			var/gas_breathed = breathe_gas_volume(breath, /datum/gas/water_vapor)
			if(gas_breathed > 0)
				breather.reagents.add_reagent(/datum/reagent/water, gas_breathed)

/obj/item/organ/lungs/Initialize(mapload)
	. = ..()
	add_gas_reaction(/datum/gas/water_vapor, while_present = PROC_REF(consume_water_vapor))

/datum/reagent/water/overdose_start(mob/living/M)
	. = 1

/obj/structure/sink
	var/mob/living/attached

/obj/structure/sink/mouse_drop_receive(atom/dropped, mob/user, params)
	if (!iscarbon(dropped) || !isliving(dropped))
		return
	
	if (attached)
		visible_message("<span class='warning'>[attached] is detached from [src].</span>")
		attached = null
		return
	
	usr.visible_message("<span class='warning'>[usr] attaches [dropped] to [src].</span>", "<span class='notice'>You attach [dropped] to [src].</span>")
	add_fingerprint(usr)
	attached = dropped
	START_PROCESSING(SSobj, src)

// /obj/structure/sink/MouseDrop(mob/living/target)
// 	. = ..()
// 	if(!ishuman(usr) || !isliving(target))
// 		return
// 	if(attached)
// 		visible_message("<span class='warning'>[attached] is detached from [src].</span>")
// 		attached = null
// 		return
// 	if(Adjacent(target) && usr.Adjacent(target))
// 		usr.visible_message("<span class='warning'>[usr] attaches [target] to [src].</span>", "<span class='notice'>You attach [target] to [src].</span>")
// 		add_fingerprint(usr)
// 		attached = target
// 		START_PROCESSING(SSobj, src)

/obj/structure/sink/process()
	if(!(get_dist(src, attached) <= 1 && isturf(attached.loc)))
		to_chat(attached, "<span class='userdanger'>[attached] is ripped from the sink!</span>")
		attached = null
		return PROCESS_KILL
	if(attached)
		playsound(attached, 'modular_zubbers/sound/vore/sunesound/pred/swallow_02.ogg', rand(10,50), 1)
		attached.reagents.add_reagent(/datum/reagent/water, 5)
	else
		return PROCESS_KILL

/obj/structure/sink/attack_hand(mob/living/user)
	. = ..()
	if(attached)
		visible_message("[attached] is detached from [src]")
		attached = null
		return

// /obj/machinery/pool/controller/process_reagents()
// 	for(var/turf/open/pool/W in linked_turfs)
// 		for(var/mob/living/carbon/human/swimee in W)
// 			if(HAS_TRAIT(swimee, TRAIT_WATER_SPONGE))
// 				swimee.reagents.add_reagent(/datum/reagent/water, 5)
// 	..()
