--DROP FUNCTION add_stamp();
CREATE FUNCTION add_stamp() RETURNS trigger AS $edit_stamp$
    BEGIN
	  NEW.added_date := now()::timestamp without time zone;
	  RETURN NEW;
    END;
$edit_stamp$ LANGUAGE plpgsql;

CREATE TRIGGER add BEFORE INSERT
   ON public.landsat_metadata FOR EACH ROW
   EXECUTE PROCEDURE public.add_stamp();
