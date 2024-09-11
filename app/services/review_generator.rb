class ReviewGenerator
  def initialize(user_id:, start_time:, end_time:, expectation_id:, review_type:)
    @user_id = user_id
    @start_time = start_time
    @end_time = end_time
    @expectation_id = expectation_id
    @review_type = review_type

    @user = User.find(@user_id)
  end

  def call
    generate_report
  end

  def generate_report
    accomplishments = Accomplishment.where(created_at: @start_time..@end_time)
    expectation = Expectation.find(@expectation_id)

    prompt = generate_prompt(accomplishments: accomplishments, expectation: expectation)
    llm_response = call_llm(prompt: prompt)

    # Create a Review 
    review = create_review(llm_response: llm_response)
    review.id
  end

  def generate_prompt(accomplishments:, expectation:)
  end

  def call_llm(prompt:)
  end

  def create_review(llm_response:)
    review = Review.new(
      result: llm_response,
      start: @start_time,
      end: @end_time,
      type: @review_time
    )
    review
  end
end