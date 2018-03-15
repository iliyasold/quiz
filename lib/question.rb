# класс вопроса викторины
class Question
  attr_reader :text, :time_limit, :variants, :correct_variant

  def initialize(text, time_limit, variants, correct_variant)
    @text = text
    @time_limit = time_limit
    @variants = variants
    @correct_variant = correct_variant
  end

  def time_end?(start_time, end_time)
    elapsed_time = end_time - start_time
    elapsed_time > time_limit
  end
end
