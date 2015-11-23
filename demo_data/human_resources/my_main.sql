ALTER SESSION SET NLS_LANGUAGE=American;
ALTER SESSION SET NLS_TERRITORY=America;
-- create tables, sequences and constraint
@@hr_cre.sql
-- populate tables
@@hr_popul.sql
-- create indexes
@@hr_idx.sql
-- create procedural objects
@@hr_code.sql
-- add comments to tables and columns
@@hr_comnt.sql
-- gather schema statistics
@@hr_analz.sql