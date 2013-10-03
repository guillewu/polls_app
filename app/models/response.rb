class Response < ActiveRecord::Base
  attr_accessible :answer_id, :user_id

  validates :answer_id, :presence => true
  validates :user_id, :presence => true

  validate :respondent_has_not_already_answered_question

  belongs_to :answer_choice,
             :class_name => "AnswerChoice",
            :foreign_key => :answer_id,
            :primary_key => :id

  belongs_to :respondent,
            :class_name => "User",
            :foreign_key => :user_id,
            :primary_key => :id


  def respondent_has_not_already_answered_question

  end



  #answer_choice.question #returns question of what answer

end
