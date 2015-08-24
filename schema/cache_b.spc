create or replace package cache_b is

	procedure expires;

	procedure last_modified;

	procedure last_scn;

	procedure etag_md5;

	procedure report_by_hour;

end cache_b;
/
