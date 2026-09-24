// Central export of iqvoc_inflectionals' own JavaScript, for other
// apps/gems to import (via `import 'iqvoc_inflectionals'`, resolved
// through package.json's "main"). Does not start Rails/UJS - see
// application.js for that.
//
// iqvoc_inflectionals has no JS of its own; it only depends on
// iqvoc_skosxl's models/views. iqvoc_skosxl's own manifest already pulls
// in iqvoc's, so importing it alone is enough here too.
import 'iqvoc_skosxl'
