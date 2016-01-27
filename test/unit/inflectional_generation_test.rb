# encoding: UTF-8

require File.join(File.expand_path(File.dirname(__FILE__)), '../test_helper')

class InflectionalGenerationTest < ActiveSupport::TestCase

  test "simple inflectional generation" do
    label = Iqvoc::XLLabel.base_class.create!(
      value: 'Eisenbahnfahrzeug',
      language: 'de',
      base_form: 'EISENBAHNFAHRZEUG',
      inflectional_code: 'CA')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = %w(Eisenbahnfahrzeug Eisenbahnfahrzeuge Eisenbahnfahrzeugen Eisenbahnfahrzeuges Eisenbahnfahrzeugs)

    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "inflectional generation with german ß" do
    label = Iqvoc::XLLabel.base_class.create!(
      value: 'Außenwirtschaftsbeziehung',
      language: 'de',
      base_form: 'AUSSENWIRTSCHAFTSBEZIEHUNG',
      inflectional_code: 'D0')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = %w(Außenwirtschaftsbeziehung Außenwirtschaftsbeziehungen)
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "inflectional generation with umlaut" do
    label = Iqvoc::XLLabel.base_class.create!(
      value: 'Marschgewässer',
      language: 'de',
      base_form: 'MARSCHGEWAESSER',
      inflectional_code: 'D9')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = %w(Marschgewässer Marschgewässern Marschgewässers)
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end

  test "inflectional generation with hyphen" do
    label = Iqvoc::XLLabel.base_class.create!(
      value: 'Eisen- und Stahlindustrie',
      language: 'de',
      base_form: 'EISEN UND STAHLINDUSTRIE',
      inflectional_code: 'FF')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = ['Eisen- und Stahlindustrie']
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }

    label = Iqvoc::XLLabel.base_class.create!(
      value: 'Agrar-Umweltindikator',
      language: 'de',
      base_form: 'AGRAR UMWELTINDIKATOR',
      inflectional_code: 'D7')

    label.generate_inflectionals!

    generated_inflectionals = label.inflectionals.reload.map(&:value)
    expected_inflectionals = ['Agrar-Umweltindikator', 'Agrar-Umweltindikators']
    assert_equal expected_inflectionals.size, generated_inflectionals.size
    expected_inflectionals.each { |inf| assert generated_inflectionals.include?(inf), "inflectional '#{inf}' expected" }
  end
end
