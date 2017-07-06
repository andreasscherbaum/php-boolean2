# php-boolean2
PostgreSQL boolean2 data type for PHP

## Description

If you use pure PHP (no database abstraction layer) with PostgreSQL, you may run into the problem that your BOOLEAN columns are not recognized by PHP but the value is instead returned as a string. So any code like:

```
if (!$boolean)
```

always returns true because the 't' and 'f' are just strings in PHP.

Other programming languages like Perl, Python or Java and even the newer PHP PDO don't have this problem so it's clearly a PHP issue ... but i don't expect this one to be fixed, because this may break a lot existing applications. The column type information is available in the query result information so normally this should not be a big problem.

How to resolve this problem? There are some possibilities, one simple way would be to just use a SMALLINT instead a BOOLEAN but with the disadvantage that you loose the boolean input values. Another way is to create a new BOOLEAN type and change the output to something PHP-compatible. This new type is binary compatible with the existing BOOLEAN type so casts in either way are not a problem.

## Code

The file boolean2.sql contains SQL commands to create the new "boolean2" data type.


## Tests

The file test.sql contains a few tests in order to verify that the new data type is working.
