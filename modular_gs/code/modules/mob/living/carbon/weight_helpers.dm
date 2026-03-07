/// Calculates how much fatness_to_calculate would be in pounds.
/mob/living/carbon/proc/calculate_fatness_weight_in_pounds(fatness_to_calculate)
	return round(((fatness_to_calculate*FATNESS_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))

/// Returns the weight of all of the mob's fatness in pounds.
/mob/living/carbon/proc/calculate_total_fatness_weight_in_pounds()
	return round(((fatness*FATNESS_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))	// huff, being bigger really does raise the number on that scale by quite a bit huh~?
	//return round((140 + (fatness*FATNESS_TO_WEIGHT_RATIO))*(size_multiplier**2)*((dna.features["taur"] != "None") ? 2.5: 1))

/// Calculates how much muscle_to_calculate would be in pounds.
/mob/living/carbon/proc/calculate_muscle_weight_in_pounds(muscle_to_calculate)
	return round(((muscle_to_calculate*MUSCLE_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))

/// Returns the weight of all of the mob's muscles in pounds.
/mob/living/carbon/proc/calculate_total_muscle_weight_in_pounds()
	return round(((muscle*MUSCLE_TO_WEIGHT_RATIO)) * (dna.current_body_size ** 2))

/mob/living/carbon/proc/calculate_weight_in_pounds()
	return calculate_total_fatness_weight_in_pounds() + calculate_total_muscle_weight_in_pounds() + (BASE_WEIGHT_VALUE * (dna.current_body_size ** 2))

/// Returns the mob's raw combined weight for muscle and fatness in BFI.
/mob/living/carbon/proc/calculate_total_weight_in_bfi()
	return (muscle * MUSCLE_TO_FATNESS_RATIO) + fatness


/// Return how much fatness 1 fatness would be worth on the parent's body. For example, on someone with 200% sprite size this would return 0.5
/mob/living/carbon/proc/calculate_adjusted_weight_ratio()
	return 1 / (dna.current_body_size ** 2)

/// Get a mob's total weight in fatness adjusted for their body size
/mob/living/carbon/proc/calculate_adjusted_total_weight_in_bfi()
	return (calculate_total_weight_in_bfi() * calculate_adjusted_weight_ratio())
