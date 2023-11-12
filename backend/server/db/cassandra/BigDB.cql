-- Create a keyspace
CREATE KEYSPACE IF NOT EXISTS rewind WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : '1' };

-- Create a table
CREATE TABLE IF NOT EXISTS rewind.history (
    id UUID PRIMARY KEY,
    userid bigint,
    when timestamp, 
    currency text,
    -- if amount > 0 then  income else outcome
    amount double, 
    partner text,
    type text,
);


-- insert 
INSERT INTO rewind.history (id, userid, when, currency, amount, partner, type) 
    VALUES  (uuid(), 1, '2023-11-01', 'HU', -3000, 'Lidl', 'Food') ;
INSERT INTO rewind.history (id, userid, when, currency, amount, partner, type) 
    VALUES  (uuid(), 1, '2023-10-30', 'HU', 50000, 'Sugar Daddy', '');
INSERT INTO rewind.history (id, userid, when, currency, amount, partner, type) 
    VALUES  (uuid(), 1, '2023-11-01', 'HU', -4000, 'ELTE', 'Other');
