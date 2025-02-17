module Prompts
  DEFAULT_PROMPT = <<~HEREDOC
    Hi, I have to write a self-review and would like you to create
    it for me by taking these list of accomplishments and write a review
    that demonstrates how I meet or exceed the job expectation. Start directly
    with the feedback, without any introductory phrases or acknowledgements
    of this request.\n
  HEREDOC

  WEEKLY_PROMPT = <<~HEREDOC
    Hi, I would like to create a recap of my week with these accomplishments
    and how they helped me meet or exceed my expectations. Write this in a
    way where you are talking directly to me to give me mostly positive feedback
    and some constructive feedback. Start directly with the feedback, without
    any introductory phrases or acknowledgements of this request.\n
  HEREDOC
end
