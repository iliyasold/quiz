# класс правильного склонения слов
class Declension
  def russian(number, krokodil, krokodila, krokodilov)
    number = 0 if number == nil || !number.is_a?(Numeric)
    remainder = number % 100
    return krokodilov if remainder.between?(11, 14)
    remainder = number % 10
    return krokodil if remainder == 1
    return krokodila if remainder >= 2 && remainder <= 4
    krokodilov if (remainder >= 5 && remainder <= 9) || remainder == 0
  end
end