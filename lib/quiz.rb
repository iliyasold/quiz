require_relative 'question'

# класс, создающий викторину
class Quiz
  attr_reader :questions, :points

  # @return [questions]
  def self.read_from_xml(file_path)
    file = File.new(file_path)
    doc = REXML::Document.new(file)
    file.close

# ------------------------------- Данные для викторины ----------------------------------
    questions = []
    doc.elements.each('questions/question') do |item|
      text = item[1].text # текст вопроса
      time_limit = item.attributes["time_limit"].to_f # лимит времени
      variants = [] # варианты ответов
      correct_variant = nil # правильный вариант ответа

      item.elements.each('variants/variant') do |variant|
        variants << variant.text
        correct_variant = variant.text if variant.attributes["correct_variant"] == 'true'
      end

      questions << Question.new(text, time_limit, variants, correct_variant)
    end

    questions
  end

  def initialize(file_path)
    @questions = Quiz.read_from_xml(file_path)
    @user_answer = nil
    @end_time = nil
    @start_time = nil
  end

  # проверка правильности ответа
  def check_user_answer(user_answer, question)
    user_answer == question.correct_variant
  end
end
