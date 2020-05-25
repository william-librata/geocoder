DROP TABLE IF EXISTS address;

SELECT ad.address_detail_pid, ad.date_created, ad.date_last_modified,
	ad.date_retired, ad.building_name,
	ad.lot_number_prefix, ad.lot_number, ad.lot_number_suffix,
	concat(ad.lot_number_prefix, ad.lot_number, ad.lot_number_suffix) AS lot_number_combined,
	ad.flat_type_code, ad.flat_number_prefix, ad.flat_number, ad.flat_number_suffix,
	concat(ad.flat_number_prefix, ad.flat_number, ad.flat_number_suffix) AS  flat_number_combined,
	ad.level_type_code, ad.level_number_prefix, ad.level_number, ad.level_number_suffix,
	concat(ad.level_number_prefix, ad.level_number, ad.level_number_suffix) AS level_number_combined,
	ad.number_first_prefix, ad.number_first, ad.number_first_suffix,
	concat(ad.number_first_prefix, ad.number_first, ad.number_first_suffix) AS number_first_combined,
	ad.number_last_prefix, ad.number_last, ad.number_last_suffix,
	concat(ad.number_last_prefix, ad.number_last, ad.number_last_suffix) AS number_last_combined,
    concat(
        concat(ad.number_first_prefix, ad.number_first, ad.number_first_suffix),
        CASE WHEN ad.number_last IS NOT NULL
            THEN '-'
            ELSE NULL END,
        CASE WHEN ad.number_last IS NOT NULL
            THEN concat(ad.number_last_prefix, ad.number_last, ad.number_last_suffix)
            ELSE NULL END
        ) AS house_number,
	ad.street_locality_pid, sl.street_name, sta.name AS street_type,
	sl.street_suffix_code, ssa.name AS street_suffix_name,
	concat(
	    sl.street_name,
	    CASE WHEN sta.name IS NOT NULL
	        THEN ' '
	        ELSE NULL END,
	    sta.name,
	    CASE WHEN ssa.name IS NOT NULL
	        THEN ' '
	        ELSE NULL END,
        ssa.name) AS street,
	ad.locality_pid, l.locality_name, s.state_abbreviation AS state,
	ad.alias_principal, ad.postcode, ad.confidence, ad.address_site_pid,
	ata.name AS address_type_name, asi.address_site_name,
	ad.level_geocoded_code, ad.primary_secondary
INTO address
FROM address_detail ad
LEFT JOIN street_locality sl
	ON ad.street_locality_pid = sl.street_locality_pid
LEFT JOIN street_type_aut sta
	ON sl.street_type_code = sta.code
LEFT JOIN street_suffix_aut ssa
	ON sl.street_suffix_code = ssa.code
LEFT JOIN locality l
	ON ad.locality_pid = l.locality_pid
LEFT JOIN state s
	ON l.state_pid = s.state_pid
LEFT JOIN address_site asi
    ON ad.address_site_pid = asi.address_site_pid
LEFT JOIN address_type_aut ata
	ON asi.address_type = ata.code;

ALTER TABLE address ADD CONSTRAINT pk_address PRIMARY KEY (address_detail_pid);
CREATE INDEX ix_address_covering_index_01 ON address (house_number, street, locality_name, state, postcode, flat_number, level_number, lot_number);
CREATE INDEX ix_address_covering_index_02 ON address (house_number, street, locality_name, postcode, flat_number, level_number, lot_number);
CREATE INDEX ix_address_covering_index_03 ON address (house_number, street, postcode, flat_number, level_number, lot_number);
CREATE INDEX ix_address_covering_index_21 ON address (house_number, locality_name, state, postcode, flat_number, level_number, lot_number);

