--
-- create PHP compatible BOOLEAN type
--


-- drop the data type, if exist
-- this will drop all functions and drop all columns which use this type
DROP TYPE IF EXISTS boolean2 CASCADE;


-- input and output functions
-- we can use already existing internal functions
CREATE FUNCTION boolean2_in(cstring)
   RETURNS boolean2
   AS 'boolin'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolean2_out(boolean2)
   RETURNS cstring
   AS 'int2out'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolean2_recv(internal)
   RETURNS boolean2
   AS 'boolrecv'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolean2_send(boolean2)
   RETURNS bytea
   AS 'boolsend'
   LANGUAGE internal STRICT;

-- create the data type
CREATE TYPE boolean2 (
   input = boolean2_in,
   output = boolean2_out,
   receive = boolean2_recv,
   send = boolean2_send,
   internallength = 1,
   alignment = char,
   storage = plain,
   passedbyvalue
);
COMMENT ON TYPE boolean2 IS 'boolean, ''1''/''0''';


-- since boolean2 is binary compatible with boolean, we can cast
-- in both ways without need for a supporting function
CREATE CAST (boolean2 AS boolean)
    WITHOUT FUNCTION
         AS ASSIGNMENT;
CREATE CAST (boolean AS boolean2)
    WITHOUT FUNCTION
         AS ASSIGNMENT;


-- create casting functions for integer versus boolean2
CREATE FUNCTION int4(boolean2)
   RETURNS int4
   AS 'bool_int4'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolean2(int4)
   RETURNS boolean2
   AS 'int4_bool'
   LANGUAGE internal STRICT;

-- create the casts
CREATE CAST (boolean2 AS int4)
       WITH FUNCTION int4(boolean2)
         AS ASSIGNMENT;
CREATE CAST (int4 AS boolean2)
       WITH FUNCTION boolean2(int4)
         AS ASSIGNMENT;




-- we need some operators and supporting functions
CREATE FUNCTION boollt(boolean2, boolean)
   RETURNS boolean
   AS 'boollt'
   LANGUAGE internal STRICT;
CREATE FUNCTION boollt(boolean, boolean2)
   RETURNS boolean
   AS 'boollt'
   LANGUAGE internal STRICT;
CREATE FUNCTION boollt(boolean2, boolean2)
   RETURNS boolean
   AS 'boollt'
   LANGUAGE internal STRICT;
