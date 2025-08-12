# ratatouille (development version)

# ratatouille 1.0.0
- Add `ratatouille()`, a function to fetch all available invasive species data 
from RATO in a single function call. (#36)
- All functions will now retry failed requests, when fetching objects from RATO 
`ratatouille()` will throttle after 1000 outstanding requests. (#36, #37)
- Add package wide options `ratatouille.rato_expires_minutes`, default 5 minutes
and `ratatouille.cache_max_age_secs`, default 150 seconds. To allow easy
modification of the cache behaviour. (#36)
