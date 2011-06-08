
-- minutes seconds to degrees
DROP FUNCTION IF EXISTS minsec2deg(FLOAT8, FLOAT8, FLOAT8);
CREATE FUNCTION minsec2deg(deg FLOAT8, min FLOAT8, sec FLOAT8) RETURNS FLOAT8 
AS $$
  BEGIN
    RETURN deg + min / 60.0 + sec / 3600;
  END;
$$ LANGUAGE plpgsql;
  
-- degrees to radians
DROP FUNCTION IF EXISTS deg2rad(FLOAT8);
CREATE FUNCTION deg2rad(FLOAT8) RETURNS FLOAT8 
AS $$
  BEGIN
    RETURN $1 * 180.0 / pi();
  END;
$$ LANGUAGE plpgsql;

-- radians to degrees
DROP FUNCTION IF EXISTS rad2deg(FLOAT8);
CREATE FUNCTION rad2deg(FLOAT8) RETURNS FLOAT8 
AS $$
  BEGIN
    RETURN $1 * pi() / 180.0;
  END;
$$ LANGUAGE plpgsql;

-- great circle distance
DROP FUNCTION IF EXISTS gcdistance(FLOAT8, FLOAT8, FLOAT8, FLOAT8);
CREATE FUNCTION gcdistance(lat1 FLOAT8, lon1 FLOAT8, lat2 FLOAT8, lon2 FLOAT8) RETURNS FLOAT8
AS $$
  DECLARE
    earth_radius_km CONSTANT FLOAT8 := 6371.01;
    earth_radius_mi CONSTANT FLOAT8 := 3958.76;
    earth_radius_nm CONSTANT FLOAT8 := 3440.07;
    -- Define R to get distance in units above                                                                                                                                     
    R CONSTANT FLOAT8 := earth_radius_km;
    dlon FLOAT8 := lon2 - lon1;
    dlat FLOAT8 := lat2 - lat1;
    a FLOAT8 := pow(sin(dlat/2.0),2.0) + cos(lat1) * cos(lat2) * pow(sin(dlon/2.0),2.0);
    c FLOAT8 := 2 * asin(least(1.0::FLOAT8,sqrt(a)));
  BEGIN
    RETURN R * c;
  END;
$$ LANGUAGE plpgsql;
