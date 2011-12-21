class Card < ActiveRecord::Base
  scope :root_cards, where(:parent_id => nil)
	belongs_to :parent, :class_name => "Card", :foreign_key => "parent_id"
	has_many :children, :class_name => "Card", :foreign_key => "parent_id", :dependent => :destroy
  belongs_to :user
  validates :name, :presence => true

  def has_children?
    return !self.children.nil?
  end


end
