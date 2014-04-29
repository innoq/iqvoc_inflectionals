# initializer for both iqvoc and iqvoc_skosxl

# This basically duplicates iqvoc_skosxl's initializer —
# but is required to ensure correct loading order!?
require 'iqvoc/xllabel'

Iqvoc.config.register_setting("title", "iQvoc Inflectionals")

# Application's responsibility!
# Iqvoc.searchable_class_names << "Inflectional::Base"

Iqvoc::XLLabel.additional_association_class_names.
    merge!("Inflectional::Base" => "label_id")
Iqvoc::XLLabel.view_sections += ["inflectionals"]
