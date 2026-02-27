/// Handles weight gain from vore.
/obj/vore_belly/proc/handle_vore_weight_gain(mob/living/pred, mob/living/prey)
	if(!istype(pred))
		return FALSE

	var/prey_weight_value = prey.digestion_fat_yield
	var/mob/living/carbon/carbon_prey = prey
	if(istype(carbon_prey))
		prey_weight_value = carbon_prey.fatness_real //Use actual fatness if it's present

	if(prey_weight_value < 1) // Too low calorie.
		return FALSE

	return pred.handle_weight_from_vore(prey_weight_value, prey, TRUE)

/// How is the weight from vore added to the pred?
/mob/living/proc/handle_weight_from_vore(weight_gain_amount, mob/living/prey, prey_digested = FALSE, modifier = FATNESS_FROM_VORE)
	return FALSE

/mob/living/carbon/handle_weight_from_vore(weight_gain_amount, mob/living/prey, prey_digested = FALSE, modifier = FATNESS_FROM_VORE)
	if(!weight_gain_amount)
		return FALSE

	adjust_fatness(weight_gain_amount * modifier, FATTENING_TYPE_FOOD)
	if(prey_digested && iscarbon(prey))
		carbons_digested += 1

	return TRUE
