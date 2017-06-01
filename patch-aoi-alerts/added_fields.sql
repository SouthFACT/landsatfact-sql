
ALTER TABLE public.landsat_metadata ADD COLUMN landsat_product_id character varying(50);
ALTER TABLE public.landsat_metadata ADD COLUMN collection_category character varying(15);

ALTER TABLE public.products ADD COLUMN modified_date date;
ALTER TABLE public.products ADD COLUMN added_date date;
