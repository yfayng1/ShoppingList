class AddLists < ActiveRecord::Migration
  class List < ActiveRecord::Base
    has_many :items
  end

  class Item < ActiveRecord::Base
    belongs_to :list
  end


  def self.up

    list = List.create(:name => 'Welcome')
    list.items.create(:name => 'Check out our docs https://support.cloud.engineyard.com/forums')
    list.items.create(:name => 'Follow @EngineYard http://twitter.com/#!/engineyard')
    list.items.create(:name => 'Follow @eycloud http://twitter.com/#!/eycloud')
    list.items.create(:name => 'We blog http://www.engineyard.com/blog/')
    list.items.create(:name => 'Rock on!')
  end

  def self.down
    List.find_by_name('Test').destroy
  end
end
