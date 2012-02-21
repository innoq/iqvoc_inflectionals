# encoding: UTF-8

require 'digest/md5'

class Inflectional::Base < ActiveRecord::Base

  class_attribute :rdf_namespace, :rdf_predicate
  self.rdf_namespace = 'umt'
  self.rdf_predicate = 'inflectional'

  self.table_name ='inflectionals'

  validates :value, :presence => true
  validates :label_id, :presence => true

  belongs_to :label, :class_name => Iqvoc::XLLabel.base_class_name

  before_save do
    self.normal_hash = self.class.normalize(self.value)
  end

  def self.by_query_value(query)
    where(["LOWER(#{table_name}.value) LIKE ?", query.to_s.downcase])
  end

  MAPPINGS = {
    :de => {
      :"50"	=> ["A", "EN", "AS"],
      :"51"	=> [".", "S", "ES", "ER", "ERN"],
      :"52"	=> [".", "S", "N", "E", "EN"],
      :"61"	=> [".", "ES"],
      :"62"	=> [".", "S", "ES"],
      :"71"	=> [".", "ER"],
      :"73"	=> [".", "E", "EM", "EN", "ER", "ES", "M", "N", "S"],
      :"74"	=> [".", "R", "S"],
      :"75"	=> ["A", "EN"],
      :"77"	=> ["EN", "E", "EST", "ET", "T", "TE", "TEN", "TET"],
      :"78"	=> [".", "T"],
      :"7B"	=> [".", "N", "E", "EN", "EST", "ET", "ST", "T"],
      :"80"	=> [".", "S", "E", "EN"],
      :"95"	=> [".", "E", "ES", "ER", "ERN"],
      :"9E"	=> [".", "ENS"],
      :"9F"	=> [".", "SE", "SES", "SEN"],
      :"A0"	=> [".", "EN", "E", "EST", "ET", "ST", "T", "TE", "TEN", "TET"],
      :"A1"	=> [".", "EN", "E", "EST", "ET", "T", "TE", "TEN", "TET"],
      :"A2"	=> [".", "N", "E", "ST", "T", "TE", "TEN", "TET"],
      :"A3"	=> [".", "N", "ST", "T", "TE", "TEN", "TET"],
      :"AB"	=> [".", "EN", "E", "EST", "ET", "ST", "T"],
      :"AC"	=> [".", "EN", "E", "EST", "ET", "T"],
      :"AD"	=> [".", "N", "ST", "T"],
      :"AE"	=> [".", "N", "T"],
      :"AX"	=> ["E", "N", "ST", "T", "TE", "TEN", "TET"],
      :"AY"	=> ["E", "EN", "EST", "ET", "ST", "T", "TE", "TEN", "TET"],
      :"AZ"	=> ["E", "N", "ST", "T", "TE", "TEN", "TET"],
      :"B0"	=> [".", "EN", "EST", "ET", "ST", "T"],
      :"B5"	=> ["T", "ST", "TEN", "TE", "TET"],
      :"BA"	=> [".", "EN", "EST", "ET", "T"],
      :"BB"	=> [".", "E", "EN", "EST", "ET", "ST"],
      :"BC"	=> [".", "EN", "EST", "ET", "ST"],
      :"BD"	=> [".", "EN", "EST", "ET"],
      :"BF"	=> ["E", "EN", "EST", "ET"],
      :"C0"	=> [".", "ST", "T"],
      :"C1"	=> [".", "E", "ST", "T"],
      :"C3"	=> ["ST", "T"],
      :"C4"	=> [".", "ST"],
      :"C7"	=> [".", "D", "DE", "DEM", "DEN", "DER", "DES"],
      :"C8"	=> [".", "T", "TE", "TEN", "TET"],
      :"C9"	=> [".", "D", "DE", "DEM", "DEN", "DER", "DES", "S"],
      :"CA"	=> [".", "E", "EN", "ES", "S"],
      :"CB"	=> [".", "EN", "ES"],
      :"CC"	=> [".", "E", "EN", "ES"],
      :"AD"	=> [".", "N", "ST", "T"],
      :"AE"	=> [".", "N", "T"],
      :"AX"	=> ["E", "N", "ST", "T", "TE", "TEN", "TET"],
      :"AY"	=> ["E", "EN", "EST", "ET", "ST", "T", "TE", "TEN", "TET"],
      :"AZ"	=> ["E", "N", "ST", "T", "TE", "TEN", "TET"],
      :"B0"	=> [".", "EN", "EST", "ET", "ST", "T"],
      :"B5"	=> ["T", "ST", "TEN", "TE", "TET"],
      :"BA"	=> [".", "EN", "EST", "ET", "T"],
      :"BB"	=> [".", "E", "EN", "EST", "ET", "ST"],
      :"BC"	=> [".", "EN", "EST", "ET", "ST"],
      :"BD"	=> [".", "EN", "EST", "ET"],
      :"BF"	=> ["E", "EN", "EST", "ET"],
      :"C0"	=> [".", "ST", "T"],
      :"C1"	=> [".", "E", "ST", "T"],
      :"C3"	=> ["ST", "T"],
      :"C4"	=> [".", "ST"],
      :"C7"	=> [".", "D", "DE", "DEM", "DEN", "DER", "DES"],
      :"C8"	=> [".", "T", "TE", "TEN", "TET"],
      :"C9"	=> [".", "D", "DE", "DEM", "DEN", "DER", "DES", "S"],
      :"CA"	=> [".", "E", "EN", "ES", "S"],
      :"CB"	=> [".", "EN", "ES"],
      :"CC"	=> [".", "E", "EN", "ES"],
      :"CD"	=> [".", "SE", "SEN"],
      :"CE"	=> [".", "E", "ER", "ERN", "ES", "S"],
      :"CF"	=> [".", "EN", "S"],
      :"CG"	=> [".", "EN", "ES", "S"],
      :"D0"	=> [".", "EN"],
      :"D1"	=> [".", "NEN"],
      :"D2"	=> [".", "R", "N"],
      :"D3"	=> [".", "N"],
      :"D4"	=> [".", "N", "NS"],
      :"D5"	=> [".", "E", "ES", "S"],
      :"D6"	=> [".", "E", "ES"],
      :"D7"	=> [".", "S"],
      :"D8"	=> [".", "EN", "ENS"],
      :"D9"	=> [".", "N", "S"],
      :"DA"	=> ["A", "AS", "ATA", "EN"],
      :"DB"	=> ["A", "AS", "ATA", "ATE"],
      :"DD"	=> ["UM", "EN", "UMS"],
      :"DE"	=> ["UM", "A", "EN", "UMS"],
      :"DF"	=> ["US", "EN"],
      :"E0"	=> ["US", "EEN"],
      :"E2"	=> ["US", "I"],
      :"E3"	=> ["S", "SSES", "NTEN", "SSE", "SSEN"],
      :"E4"	=> ["S", "DEN"],
      :"E5"	=> ["S", "ZIEN"],
      :"E6"	=> ["EX", "EXEN", "EXE", "ICES", "IZES"],
      :"E7"	=> ["X", "CES", "ZES", "ZEN"],
      :"E9"	=> ["O", "OS", "EN"],
      :"EA"	=> ["ON", "A", "EN", "ONS"],
      :"EB"	=> ["OS", "EN"],
      :"EC"	=> ["IS", "EN"],
      :"ED"	=> ["I", "IS", "EN", "E"],
      :"EE"	=> ["Y", "IES", "YS"],
      :"EF"	=> ["EN", "ENS", "INA"],
      :"F0"	=> [".", "S", "E", "IEN"],
      :"F1"	=> [".", "S", "ER"],
      :"F3"	=> [".", "M", "N", "R", "S", "RE", "REM", "REN", "RER", "RES"],
      :"F4"	=> [".", "M", "N", "R", "S"],
      :"F5"	=> [".", "E", "EM", "EN", "ER", "ES", "ERE", "EREM", "EREN", "ERER", "ERES", "EST", "ESTE", "ESTEM", "ESTEN", "ESTER", "ESTES"],
      :"F6"	=> [".", "E", "EM", "EN", "ER", "ES", "ERE", "EREM", "EREN", "ERER", "ERES", "ST", "STE", "STEM", "STEN", "STER", "STES"],
      :"F7"	=> [".", "E", "EM", "EN", "ER", "ES"],
      :"FC"	=> [".", "ER", "EN", "T", "TER", "TEN", "TES", "TEM", "TENS"],
      :"FE"	=> [".", "E", "EM", "EN", "ER", "ES", "S"],
      :"FF"	=> ["."],
      :"FG"	=> [".", "EN", "ER"],
      :"FH"	=> ["E", "EM", "EN", "ER", "ES", "S"],
      :"G7"	=> [".", "E", "EM", "EN", "ES"],
      :"N1"	=> [".", "ES"],
      :"N2"	=> ["Y", "IES"],
      :"N3"	=> ["F", "VES"],
      :"N9"	=> ["US", "I", "USES"],
      :"NA"	=> ["A", "AE"],
      :"NB"	=> ["UM", "A"],
      :"NC"	=> ["UM", "A", "UMS"],
      :"ND"	=> ["O", "I"],
      :"NE"	=> ["O", "I", "OS"],
      :"NF"	=> ["ON", "A"],
      :"NI"	=> ["IS", "ES", "ISES"],
      :"NL"	=> ["EX", "ICES"],
      :"NQ"	=> [".", "TA", "S"],
      :"PP"	=> [".", "."],
      :"T0"	=> [".", "E"],
      :"TA"	=> [".", "E", "S"],
      :"TF"	=> [".", "E", "EN"],
      :"TK"	=> ["LE", "LER", "LES", "EL", "LEN", "LEM"],
      :"U2"	=> ["A", "AS", "ATA"],
      :"U3"	=> [".", "EN", "ST"],
      :"U5"	=> [".", "EN", "N"],
      :"U6"	=> [".", "EN", "T"],
      :"U7"	=> [".", "E", "T"],
      :"UA"	=> [".", "EN", "ST", "T"],
      :"UB"	=> [".", "E", "ER", "ES"],
      :"UC"	=> [".", "S", "ER", "ES"],
      :"UD"	=> [".", "E", "EN", "ST"],
      :"UE"	=> [".", "E", "EN", "T"],
      :"UG"	=> [".", "S", "ES", "TEN"],
      :"UI"	=> ["E", "EN", "T"],
      :"UL"	=> [".", "ER", "ES"],
      :"UM"	=> ["E", "EN", "EST", "ET", "T"],
      :"XC"	=> ["N", "ST", "T", "TE", "TEN", "TET"],
      :"XK"	=> ["E", "EN", "EST"],
      :"XM"	=> ["E", "ST", "T", "EN", "EST", "ET"],
      :"XO"	=> ["EN", "ST", "T"],
      :"XT"	=> [".", "E", "N", "ST", "T", "TE", "TEN", "TES", "TET", "TEM", "TER"],
      :"XU"	=> [".", "ST", "T", "TE", "TEM", "TEN", "TER", "TES", "TET"],
      :"XV"	=> ["ST", "T", "TE", "TEM", "TEN", "TER", "TET", "TES"],
      :"XW"	=> ["EN", "E", "EST", "ET", "ST", "T", "TE", "TEM", "TEN", "TER", "TES", "TET"],
      :"Y0"	=> ["ES", "ER", "ERN"],
      :"Y3"	=> [".", "E", "EN", "EST", "ET"],
      :"Y4"	=> ["EN", "EST", "ET"],
      :"YA"	=> [".", "EN", "E", "EST", "ET", "ST", "T", "TE", "TEM", "TEN", "TER", "TES", "TET"],
      :"YB"	=> [".", "EN", "E", "EST", "ET", "T", "TE", "TEN", "TET", "ES"],
      :"YC"	=> [".", "N", "E", "ST", "T", "TE", "TEN", "TE", "TET", "TEM", "TER", "TES"],
      :"YD"	=> [".", "EN", "E", "EST", "ET", "TE", "TEN", "TET"],
      :"YE"	=> ["E", "EN", "ST", "T", "TE", "TEN", "TEM", "TER", "TES"],
      :"YF"	=> ["E", "N", "ST", "T", "TE", "TEN", "TEM", "TER", "TES", "TET"],
      :"YL"	=> ["E", "T"],
      :"YS"	=> ["ST", "N", "T"],
      :"YW"	=> ["E", "N", "ES", "EN"],
      :"Z1"	=> [".", "S", "N", "IN", "INNEN"],
      :"Z2"	=> [".", "EN", "IN", "INNEN"],
      :"Z4"	=> ["E", "ER", "EN", "IN", "INNEN"],
      :"Z5"	=> [".", "S", "EN", "IN", "INNEN"],
      :"Z6"	=> [".", "TER", "TEM", "TES", "TEN", "TE"],
      :"Z7"	=> [".", "E", "EN", "IN", "INNEN", "S"],
      :"Z8"	=> [".", "EN", "IN", "N", "INNEN"],
      :"ZZ"	=> ["E", "EN", "IN", "INNEN"]
    },

    :en => {
      :"D0" =>	[".", "EN"],
      :"D7" =>	[".", "S"],
      :"E2" =>	["US", "I"],
      :"EE" =>	["Y", "IES", "YS"],
      :"FF" =>	["."],
      :"N1" =>	[".", "ES"],
      :"N2" =>	["Y", "IES"],
      :"N3" =>	["F", "VES"],
      :"N5" =>	["F", "FS", "VES"],
      :"N7" =>	[".", "REN"],
      :"N8" =>	["US", "I"],
      :"NA" =>	["A", "AE"],
      :"NB" =>	["UM", "A"],
      :"NC" =>	["UM", "A", "UMS"],
      :"ND" =>	["O", "I"],
      :"NE" =>	["O", "I", "OS"],
      :"NF" =>	["ON", "A"],
      :"NG" =>	["ON", "A", "ONS"],
      :"NH" =>	["IS", "ES"],
      :"NM" =>	["EX", "ICES", "EXES"],
      :"NO" =>	["X", "CES", "XES"],
      :"PP" =>	[".", "."],
      :"R0" =>	["R", "ST"],
      :"R1" =>	[".", "R", "ST"],
      :"R2" =>	[".", "R", "ST", "LY"],
      :"R3" =>	[".", "ER", "EST"],
      :"R4" =>	["Y", "IER", "IEST"],
      :"R5" =>	[".", "LY"],
      :"R6" =>	[".", "ER", "EST", "LY"],
      :"R7" =>	["Y", "IER", "IEST", "ILY"],
      :"R8" =>	["E", "ER", "EST", "LY"],
      :"R9" =>	["LE", "LY"],
      :"RA" =>	["Y", "ILY"],
      :"V0" =>	[".", "S", "D"],
      :"V1" =>	[".", "S", "ED"],
      :"V2" =>	[".", "ED"],
      :"V3" =>	[".", "ES", "ED"],
      :"V4" =>	["ED", "ING"],
      :"V5" =>	["E", "ES", "ING"],
      :"V7" =>	[".", "S", "ED", "ING"],
      :"V8" =>	[".", "ES", "ED", "ING"],
      :"V9" =>	["E", "ES", "ED", "ING"],
      :"VA" =>	[".", "S", "LED", "LING"],
      :"VB" =>	[".", "Y", "IES", "IED", "YING"],
      :"VC" =>	[".", "S", "ING"],
      :"VD" =>	[".", "ING"],
      :"VE" =>	[".", "ED", "ING"],
      :"VF" =>	[".", "S", "NED", "NING"],
      :"VG" =>	[".", "S", "PED", "PING"],
      :"VH" =>	[".", "S", "RED", "RING"],
      :"VI" =>	[".", "S", "TED", "TING"],
      :"VJ" =>	[".", "ES", "ING"],
      :"VK" =>	[".", "S", "BED", "BING"],
      :"VM" =>	[".", "S", "D", "ING"],
      :"VN" =>	[".", "S", "DED", "DING"],
      :"VP" =>	[".", "S", "EN", "ING"],
      :"VQ" =>	[".", "S", "GED", "GING"],
      :"VR" =>	[".", "S", "MED", "MING"],
      :"VS" =>	[".", "S", "SED", "SING"],
      :"VT" =>	["US", "USSE", "USSEN", "EN"]
    }
  }

  def self.codes_for_language(lang)
    return [] if lang.blank? || !mappings.has_key?(lang.to_sym)
    mappings[lang.to_sym].keys.sort {|a,b| a.to_s <=> b.to_s }
  end

  def self.for_language_and_code(lang, code)
    return [] if lang.blank? || code.blank? || !mappings.has_key?(lang.to_sym) || !mappings[lang.to_sym].has_key?(code.to_sym)
    mappings[lang.to_sym][code.to_sym]
  end

  def self.mappings_for_language(lang)
    return [] if lang.blank? || !mappings.has_key?(lang.to_sym)
    mappings[lang.to_sym].map.sort {|a,b| a.first.to_s <=> b.first.to_s }
  end

  def self.mappings
    MAPPINGS
  end

  def self.forces_multi_query?
    true
  end

  def self.single_query(params = {})
    query_str = build_query_string(params)

    by_query_value(query_str).
      includes(:label).merge(Label::UMT::Base.by_language(params[:languages].to_a).published.order("LOWER(#{Label::Base.table_name}.value)"))
  end

  # def self.single_query(params = {})
  #   query_str = build_query_string(params)
  #
  #   Label::UMT::Base.select("DISTINCT #{Label::UMT::Base.table_name}.*").
  #                    joins(:inflectionals).
  #                    where(Inflectional::Base.by_query_value(query_str)).
  #                    by_language(params[:languages].to_a).
  #                    published.
  #                    order("LOWER(#{Inflectional::Base.table_name}.value)")
  # end

  def self.search_result_partial_name
    'partials/inflectional/search_result'
  end

  def self.referenced_by(label_class)
    # To something with the label class
    label_class.send(:include, Iqvoc::Inflectionals::LabelExtensions)
  end

  def self.deep_cloning_relations
    self.name.to_relation_name
  end

  def self.view_section(obj)
    "inflectionals"
  end

  def self.view_section_sort_key(obj)
    200
  end

  def self.partial_name(obj)
    "partials/inflectional/base"
  end

  def self.edit_partial_name(obj)
    "partials/inflectional/edit_base"
  end

  def build_rdf(document, subject)
    subject.Umt.inflectional(value, :lang => label.language)
  end

  def self.normalize(str)
    str = str.to_s.mb_chars.downcase
    Digest::MD5.hexdigest(str)
  end

end
