# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class InflectionalTest < ActiveSupport::TestCase

  setup do
    @words = %w(Lorem ipsum dolor sit amet consectetur adipisicing elit sed do)
  end

  test "instance creation" do
    label = Label::Skosxl::Base.create!(:value => "foo",
        :origin => Origin.new("foo").to_s)
    label.inflectionals.create!(:value => "bar")

    assert_equal 2, Inflectional::Base.count
    assert_equal ["foo", "bar"], Inflectional::Base.all.map(&:value)
  end

  test "hashing of values within the label callback" do
    @words.each do |word|
      Label::Skosxl::Base.create!(:value => word,
          :origin => Origin.new(word).to_s)
    end

    assert_equal @words.count, Inflectional::Base.count
  end

  test "by_query_value finds labels by their inflectionals" do
    label = Label::Skosxl::Base.create!(:value => "foo", :origin => Origin.new("foo").to_s)
    label.inflectionals.create!(:value => "bars")
    label.inflectionals.create!(:value => "barn")
    other = Label::Skosxl::Base.create!(:value => "baz", :origin => Origin.new("baz").to_s)

    result = Label::Skosxl::Base.by_query_value("%bar%")

    assert_equal [label.id], result.map(&:id), "label with two matching inflectionals appears once"
    refute_includes result.map(&:id), other.id
  end

  test "by_query_value with a blank query also finds labels without inflectionals" do
    with = Label::Skosxl::Base.create!(:value => "foo", :origin => Origin.new("foo").to_s)
    without = Label::Skosxl::Base.create!(:value => "bar", :origin => Origin.new("bar").to_s)
    without.inflectionals.delete_all

    ['%%', '%', ''].each do |blank|
      assert_equal [with.id, without.id].sort, Label::Skosxl::Base.by_query_value(blank).map(&:id).sort, blank.inspect
    end
    assert_empty Label::Skosxl::Base.by_query_value("%bar%").where(:id => without.id)
  end

end
