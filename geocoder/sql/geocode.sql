-- cleanup
DROP FUNCTION IF EXISTS geocode(address);
DROP TYPE IF EXISTS parsed_address;

-- create type
CREATE TYPE parsed_address
AS
(
    address_id VARCHAR,
    house VARCHAR,
    category VARCHAR,
    near VARCHAR,
    house_number VARCHAR,
    road VARCHAR,
    unit VARCHAR,
    level VARCHAR,
    staircase VARCHAR,
    entrance VARCHAR,
    po_box VARCHAR,
    postcode VARCHAR,
    suburb VARCHAR,
    city_district VARCHAR,
    city VARCHAR,
    island VARCHAR,
    state_district VARCHAR,
    state VARCHAR,
    country_region VARCHAR,
    country VARCHAR,
    world_region VARCHAR,
    latitude VARCHAR,
    longitude VARCHAR
);

-- main
CREATE OR REPLACE FUNCTION geocode(parsed_address parsed_address)
    RETURNS parsed_address
AS
$function$
DECLARE
    result parsed_address;

BEGIN
    result = geocode_exact_match(parsed_address);
    RETURN result;

END;
$function$
LANGUAGE plpgsql;

-- exact match
CREATE OR REPLACE FUNCTION geocode_exact_match(parsed_address parsed_address)
    RETURNS parsed_address
AS
BEGIN
    UPDATE pa
    SET
    FROM parsed_address pa
    JOIN
    ;
    RETURN parsed_address;

END;
$function$
LANGUAGE plpgsql;
