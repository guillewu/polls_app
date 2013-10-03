class Response < ActiveRecord::Base
  attr_accessible :answer_id, :user_id

  validates :answer_id, :presence => true
  validates :user_id, :presence => true

  # validate :respondent_has_not_already_answered_question
  validate :author_cant_respond_to_own_poll

  belongs_to :answer_choice,
             :class_name => "AnswerChoice",
            :foreign_key => :answer_id,
            :primary_key => :id

  belongs_to :respondent,
            :class_name => "User",
            :foreign_key => :user_id,
            :primary_key => :id


  # def respondent_has_not_already_answered_question
  #   question_ids = []
  #   Response.find_all_by_user_id(user_id).each do |answer|
  #     question_ids << AnswerChoice.find(answer).q_id
  #   end
  #
  #   if question_ids.include?(answer_choice.q_id)
  #     errors[:already_answered] << "can't answer same question twice"
  #   end
  # end

  def author_cant_respond_to_own_poll
    user = User.find(user_id)
    users_polls = user.authored_polls
    user_existing_polls = []
    users_polls.each do |poll|
      user_existing_polls << poll.id
    end


    question_ids = []
    Response.find_all_by_user_id(user_id).each do |answer|
      question_ids << AnswerChoice.find(answer.answer_id).q_id
    end

    answer_poll = []
    question_ids.each do |question_id|
      answer_poll << (Question.find(question_id)).poll_id
    end

    p "users_polls is #{user_existing_polls.uniq}"
    p "answer_poll is #{answer_poll.uniq}"

    if user_existing_polls.uniq.include?(answer_poll.uniq[0])
      errors[:cant_respond_own_poll] << "can't respond to your own poll"
    end

  end



  # answer_choice.question #returns question, answer belongs to
  # <<-SQL, question_id, user_id
  #
  #
  # SELECT *
  # FROM responses
  # JOIN answer_choices ON responses.answer_id = answer_choices.id
  # WHERE answer_choices.q_id = ?
  # AND answer_choices.q_id IN #were for the same question_id
  # (SELECT DISTINCT questions.id
  # FROM answer_choices
  # JOIN responses ON answer_choices.id = responses.answer_id
  # JOIN questions ON questions.id = answer_choices.q_id
  # WHERE responses.user_id = ?) #writing a subquery that returned the corresponding question_id for the AnswerChoice the response referred to
  #
  # SQL

end


# SELECT DISTINCT *
#   FROM answer_choices
#   JOIN responses ON answer_choices.id = responses.answer_id where responses.user_id = 1
