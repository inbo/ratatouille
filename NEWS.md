# ratatouille (development version)
- Fixed bug where errors from the RATO ArcGIS REST API were not properly 
returned as R errors, but instead caused a cryptic error without any 
informative message. (#46)
# ratatouille 1.0.1
- `magrittr` is no longer a direct dependency, the package now uses base pipes 
`|>` internally. (#41)
- The RATO REST API capacity can now be set with an `options()` or by setting 
the environmental variable `RATO_API_CAPACITY`. (#43)
# ratatouille 1.0.0
- Add `ratatouille()`, a function to fetch all available invasive species data 
from RATO in a single function call. (#36)
- All functions will now retry failed requests, when fetching objects from RATO 
`ratatouille()` will throttle after 1000 outstanding requests. (#36, #37)
- Add package wide options `ratatouille.rato_expires_minutes`, default 5 minutes
and `ratatouille.cache_max_age_secs`, default 150 seconds. To allow easy
modification of the cache behaviour. (#36)
