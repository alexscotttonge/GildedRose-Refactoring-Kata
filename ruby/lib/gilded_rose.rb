class GildedRose

  #Special items
  CONST_BRIE = "Aged Brie"
  CONST_TICKETS = "Backstage passes to a TAFKAL80ETC concert"
  CONST_SULF = "Sulfuras, Hand of Ragnaros"


  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
    # reduce quality by one if not brie or passes, more than zero quality and not sulfuras
      if item.name != CONST_BRIE and item.name != CONST_TICKETS
        if item.quality > 0
          if item.name != CONST_SULF
            item.quality -= 1
    # reduce quality by one if not brie or passes, more than zero quality and not sulfuras

          end
        end
      else
        if item.quality < 50
          item.quality += 1
          if item.name == CONST_TICKETS
            if item.sell_in < 11
              if item.quality < 50
                item.quality += 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality += 1
              end
            end
          end
        end
      end
      # reduce_days #
      if item.name != CONST_SULF
        item.sell_in -= 1
      end
      # reduce_days #

      # reduce quality by 1 if not brie, passes, quality is over 1 and not sulfuras
      if item.sell_in < 0
        if item.name != CONST_BRIE
          if item.name != CONST_TICKETS
            if item.quality > 0
              if item.name != CONST_SULF
                item.quality -= 1
      # reduce quality by 1 if not brie, passes, quality is over 1 and not sulfuras

              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality += 1
          end
        end
      end

    end
  end

  def reduce_days
    @items.each do |item|
      if item.name != CONST_SULF
        item.sell_in -= 1
      end
    end
  end


end




class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
