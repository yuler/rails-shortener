class View < ApplicationRecord
  belongs_to :link, touch: true, counter_cache: true
end
