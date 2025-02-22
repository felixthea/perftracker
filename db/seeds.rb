user1 = User.find_or_create_by!(email: "felixthea@gmail.com") do |u|
  u.password = "test123"
  u.password_confirmation = "test123"
end

puts "user1=#{user1.id}"

SENIOR_SWE_EXPECTATION = <<~HEREDOC
  A Senior Software Engineer is expected to design, develop, and maintain complex#{' '}
  software solutions while ensuring scalability, performance, and security.#{' '}
  They lead architectural decisions, mentor junior engineers, and collaborate#{' '}
  with cross-functional teams to deliver high-quality products. Strong problem-solving skills,#{' '}
  code reviews, and an ability to debug and optimize existing code are essential.#{' '}
  They must be proficient in multiple programming languages, frameworks, and tools,#{' '}
  often taking ownership of entire projects or features. Additionally, they are#{' '}
  expected to contribute to process improvements, advocate for best practices,#{' '}
  and stay updated on emerging technologies. Effective communication and collaboration#{' '}
  with stakeholders are crucial for understanding and aligning with business goals.#{' '}
  They are also responsible for managing technical debt, ensuring code quality,#{' '}
  and maintaining a sustainable development pace.
HEREDOC

expectation1 = Expectation.find_or_create_by(user_id: user1.id) do |e|
  e.text = SENIOR_SWE_EXPECTATION
end

accomplishment_texts = [
### Accomplishments that Mean You Are Meeting Expectations:
"Successfully delivered a complex feature or project on time, following best practices and maintaining high code quality.",
"Led architectural decisions and implemented scalable solutions that improved system performance by at least 15%.",
"Regularly mentored junior engineers, resulting in measurable improvements in their technical skills and code contributions.",

### Accomplishments that Come Close but Fall Short:
"Delivered a project but encountered avoidable delays due to incomplete planning or unexpected technical debt.",
"Made architectural suggestions but struggled to communicate the rationale clearly to the team or stakeholders.",
"Provided mentorship to junior engineers, but the feedback was inconsistent or didn't result in noticeable improvements in their work.",
"Contributed to code reviews, but missed some critical performance or security issues that were caught later.",
"Implemented features with solid functionality but lacked optimization, leading to moderate performance issues under heavy load.",

### Accomplishments that Show You Exceeded Expectations:
"Designed and implemented a system that not only solved the immediate need but also introduced a new framework or tool that significantly streamlined future development for the team.",
"Spearheaded a major refactor of a legacy system, reducing technical debt by 40% and improving overall system performance and maintainability, all while mentoring others through the process."
]

accomplishment_texts.each do |at|
  # puts at
  # text_found = Accomplishment.find_by(text: at)
  # puts text_found
  # next if text_found
  Accomplishment.create!(
    user_id: user1.id,
    text: at
  )
end
