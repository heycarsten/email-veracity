require File.dirname(__FILE__) + '/../test_helper'


class ArrayExtensionsTest < Test::Unit::TestCase

  def test_reject_blank_items
    array = [[], {}, '', nil, '    ', 'good times!']
    assert_equal ['good times!'], array.reject_blank_items, 'Should reject all blank and empty objects.'
    array = [{:neat => 'o'}, ['cool'], 1, 's']
    assert_equal array, array.reject_blank_items, 'Should not reject any filled or not-blank objects.'
  end

  def test_has_one_item?
    assert [''].has_one_item?, 'Should contain one item.'
    assert [nil].has_one_item?, 'Should contain one item.'
    assert [[]].has_one_item?, 'Should contain one item.'
    assert ![].has_one_item?, 'Should not contain one item.'
    assert ![nil, false].has_one_item?, 'Should not contain one item.'
  end

end