--DROP FUNCTION add_stamp();
CREATE FUNCTION edit_stamp() RETURNS trigger AS $edit_stamp$
    BEGIN
	  NEW.modified_date := now()::timestamp without time zone;
	  RETURN NEW;
    END;
$edit_stamp$ LANGUAGE plpgsql;


   CREATE TRIGGER edit BEFORE INSERT OR UPDATE
   ON public.landsat_metadata FOR EACH ROW
   EXECUTE PROCEDURE public.edit_stamp();
