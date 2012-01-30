# initializer for both iqvoc and iqvoc_skosxl

require 'iqvoc/xllabel' # XXX: this basically duplicates iqvoc_skosxl's initializer - but is required to ensure correct loading order!?

Iqvoc.config.register_setting("title", "iQvoc Inflectionals")

#Iqvoc.searchable_class_names << "Inflectional::Base" # XXX: application's responsibility!?

Iqvoc::XLLabel.additional_association_class_names.
    merge!("Inflectional::Base" => "label_id")
Iqvoc::XLLabel.view_sections += ["inflectionals"]
