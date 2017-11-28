require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it 'increases the quality of brie by one each day' do
      items = [Item.new("Aged Brie", 1, 1)]
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 2
    end

    it 'increases quality of brie twice as fast after sell by date' do
      items = [Item.new("Aged Brie", 0, 1)]
      GildedRose.new(items).update_quality()
      GildedRose.new(items).update_quality()
      expect(items[0].quality).to eq 5
    end

    it 'quality can never be more than 50' do
        items = [Item.new("Aged Brie", 2, 49)]
        GildedRose.new(items).update_quality()
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 50
    end

  end

end
