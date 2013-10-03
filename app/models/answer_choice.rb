class AnswerChoice < ActiveRecord::Base
  attr_accessible :text, :q_id

  validates :text, :presence => true,
  validates :q_id, :presence => true

  belongs_to :question,
            :class => "Question",
            :foreignkey => :q_id,
            :primary_key => :id

  has_many :renponses,
            :class => "Response",
            :foreign_key => :response_id,
            :primary_key => :id

end
