## [Unreleased]

* Fixed: `Inflectionable.by_query_value` queries the inflectionals with an
  `EXISTS` subquery instead of a join. A label with several matching
  inflectionals appeared once per match, so `LIMIT`/`OFFSET` (pagination in SQL)
  returned short pages and skipped labels
* a query consisting of wildcards only (blank search) no longer restricts to
  labels with an inflectional
