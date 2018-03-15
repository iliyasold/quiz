require 'rexml/document'
require_relative 'lib/quiz'
require_relative 'lib/declension'

puts "Программа 'Викторина'. Soldatkin™Lab 2018. v.2.1 \n\n"

current_path = File.dirname(__FILE__) + "/data/questions_answers.xml"
abort "Файл questions_answers.xml не найден." unless File.exist?(current_path)

quiz = Quiz.new(current_path)

points = 0 # количество правильных ответов
n = 0

quiz.questions.each do |question|
  puts question.text
  puts "Время на ответ: #{question.time_limit} секунд"
  puts "\nВарианты ответов:"
  puts question.variants.shuffle

  start_time = Time.now

  puts "\nВведите ответ"
  @user_answer = STDIN.gets.chomp

  end_time = Time.now
  sleep(1)

  if quiz.check_user_answer(@user_answer, question)
    if question.time_end?(start_time, end_time)
      puts "Время ответа превышено. Ответ не будет засчитан. \n\n"
    else
      puts "Это верный ответ! \n\n"
      points += 1
    end
  else
    puts "Это не верный ответ!"
    puts "Верный ответ: #{question.correct_variant} \n\n"
  end

  n += 1
end

declension = Declension.new
puts "Итого засчитано: #{points} #{declension.russian(points, "правильный ответ", "правильных ответа", "правильных ответов")}."
