class ReviewGenerator
  OPENAI_URL = "https://api.openai.com/v1/chat/completions"

  def initialize(user_id:, start_time:, end_time:, expectation_id:, review_type:, initial_prompt:)
    @user_id = user_id
    @start_time = start_time
    @end_time = end_time
    @expectation_id = expectation_id
    @review_type = review_type

    default_prompt = <<~HEREDOC
      Hi, I have to write a self-review and would like you to create
      it for me by taking these list of accomplishments and write a review
      that demonstrates how I meet or exceed the job expectation. Start directly#{' '}
      with the feedback, without any introductory phrases or acknowledgements#{' '}
      of this request.\n
    HEREDOC

    weekly_prompt = <<~HEREDOC
      Hi, I would like to create a recap of my week with these accomplishments
      and how they helped me meet or exceed my expectations. Write this in a
      way where you are talking directly to me to give me mostly positive feedback
      and some constructive feedback. Start directly with the feedback, without
      any introductory phrases or acknowledgements of this request.\n
    HEREDOC
    @initial_prompt = initial_prompt

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
    prompt_str = @initial_prompt.dup
    accomplishments_str = "Here are the accomplishments:\n"
    accomplishments.each.with_index(1) do |accomplishment, index|
      accomplishments_str << "#{index}. #{accomplishment.text}\n"
    end

    expectation_str = "\nAnd here is the job expectation:\n#{expectation.text}"

    prompt_str << accomplishments_str
    prompt_str << expectation_str
    prompt_str
  end

  def call_llm(prompt:)
    headers = {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}"
    }
    request_body = {
      model: "gpt-4o-mini",
      messages: [ { role: "user", content: prompt } ],
      temperature: 1.0
    }

    response = HTTP.headers(headers).post(OPENAI_URL, json: request_body)
    if response.status.success?
      response.parse["choices"][0]["message"]["content"]
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
