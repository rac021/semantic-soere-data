SELECT var.nom AS variable , EXTRACT(YEAR FROM mms_date) AS year, rootsite.rootzet_code AS site, count(*) as nb_data
FROM public.datatype dt  INNER JOIN public.datatype_unite_variable_foret_vdt dtvu ON dt.id = dtvu.dty_id
INNER JOIN public.variable_foret var ON dtvu.var_id = var.id
INNER JOIN public.valeurs_meteo_sh_vms vms ON var.id = vms.id
INNER JOIN public.mesures_meteo_sh_mms mms ON mms.mms_id = vms.mms_id
INNER JOIN (
WITH RECURSIVE parent_zet( id, parent_id ) 
AS (
  -- get leaf children
  SELECT id, parent_id, code as zet_code, id as rootzet_id, code as rootzet_code
  FROM zones_etude_zet
 -- WHERE id = 2

  UNION ALL

  -- get all parents  
  SELECT p.id, zet.parent_id, zet_code as zet_code, zet.id as rootzet_id, zet.code as rootzet_code
  FROM parent_zet p
  JOIN zones_etude_zet zet
  ON p.parent_id = zet.id
)
SELECT id as zet_id, zet_code, rootzet_id, rootzet_code from parent_zet
WHERE parent_id is null) AS rootsite ON mms.id=rootsite.zet_id
WHERE LOWER(dt.name) = LOWER('meteo sh') --AND LOWER(var.nom) = LOWER(?VARIABLE_SQL)
--AND rootsite.rootzet_id IN (163841) AND EXTRACT(YEAR FROM mfs_date)=2004 AND mfs.mfs_date BETWEEN '2004-01-01' AND '2004-01-05'

GROUP BY site, variable, year
ORDER BY site, variable, year
