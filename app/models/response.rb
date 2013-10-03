class Response < ActiveRecord::Base
  attr_accessible :answer_id, :user_id

  validates :answer_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :answer_choice,
             :class => "AnswerChoice",
            :foreign_key => :answer_id,
            :primary_key => :id

  belongs_to :respondent,
            :class => "User",
            :foreign_key => :user_id,
            :primary_key => :id
end
