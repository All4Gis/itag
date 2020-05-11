--
-- itag functions
--

--------------------------------  FUNCTIONS -----------------------------------------------

--
-- Create IMMUTABLE unaccent function 
--
CREATE OR REPLACE FUNCTION public.f_unaccent(text) RETURNS text AS
$func$
SELECT public.unaccent('public.unaccent', $1)  -- schema-qualify function and dictionary
$func$  LANGUAGE sql IMMUTABLE;

--
-- Return a transliterated version of input string in lowercase
--
CREATE OR REPLACE FUNCTION normalize(input TEXT, separator text DEFAULT '') 
RETURNS TEXT AS $$
BEGIN
    RETURN translate(lower(public.f_unaccent(input)), ' '',:-\`\´\‘\’_' , separator);
END
$$ LANGUAGE 'plpgsql' IMMUTABLE;

--
-- Return a transliterated version of input string which the first letter of each word
-- is in uppercase and the remaining characters in lowercase
--
CREATE OR REPLACE FUNCTION normalize_initcap(input TEXT, separator text DEFAULT '') 
RETURNS TEXT AS $$
BEGIN
    RETURN translate(initcap(public.f_unaccent(input)), ' '',:-\`\´\‘\’_' , separator);
END
$$ LANGUAGE 'plpgsql' IMMUTABLE;
