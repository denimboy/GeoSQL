
-- minutes seconds to degrees
DROP FUNCTION IF EXISTS minsec2deg(REAL, REAL, REAL);
CREATE FUNCTION minsec2deg(deg REAL, min REAL, sec REAL) RETURNS REAL 
AS $$
  BEGIN
    RETURN deg + min / 60.0 + sec / 3600;
  END;
$$ LANGUAGE plpgsql;
  
-- degrees to radians
DROP FUNCTION IF EXISTS deg2rad(REAL);
CREATE FUNCTION deg2rad(REAL) RETURNS REAL 
AS $$
  BEGIN
    RETURN $1 * 180.0 / pi();
  END;
$$ LANGUAGE plpgsql;

-- radians to degrees
DROP FUNCTION IF EXISTS rad2deg(REAL);
CREATE FUNCTION rad2deg(REAL) RETURNS REAL 
AS $$
  BEGIN
    RETURN $1 * pi() / 180.0;
  END;
$$ LANGUAGE plpgsql;

-- great circle distance
DROP FUNCTION IF EXISTS gcdistance(REAL, REAL, REAL, REAL);
CREATE FUNCTION gcdistance(lat1 REAL, lon1 REAL, lat2 REAL, lon2 REAL) RETURNS REAL
AS $$
  DECLARE
    earth_radius_km CONSTANT REAL := 6371.01;
    earth_radius_mi CONSTANT REAL := 3958.76;
    earth_radius_nm CONSTANT REAL := 3440.07;
    -- Define R to get distance in units above                                                                                                                                     
    R CONSTANT REAL := earth_radius_km;
    dlon REAL := lon2 - lon1;
    dlat REAL := lat2 - lat1;
    a REAL := pow(sin(dlat/2.0),2.0) + cos(lat1) * cos(lat2) * pow(sin(dlon/2.0),2.0);
    c REAL := 2 * asin(least(1.0::REAL,sqrt(a)));
  BEGIN
    RETURN R * c;
  END;
$$ LANGUAGE plpgsql;
