class Announcement < ApplicationRecord

  enum status: { published: 0, draft: 1,  unpublished: 2 }

end
