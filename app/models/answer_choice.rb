class AnswerChoice < ActiveRecord::Base
  attr_accessible :text, :q_id

  validates :text, :presence => true
  validates :q_id, :presence => true

  belongs_to :question,
            :class_name => "Question",
            :foreign_key => :q_id,
            :primary_key => :id

  has_many :responses,
            :class_name => "Response",
            :foreign_key => :response_id,
            :primary_key => :id

end
