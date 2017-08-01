SELECT var.nom AS variable, EXTRACT(YEAR FROM sc.date_prelevement) AS year, site.code AS site, pla.code AS platform 
               FROM public.datatype dt  
               INNER JOIN public.datatypevariableuniteglacpe dtvu 
                           ON dt.id = dtvu.dty_id  
               INNER JOIN public.variable_glacpe_varg var 
                           ON dtvu.var_id = var.id  
               INNER JOIN public.valeur_mesure_chimie_vmchimie vmc 
                           ON var.id = vmc.var_id  
               INNER JOIN public.mesure_chimie_mchimie mc 
                          ON vmc.mchimie_id = mc.mchimie_id
               INNER JOIN sous_sequence_chimie_sschimie ssc 
                             ON mc.sschimie_id = ssc.sschimie_id 	
               INNER JOIN sequence_chimie_schimie sc 
                             ON ssc.schimie_id = sc.schimie_id
               INNER JOIN plateforme_pla pla 
                                   ON ssc.loc_id = pla.loc_id 
               INNER JOIN public.site_glacpe_sit site 
                                   ON pla.id = site.id 
               WHERE LOWER(dt.name) = LOWER('physico chimie')
GROUP BY site,platform, variable, year
ORDER BY site, platform, variable, year
