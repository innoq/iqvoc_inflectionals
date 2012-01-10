# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class InflectionalTest < ActiveSupport::TestCase

  setup do
    @words = %w(Lorem ipsum dolor sit amet consectetur adipisicing elit sed do)
  end

  test "instance creation" do
    label = Label::SKOSXL::Base.create!(:value => "foo",
        :origin => OriginMapping.merge("foo"))
    label.inflectionals.create!(:value => "bar")

    assert_equal 2, Inflectional::Base.count
    assert_equal ["foo", "bar"], Inflectional::Base.all.map(&:value)
  end

  test "hashing of values within the label callback" do
    @words.each do |word|
      Label::SKOSXL::Base.create!(:value => word,
          :origin => OriginMapping.merge(word))
    end

    assert_equal @words.count, Inflectional::Base.count
    Inflectional::Base.all.each do |inflectional|
      normalized = Inflectional::Base.normalize(inflectional.value)
      assert_equal normalized, inflectional.normal_hash
    end
  end

end
