
require File.expand_path("../test_helper", __FILE__)

class DatetimeTest < AttrSearchable::TestCase
  def test_mapping
    product = create(:product, :created_at => Time.parse("2014-05-01 12:30:30"))

    assert_includes Product.search("created_at: 2014"), product
    assert_includes Product.search("created_at: 2014-05"), product
    assert_includes Product.search("created_at: 2014-05-01"), product
    assert_includes Product.search("created_at: '2014-05-01 12:30:30'"), product
  end

  def test_anywhere
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("2014-05-01"), product
    refute_includes Product.search("2014-05-02"), product
  end

  def test_includes
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("created_at: 2014-05-01"), product
    refute_includes Product.search("created_at: 2014-05-02"), product
  end

  def test_equals
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("created_at = 2014-05-01"), product
    refute_includes Product.search("created_at = 2014-05-02"), product
  end

  def test_equals_not
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("created_at != 2014-05-02"), product
    refute_includes Product.search("created_at != 2014-05-01"), product
  end

  def test_greater
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("created_at < 2014-05-02"), product
    refute_includes Product.search("created_at < 2014-05-01"), product
  end

  def test_greater_equals
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("created_at >= 2014-05-01"), product
    refute_includes Product.search("created_at >= 2014-05-02"), product
  end

  def test_less
    product = create(:product, :created_at => Time.parse("2014-05-01"))

    assert_includes Product.search("created_at < 2014-05-02"), product
    refute_includes Product.search("created_at < 2014-05-01"), product
  end

  def test_less_equals
    product = create(:product, :created_at => Time.parse("2014-05-02"))

    assert_includes Product.search("created_at <= 2014-05-02"), product
    refute_includes Product.search("created_at <= 2014-05-01"), product
  end
end

