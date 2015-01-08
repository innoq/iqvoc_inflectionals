# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class ImportTest < ActiveSupport::TestCase
  TEST_DATA = File.open(File.expand_path("../../fixtures/hobbies.nt", __FILE__))

  setup do
    @importer = SkosImporter.new(TEST_DATA, "http://hobbies.com/")
  end

  test "import inflectionals" do
    assert_difference "Concept::SKOS::Base.count" do
      @importer.run
    end

    concept = Concept::SKOS::Base.first

    assert_equal 2, concept.pref_labels.first.inflectionals.count
    assert_equal 1, concept.pref_labels.first.inflectionals.where(:value => "Computer programming (used as xl:prefLabel)").count
    assert_equal 1, concept.pref_labels.first.inflectionals.where(:value => "Computer programmings").count

    nerding = Label::SKOSXL::Base.where(:origin => "nerding").first

    # test for duplicate inflectionals not getting created
    assert_not_nil nerding
    assert_equal 1, nerding.inflectionals.count
    assert_equal "Nerding", nerding.inflectionals.first.value
  end

end
