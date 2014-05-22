# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')
require "iqvoc/skos_importer"

class ImportTest < ActiveSupport::TestCase
  TEST_DATA = File.open(File.expand_path("../../fixtures/hobbies.nt", __FILE__))

  setup do
    @importer = Iqvoc::SkosImporter.new(TEST_DATA, "http://hobbies.com/")
  end

  test "import inflectionals" do
    assert_difference "Concept::SKOS::Base.count" do
      @importer.run
    end

    concept = Concept::SKOS::Base.first

    assert_equal 2, concept.pref_labels.first.inflectionals.count
    assert_equal 1, concept.pref_labels.first.inflectionals.where(:value => "Computer programming (used as xl:prefLabel)").count
    assert_equal 1, concept.pref_labels.first.inflectionals.where(:value => "Computer programmings").count
  end

end
