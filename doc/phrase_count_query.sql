SELECT phrases.text, phrase_counts.count, date(phrase_counts.created_at)
FROM phrase_counts
LEFT JOIN phrases ON phrase_counts.phrase_id = phrases.id
WHERE phrase_counts.page_id = 1
AND phrase_counts.created_at >= "2008-12-01"
;
