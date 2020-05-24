DROP TABLE IF EXISTS address;

SELECT ad.address_detail_pid, ad.date_created, ad.date_last_modified,
	ad.date_retired, ad.building_name,
	ad.lot_number_prefix, ad.lot_number, ad.lot_number_suffix,
	concat(ad.lot_number_prefix, ad.lot_number, ad.lot_number_suffix) as lot_number_combined,
	ad.flat_type_code, ad.flat_number_prefix, ad.flat_number, ad.flat_number_suffix,
	concat(ad.flat_number_prefix, ad.flat_number, ad.flat_number_suffix) as flat_number_combined,
	ad.level_type_code, ad.level_number_prefix, ad.level_number, ad.level_number_suffix,
	concat(ad.level_number_prefix, ad.level_number, ad.level_number_suffix) as level_number_combined,
	ad.number_first_prefix, ad.number_first, ad.number_first_suffix,
	concat(ad.number_first_prefix, ad.number_first, ad.number_first_suffix) as number_first_combined,
	ad.number_last_prefix, ad.number_last, ad.number_last_suffix,
	concat(ad.number_last_prefix, ad.number_last, ad.number_last_suffix) as number_last_combined,
	ad.street_locality_pid, sl.street_name, sta.name as street_type,
	sl.street_suffix_code, ssa.name as street_suffix_name,
	ad.locality_pid, l.locality_name, s.state_abbreviation as state,
	ad.alias_principal, ad.postcode, ad.confidence, ad.address_site_pid,
	ata.name as address_type_name, asi.address_site_name,
	ad.level_geocoded_code, ad.primary_secondary
INTO address
FROM address_detail ad
LEFT JOIN street_locality sl
	on ad.street_locality_pid = sl.street_locality_pid
LEFT JOIN street_type_aut sta
	on sl.street_type_code = sta.code
LEFT JOIN street_suffix_aut ssa
	on sl.street_suffix_code = ssa.code
LEFT JOIN locality l
	on ad.locality_pid = l.locality_pid
LEFT JOIN state s
	on l.state_pid = s.state_pid
LEFT JOIN address_site asi
	on ad.address_site_pid = asi.address_site_pid
LEFT JOIN address_type_aut ata
	on asi.address_type = ata.code;

