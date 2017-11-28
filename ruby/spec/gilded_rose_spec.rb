require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it 'decreases in quality each day' do
      items = [Item.new("foo", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it 'reduces the sell_in value by one day' do
      items = [Item.new("foo", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 0
    end

    it 'reduces quality x2 after sell by date passed' do
      items = [Item.new("foo", 0, 2)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it 'quality of an item is never negative' do
      items = [Item.new("foo", 0, 2)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end

    it 'increases quality of Aged Brie twice as fast after sell by date' do
      items = [Item.new("Aged Brie", 0, 1)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
    end

    it 'Aged Bried quality can never be more than 50' do
      items = [Item.new("Aged Brie", 2, 49)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 50
    end

    it 'increases quality of BSP 2x with less than 10 days' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 14
    end
  end

end
