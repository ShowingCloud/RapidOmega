class Medium < ApplicationRecord
    enum media_type: [:news,:image,:voice,:video]
end
