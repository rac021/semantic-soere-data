SELECT site.nom::varchar || '_' || COALESCE(tra.nom::varchar,'NA') as site_treatment, var.nom as variable, EXTRACT(YEAR FROM sft.date_mesure) AS year, COUNT(*) as nb_data

FROM public.datatype dt  
INNER JOIN public.datatype_variable_unite_acbb_dvu dtvu ON dt.id=dtvu.dty_id
INNER JOIN public.variable_acbb_var var ON dtvu.var_id = var.id
INNER JOIN public.valeur_flux_tours_vft vft ON var.id = vft.id
INNER JOIN public.mesure_flux_tours_mft mft ON vft.mft_id = mft.mft_id
INNER JOIN public.sequence_flux_tours_sft sft ON mft.sft_id = sft.sft_id
INNER JOIN public.parcelle_par par ON sft.par_id = par.par_id
INNER JOIN public.site_acbb_sit site ON par.sit_id = site.id
LEFT JOIN suivi_parcelle_spa AS spa ON par.par_id = spa.par_id
LEFT JOIN traitement_tra AS tra ON tra.tra_id = spa.tra_id

WHERE LOWER(dt.name) = LOWER('flux tours') --AND LOWER(var.affichage) = LOWER('CO2)
 
--AND site.id IN (1,3) AND EXTRACT(YEAR FROM sft.date_mesure) IN (2014) AND sft.date_mesure BETWEEN '2014-01-01' AND '2014-01-05'

GROUP BY site_treatment, variable, year
ORDER BY site_treatment, variable, year

