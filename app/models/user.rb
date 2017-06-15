class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :confirmable #, :database_authenticatable
         #:registerable,:recoverable, :rememberable, :trackable, :validatable
  
  # Setup accessible (or protected) attributes for your model
  #attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :inform

  has_secure_password
  has_many :microposts, dependent: :destroy
  has_many :votes

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  #VALID_EMAIL_REGEX = /\A[a-z]+\.\d+@osu.edu\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def feed
    Micropost.where("user_id = ?", id)
  end

  def can_vote_for?(micropost)
    votes.build(value: 1, micropost: micropost).valid?
  end

  def voted?(micropost) 
    !self.votes.where("micropost_id = ?", micropost.id).first.nil? && self.microposts.find_by_id(micropost.id).nil?
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  private
    def create_remember_token
      if self.remember_token.nil?
        self.remember_token = SecureRandom.urlsafe_base64
      end
    end
end
