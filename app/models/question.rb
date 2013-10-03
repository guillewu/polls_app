class Question < ActiveRecord::Base
  attr_accessible :text, :poll_id

  validates :text, :presence => true
  validates :poll_id, :presence => true

  has_many :answer_choices,
            :class_name => "AnswerChoice",
            :foreign_key => :q_id,
            :primary_key => :id

  belongs_to :poll,
            :class_name => "Poll",
            :foreign_key => :poll_id,
            :primary_key => :id
end
