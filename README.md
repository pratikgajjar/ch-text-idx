# Clickhouse FTS

```txt
INNER JOIN
(
    SELECT
        target,
        weight
    FROM edge
    WHERE source = 1
    ORDER BY weight DESC
) AS e ON v.id = e.target
WHERE match(v.label, '^dh| dh')
ORDER BY e.weight DESC

Query id: 78eab480-70f2-4fc0-86d5-cd4fc9d02276

    ┌─explain───────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 1. │ Expression (Project names)                                                                                            │
 2. │   Sorting (Sorting for ORDER BY)                                                                                      │
 3. │     Expression ((Before ORDER BY + (Projection + )))                                                                  │
 4. │       Expression                                                                                                      │
 5. │         Join                                                                                                          │
 6. │           Expression                                                                                                  │
 7. │             ReadFromMergeTree (default.vertex)                                                                        │
 8. │             Indexes:                                                                                                  │
 9. │               PrimaryKey                                                                                              │
10. │                 Condition: true                                                                                       │
11. │                 Parts: 2/2                                                                                            │
12. │                 Granules: 22/22                                                                                       │
13. │               Skip                                                                                                    │
14. │                 Name: vertex_label_text_idx                                                                           │
15. │                 Description: text GRANULARITY 1                                                                       │
16. │                 Parts: 2/2                                                                                            │
17. │                 Granules: 22/22                                                                                       │
18. │           Expression ((Change column names to column identifiers + (Project names + (Before ORDER BY + Projection)))) │
19. │             Expression                                                                                                │
20. │               ReadFromMergeTree (default.edge)                                                                        │
21. │               Indexes:                                                                                                │
22. │                 PrimaryKey                                                                                            │
23. │                   Keys:                                                                                               │
24. │                     source                                                                                            │
25. │                   Condition: (source in [1, 1])                                                                       │
26. │                   Parts: 1/1                                                                                          │
27. │                   Granules: 1/1                                                                                       │
28. │                   Search Algorithm: binary search                                                                     │
    └───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘

28 rows in set. Elapsed: 0.008 sec.

ee6c27a3864a :)

```
