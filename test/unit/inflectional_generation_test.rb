# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class InflectionalGenerationTest < ActiveSupport::TestCase

  test "inflectional candidates generation (without instantiating)" do
    # german example
    generated_candidates = Inflectional::Base.candidates_for('Baum', 'de', 'D5')
    expected_candidates = %w(Baum Baume Baumes Baums)
    assert_equal expected_candidates.size, generated_candidates.size
    expected_candidates.each { |inf| assert generated_candidates.include?(inf), "inflectional '#{inf}' expected" }

    # english example
    generated_candidates = Inflectional::Base.candidates_for('tree', 'en', 'D7')
    expected_candidates = %w(tree trees)
    assert_equal expected_candidates.size, generated_candidates.size
    expected_candidates.each { |inf| assert generated_candidates.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "simple inflectional generation" do
    label = Iqvoc::Xllabel.base_class.create!(
      value: 'Eisenbahnfahrzeug',
      language: 'de',
      base_form: 'Eisenbahnfahrzeug',
      inflectional_code: 'CA')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = %w(Eisenbahnfahrzeug Eisenbahnfahrzeuge Eisenbahnfahrzeugen Eisenbahnfahrzeuges Eisenbahnfahrzeugs)

    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "inflectional generation with german ß" do
    label = Iqvoc::Xllabel.base_class.create!(
      value: 'Außenwirtschaftsbeziehung',
      language: 'de',
      base_form: 'Außenwirtschaftsbeziehung',
      inflectional_code: 'D0')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = %w(Außenwirtschaftsbeziehung Außenwirtschaftsbeziehungen)
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "inflectional generation with umlaut" do
    label = Iqvoc::Xllabel.base_class.create!(
      value: 'Marschgewässer',
      language: 'de',
      base_form: 'Marschgewässer',
      inflectional_code: 'D9')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = %w(Marschgewässer Marschgewässern Marschgewässers)
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "inflectional generation with hyphen" do
    label = Iqvoc::Xllabel.base_class.create!(
      value: 'Eisen- und Stahlindustrie',
      language: 'de',
      base_form: 'Eisen- und Stahlindustrie',
      inflectional_code: 'FF')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = ['Eisen- und Stahlindustrie']
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }

    label = Iqvoc::Xllabel.base_class.create!(
      value: 'Agrar-Umweltindikator',
      language: 'de',
      base_form: 'Agrar-Umweltindikator',
      inflectional_code: 'D7')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = ['Agrar-Umweltindikator', 'Agrar-Umweltindikators']
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end
end
