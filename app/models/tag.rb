class Tag < ApplicationRecord
  has_many :book_tags, dependent: :destroy
  has_many :books, through: :book_tags

  def self.looks(search,word)
    if search == "perfect_match"
      @tag = Tag.where("tag_name LIKE?","#{word}")
    elsif search == "forward_match"
      @tag = Tag.where("tag_name LIKE?","#{word}%")
    elsif search == "backward_match"
      @tag = Tag.where("tag_name LIKE?","%#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("tag_name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
  end
end
