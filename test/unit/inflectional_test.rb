# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class InflectionalTest < ActiveSupport::TestCase

  setup do
    @words = %w(Lorem ipsum dolor sit amet consectetur adipisicing elit sed do)
  end

  test "instance creation" do
    label = Label::SKOSXL::Base.create!(:value => "foo",
        :origin => Origin.new("foo").to_s)
    label.inflectionals.create!(:value => "bar")

    assert_equal 2, Inflectional::Base.count
    assert_equal ["foo", "bar"], Inflectional::Base.all.map(&:value)
  end

  test "hashing of values within the label callback" do
    @words.each do |word|
      Label::SKOSXL::Base.create!(:value => word,
          :origin => Origin.new(word).to_s)
    end

    assert_equal @words.count, Inflectional::Base.count
  end

  test "base form sanitizer extension for origin generator" do
    assert_equal "commaslashdotbracketbracket", Label::SKOSXL::Base.new.sanitize_base_form("comma,slash/dot.bracket[bracket]")
  end

end
