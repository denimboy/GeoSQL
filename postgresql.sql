
-- minutes seconds to degrees
DROP FUNCTION IF EXISTS minsec2deg(FLOAT, FLOAT, FLOAT);
CREATE FUNCTION minsec2deg(deg FLOAT, min FLOAT, sec FLOAT) RETURNS FLOAT 
AS $$
  BEGIN
    RETURN deg + min / 60.0 + sec / 3600;
  END;
$$ LANGUAGE plpgsql;
  
-- degrees to radians
DROP FUNCTION IF EXISTS deg2rad(FLOAT);
CREATE FUNCTION deg2rad(FLOAT) RETURNS FLOAT 
AS $$
  BEGIN
    RETURN $1 * 180.0 / pi();
  END;
$$ LANGUAGE plpgsql;

-- radians to degrees
DROP FUNCTION IF EXISTS rad2deg(FLOAT);
CREATE FUNCTION rad2deg(FLOAT) RETURNS FLOAT 
AS $$
  BEGIN
    RETURN $1 * pi() / 180.0;
  END;
$$ LANGUAGE plpgsql;

-- great circle distance
DROP FUNCTION IF EXISTS gcdistance(FLOAT, FLOAT, FLOAT, FLOAT);
CREATE FUNCTION gcdistace(lat1 FLOAT, lon1 FLOAT, lat1 FLOAT, lon1 FLOAT) RETURNS FLOAT 
AS $$
  DECLARE 
    earth_radius_km CONSTANT FLOAT := 6371.01;
    earth_radius_mi CONSTANT FLOAT := 3958.76;
    earth_radius_nm CONSTANT FLOAT := 3440.07;
    -- Define R to get distance in units above
    R CONSTANT FLOAT := earth_radius_km;
    dlon FLOAT := lon2 - lon1;
    dlat FLOAT := lat2 - lat1;
    a FLOAT := pow(sin(dlat/2),2) + cos(lat1) * cos(lat2) * pow(sin(dlon/2),2);
    c FLOAT := 2 * arcsin(min(1,sqrt(a)));
  BEGIN
    RETURN R * c;
  END;
$$ LANGUAGE plpgsql;
