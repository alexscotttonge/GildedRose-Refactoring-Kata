require 'gilded_rose'

describe GildedRose do

  let(:gilded_rose) { GildedRose.new }

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

    it 'Aged Brie quality goes up by one before sell by date' do
      items = [Item.new("Aged Brie", 5, 4)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
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

    it 'increases quality of BSP x3 with less than 5 days' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 6, 10)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 15
    end

    it 'quality of BSP drops to 0 after concert date' do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 1, 10)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 0
    end
  end

  describe '#reduce_days' do
    it 'reduces the days for regular items' do
      items = [Item.new("foo", 1, 1)]
      GildedRose.new(items).reduce_days
      expect(items[0].sell_in).to eq 0
    end
  end

  describe '#is_brie?' do
    it 'increases the quality 1x before sell by date' do
      items = [Item.new("Aged Brie", 2, 2)]
      GildedRose.new(items).is_brie?
      expect(items[0].quality).to eq 3
    end
  end


end
