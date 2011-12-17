class Card < ActiveRecord::Base

  scope :root_cards, where(:parent_id => nil)
	belongs_to :parent, :class_name => "Card", :foreign_key => "parent_id"
	has_many :children, :class_name => "Card", :foreign_key => "parent_id"

  def has_children?
    return !self.children.nil?
  end


end
