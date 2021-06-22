class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses
  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    if @attempted_chars.include?(char)
      return true
    else
      false
    end
  end

  def get_matching_indices(char)
    array = []
    @secret_word.each_char.with_index do |ch, i|
      if char == ch
        array << i
      end
    end
    array
  end

  def fill_indices(char, arr)
    arr.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    attempted = already_attempted?(char)
    matching = get_matching_indices(char)
    fill = fill_indices(char, matching)
    @remaining_incorrect_guesses -= 1 if matching.empty? == true
    if attempted == true
      p 'that has already been attempted'
      return false
    else 
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    p 'Enter a char:'
    char = gets.chomp
    return try_guess(char)
  end

  def win?
    if @guess_word.join("") == @secret_word
      p 'WIN'
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      p 'LOSE'
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? == true || self.lose? == true
      p @secret_word
      return true
    else
      return false
    end
  end
end
