class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :post_comments, dependent: :destroy
	has_many :book_tags, dependent: :destroy
	has_many :tags, through: :book_tags

	def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

	validates :rate, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true

  scope :created_today, -> {where(created_at: Time.zone.now.all_day)}
  scope :created_yesterday, -> {where(created_at: 1.day.ago.all_day)}
  scope :created_thisweek, -> {where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day)}
  scope :created_lastweek, -> {where(created_at: 2.week.ago.end_of_day..1.week.ago.end_of_day)}
  
	def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

  def self.sort(selection)
    case selection
    when 'new'
      return Book.all.order(created_at: :DESC)
    when 'old'
      return Book.all.order(created_at: :ASC)
    when 'like'
      return Book.all.order(rate: :DESC)
    when 'dislike'
      return Book.all.order(rate: :ASC)
    end
  end

  def tags_save(tag_list)
    if self.tags != nil
      book_tags_records = BookTag.where(book_id: self.id)
      book_tags_records.destroy_all
    end

    tag_list.each do |tag|
      inspected_tag = Tag.where(tag_name: tag).first_or_create
      self.tags << inspected_tag
    end

  end
end