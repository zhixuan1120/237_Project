class Micropost < ActiveRecord::Base
  #attr_accessible :content, :email, :tag

  belongs_to :user
  has_many :votes

  validates :content, presence: true, length: { maximum: 500 }
  validates :tag, presence: true

  # /.../i is case insensitve

  # $ indicates the end of line and is bad because it allows javascript injection.
  # e.g. "matchedString\n<script>code</script>" will pass regex check because of new line char \n
  # so we want to use \z instead of $. Same reason for using \A instead of ^
  
  # \. escapes dot
  # \d is digit
  # [a-zA-Z] char set is not equivalent to [A-z]. And [a-Z] is not valid at all.
  # A wider option is \w which is a character from a-z, A-Z, 0-9, including the _ (underscore) character.
  # VALID_EMAIL_REGEX = /\A[a-z]+\.\d+@osu.edu|admin\z/
  # validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :user_id, presence: true
  default_scope { order(:created_at => :desc) }

  def count_votes
  	read_attribute(:votes) || votes.sum(:value)
  end
end
