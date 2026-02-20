# ratatouille (development version)
- ratatouille now also supports fetching management data from the province of 
West Flanders. A new argument `source` was added to the package functions that 
allows switching between RATO `rato` data and West Flanders `wfl` data.
- A new function was added: `query_object_ids()` which allows users to query the
RATO ArcGIS REST API object IDs for a given resource within a source. These 
objects can then be fetched using `get_objects()` (#31)
- `get_default_resource()` lists the default resource (layer or table) for a 
data source. Other resources may be available. This function is called by 
default by other data fetching functions.

# ratatouille 1.0.4
- `ratatouille()` now always returns all records for the specified source. (#53)
- Fixed a bug where the token would expire (not be refreshed) if a query took 
longer than the token expiry time. (#53)
# ratatouille 1.0.3
- Fixed bug where if the RATO ArcGIS REST API returned an error message as part 
of the response object, ratatouille() would fail cryptically if any other parts 
of the query succeeded. (#50)
# ratatouille 1.0.2
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
