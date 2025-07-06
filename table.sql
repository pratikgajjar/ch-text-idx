create or replace table edge (
    source UInt64,
    target UInt64,
    weight Float64,
) ENGINE = ReplacingMergeTree()
PRIMARY KEY (source, target)
ORDER BY (source, target, weight);

create table vertex (
    id UInt64,
    label String,
    INDEX vertex_label_text_idx(label) TYPE text(tokenizer = 'default'),
    PRIMARY KEY (id)
) ENGINE = ReplacingMergeTree()
ORDER BY id;

ALTER TABLE vertex (MATERIALIZE INDEX vertex_label_text_idx);

-- Example data
INSERT INTO edge (source, target, weight)
VALUES (1, 2, 1.0),
       (1, 3, 2.0),
       (1, 4, 4.0),
       (2, 3, 2.0),
       (2, 3, 2.0),
       (3, 1, 3.0);

INSERT INTO vertex (id, label)
VALUES (1, 'pratik gajjar'),
       (2, 'vaibhav patel'),
       (3, 'dhruv patel'),
       (4, 'dhruv prajapati'),
       (5, 'daval dhingra'),
       (6, 'dhara patel');

INSERT INTO vertex(id, label) SELECT id, title from hackernews where length(title) > 3 and length(title) < 40;
-- INSERT 1000 vertex
select count(*) from hackernews where length(title) > 3 and length(title) < 40 limit 5;

-- Find match which starts with edge


SELECT * FROM vertex WHERE match(label, '^dh| dh') AND id in (SELECT target FROM edge WHERE source = 1);

EXPLAIN indexes = 1 SELECT * FROM vertex WHERE label like  '%test%';

SELECT v.id, v.label, e.weight
FROM vertex v
JOIN (
    SELECT target, weight
    FROM edge
    WHERE source = 1
    ORDER BY weight DESC
) e ON v.id = e.target
WHERE match(v.label, '^dh| dh')
ORDER BY e.weight DESC;
