SELECT site.nom as site, var.nom as variable, EXTRACT(YEAR FROM sme.date_mesure) AS year, COUNT(*) as nb_data

FROM public.datatype dt  
INNER JOIN public.datatype_variable_unite_acbb_dvu dtvu ON dt.id=dtvu.dty_id
INNER JOIN public.variable_acbb_var var ON dtvu.var_id = var.id
INNER JOIN public.valeur_meteo_vme vme ON var.id = vme.id
INNER JOIN public.mesure_meteo_mme mme ON vme.mme_id = mme.mme_id
INNER JOIN public.sequence_meteo_sme sme ON mme.sme_id = sme.sme_id
INNER JOIN public.site_acbb_sit site ON sme.id = site.id
WHERE LOWER(dt.name) = LOWER('Météorologie semi-horaire') --AND LOWER(var.affichage) = LOWER('CO2)
 
--AND site.id IN (1,3) AND EXTRACT(YEAR FROM sft.date_mesure) IN (2014) AND sft.date_mesure BETWEEN '2014-01-01' AND '2014-01-05'

GROUP BY site, variable, year
ORDER BY site, variable, year

