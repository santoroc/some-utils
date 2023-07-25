select distinct
    mv_schema.nspname as materialized_view_schema,
    mv.relname as materialized_view_name,
    dep_schema.nspname as dependent_schema,
    dep_relname.relname as dependent_view_name
from pg_class mv
join pg_namespace mv_schema
    on mv.relnamespace = mv_schema.oid
join pg_depend
    on mv.oid = pg_depend.objid
join pg_class dep_relname
    on pg_depend.refobjid = dep_relname.oid
join pg_namespace dep_schema
    on dep_relname.relnamespace = dep_schema.oid
where 
    mv.relname like '<name-pattern>' -- ex. '%mv' for materialized views
    dep_schema.nspname != mv_schema.nspname
    dep_schema.nspname = '<schema-name>';