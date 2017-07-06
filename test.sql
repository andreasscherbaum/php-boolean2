-- create a test case
DROP TABLE IF EXISTS boolean2_test;
CREATE TABLE boolean2_test (
  id     SERIAL           NOT NULL PRIMARY KEY,
  test   boolean2
);

-- true, false, true, false, true, false
INSERT INTO boolean2_test (test) VALUES ('true');
INSERT INTO boolean2_test (test) VALUES ('false');
INSERT INTO boolean2_test (test) VALUES ('1');
INSERT INTO boolean2_test (test) VALUES ('0');
INSERT INTO boolean2_test (test) VALUES ('yes');
INSERT INTO boolean2_test (test) VALUES ('no');
INSERT INTO boolean2_test (test) VALUES ('y');
INSERT INTO boolean2_test (test) VALUES ('n');
-- this should fail
INSERT INTO boolean2_test (test) VALUES ('blub');
-- the output should be 0/1
SELECT * FROM boolean2_test ORDER BY id;


DROP TABLE IF EXISTS boolean2_test2;
CREATE TABLE boolean2_test2 (
  id         SERIAL           NOT NULL
                              UNIQUE,
  t1         INTEGER          NOT NULL,
  t2         BOOLEAN2         NOT NULL
                              DEFAULT FALSE
);
CREATE INDEX t1_t1 ON boolean2_test2(t1);
CREATE INDEX t1_t2 ON boolean2_test2(t2);

INSERT INTO boolean2_test2 (t1, t2) SELECT *, FALSE FROM generate_series(1,10000);
INSERT INTO boolean2_test2 (t1, t2) SELECT *, TRUE FROM generate_series(1,5000);

-- make sure, PG will try to use the index:
SET enable_seqscan=0;
VACUUM FULL ANALYZE boolean2_test2;

EXPLAIN SELECT COUNT(*) FROM boolean2_test2 WHERE t2='true';
EXPLAIN SELECT COUNT(*) FROM boolean2_test2 WHERE t2='false';
EXPLAIN SELECT COUNT(*) FROM boolean2_test2 WHERE t2='0';
EXPLAIN SELECT COUNT(*) FROM boolean2_test2 WHERE t2='1';
