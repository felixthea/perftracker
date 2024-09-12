class ReviewGenerator
  OPENAI_URL = 'https://api.openai.com/v1/chat/completions'

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
    headers = {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"
    }
    request_body = {
      model: 'gpt-4o-mini',
      messages: [{role: 'user', content: prompt}],
      temperature: 1.0
    }

    response = HTTP.headers(headers).post(url, json: body)
    if response.status.success?
      response.parse['choices'][0]['message']['content']
    else
      puts "Error: #{response.status}"
    end
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