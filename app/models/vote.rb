class Vote < ActiveRecord::Base
  #attr_accessible :value, :micropost, :micropost_id

  belongs_to :micropost
  belongs_to :user

  # for all the votes with user_id 123, the micropost_id is unque, this prevents user from voting many times
  validates_uniqueness_of :micropost_id, scope: :user_id
  
  validates_inclusion_of :value, in: [1, -1]

  # this prevents user from voting his own post
  validate :ensure_not_author

  def ensure_not_author
    errors.add :user_id, "is the author of the haiku" if micropost.user_id == user_id
  end
  
end