CREATE OPERATOR < (
    PROCEDURE = boollt,
    LEFTARG = boolean2,
    RIGHTARG = boolean,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
CREATE OPERATOR < (
    PROCEDURE = boollt,
    LEFTARG = boolean,
    RIGHTARG = boolean2,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
CREATE OPERATOR < (
    PROCEDURE = boollt,
    LEFTARG = boolean2,
    RIGHTARG = boolean2,
    COMMUTATOR = >,
    NEGATOR = >=,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE FUNCTION boolle(boolean2, boolean)
   RETURNS boolean
   AS 'boolle'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolle(boolean, boolean2)
   RETURNS boolean
   AS 'boolle'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolle(boolean2, boolean2)
   RETURNS boolean
   AS 'boolle'
   LANGUAGE internal STRICT;
CREATE OPERATOR <= (
    PROCEDURE = boolle,
    LEFTARG = boolean2,
    RIGHTARG = boolean,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
CREATE OPERATOR <= (
    PROCEDURE = boolle,
    LEFTARG = boolean,
    RIGHTARG = boolean2,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);
CREATE OPERATOR <= (
    PROCEDURE = boolle,
    LEFTARG = boolean2,
    RIGHTARG = boolean2,
    COMMUTATOR = >=,
    NEGATOR = >,
    RESTRICT = scalarltsel,
    JOIN = scalarltjoinsel
);

CREATE FUNCTION boolne(boolean2, boolean)
   RETURNS boolean
   AS 'boolne'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolne(boolean, boolean2)
   RETURNS boolean
   AS 'boolne'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolne(boolean2, boolean2)
   RETURNS boolean
   AS 'boolne'
   LANGUAGE internal STRICT;
CREATE OPERATOR <> (
    PROCEDURE = boolne,
    LEFTARG = boolean2,
    RIGHTARG = boolean,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);
CREATE OPERATOR <> (
    PROCEDURE = boolne,
    LEFTARG = boolean,
    RIGHTARG = boolean2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);
CREATE OPERATOR <> (
    PROCEDURE = boolne,
    LEFTARG = boolean2,
    RIGHTARG = boolean2,
    COMMUTATOR = <>,
    NEGATOR = =,
    RESTRICT = neqsel,
    JOIN = neqjoinsel
);

CREATE FUNCTION booleq(boolean2, boolean)
   RETURNS boolean
   AS 'booleq'
   LANGUAGE internal STRICT;
CREATE FUNCTION booleq(boolean, boolean2)
   RETURNS boolean
   AS 'booleq'
   LANGUAGE internal STRICT;
CREATE FUNCTION booleq(boolean2, boolean2)
   RETURNS boolean
   AS 'booleq'
   LANGUAGE internal STRICT;
CREATE OPERATOR = (
    PROCEDURE = booleq,
    LEFTARG = boolean2,
    RIGHTARG = boolean,
    COMMUTATOR = =,
    NEGATOR = <>,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    SORT1 = <,
    SORT2 = <,
    LTCMP = <,
    GTCMP = >
);
CREATE OPERATOR = (
    PROCEDURE = booleq,
    LEFTARG = boolean,
    RIGHTARG = boolean2,
    COMMUTATOR = =,
    NEGATOR = <>,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    SORT1 = <,
    SORT2 = <,
    LTCMP = <,
    GTCMP = >
);
CREATE OPERATOR = (
    PROCEDURE = booleq,
    LEFTARG = boolean2,
    RIGHTARG = boolean2,
    COMMUTATOR = =,
    NEGATOR = <>,
    HASHES,
    RESTRICT = eqsel,
    JOIN = eqjoinsel,
    SORT1 = <,
    SORT2 = <,
    LTCMP = <,
    GTCMP = >
);

CREATE FUNCTION boolgt(boolean2, boolean)
   RETURNS boolean
   AS 'boolgt'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolgt(boolean, boolean2)
   RETURNS boolean
   AS 'boolgt'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolgt(boolean2, boolean2)
   RETURNS boolean
   AS 'boolgt'
   LANGUAGE internal STRICT;
CREATE OPERATOR > (
    PROCEDURE = boolgt,
    LEFTARG = boolean2,
    RIGHTARG = boolean,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
CREATE OPERATOR > (
    PROCEDURE = boolgt,
    LEFTARG = boolean,
    RIGHTARG = boolean2,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
CREATE OPERATOR > (
    PROCEDURE = boolgt,
    LEFTARG = boolean2,
    RIGHTARG = boolean2,
    COMMUTATOR = <,
    NEGATOR = <=,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);

CREATE FUNCTION boolge(boolean2, boolean)
   RETURNS boolean
   AS 'boolge'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolge(boolean, boolean2)
   RETURNS boolean
   AS 'boolge'
   LANGUAGE internal STRICT;
CREATE FUNCTION boolge(boolean2, boolean2)
   RETURNS boolean
   AS 'boolge'
   LANGUAGE internal STRICT;
CREATE OPERATOR >= (
    PROCEDURE = boolge,
    LEFTARG = boolean2,
    RIGHTARG = boolean,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
CREATE OPERATOR >= (
    PROCEDURE = boolge,
    LEFTARG = boolean,
    RIGHTARG = boolean2,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
CREATE OPERATOR >= (
    PROCEDURE = boolge,
    LEFTARG = boolean2,
    RIGHTARG = boolean2,
    COMMUTATOR = <=,
    NEGATOR = <,
    RESTRICT = scalargtsel,
    JOIN = scalargtjoinsel
);
-- end defining operators


-- create functions supporting operator classes
CREATE FUNCTION btboolcmp(boolean2, boolean)
   RETURNS int4
   AS 'btboolcmp'
   LANGUAGE internal STRICT;
CREATE FUNCTION btboolcmp(boolean, boolean2)
   RETURNS int4
   AS 'btboolcmp'
   LANGUAGE internal STRICT;
CREATE FUNCTION btboolcmp(boolean2, boolean2)
   RETURNS int4
   AS 'btboolcmp'
   LANGUAGE internal STRICT;


-- create operator classes, needed for index support
CREATE OPERATOR CLASS _bool2_ops
    DEFAULT FOR TYPE boolean2[] USING gin AS
    STORAGE boolean2 ,
    OPERATOR 1 &&(anyarray,anyarray) ,
    OPERATOR 2 @>(anyarray,anyarray) ,
    OPERATOR 3 <@(anyarray,anyarray) RECHECK ,
    OPERATOR 4 =(anyarray,anyarray) RECHECK ,
    FUNCTION 1 btboolcmp(boolean2,boolean2) ,
    FUNCTION 2 ginarrayextract(anyarray,internal) ,
    FUNCTION 3 ginarrayextract(anyarray,internal) ,
    FUNCTION 4 ginarrayconsistent(internal,smallint,internal);

CREATE OPERATOR CLASS bool2_ops
    DEFAULT FOR TYPE boolean2 USING btree AS
    OPERATOR 1 <(boolean2,boolean2) ,
    OPERATOR 2 <=(boolean2,boolean2) ,
    OPERATOR 3 =(boolean2,boolean2) ,
    OPERATOR 4 >=(boolean2,boolean2) ,
    OPERATOR 5 >(boolean2,boolean2) ,
    FUNCTION 1 btboolcmp(boolean2,boolean2);

CREATE OPERATOR CLASS bool2_ops
    DEFAULT FOR TYPE boolean2 USING hash AS
    OPERATOR 1 =(boolean2,boolean2) ,
    FUNCTION 1 hashchar("char");
