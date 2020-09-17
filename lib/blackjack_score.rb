VALID_CARDS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

def blackjack_score(hand)

  # Raises an ArgumentError if the array contains an invalid card value
  hand.each do |card|
    if VALID_CARDS.include?(card) == false
      raise ArgumentError.new("Invalid card value.")
    end
  end

  # Raises an ArgumentError if hand has more than 5 cards
  if hand.length > 5
    raise ArgumentError.new("The hand contains more than 5 cards. A hand should contain 2, 3, 4, or 5 cards.")
  end

  # Raises an ArgumentError if hand has less than 2 cards
  if hand.length < 2
    raise ArgumentError.new("The hand contains less than 2 cards. A hand should contain 2, 3, 4, or 5 cards.")
  end

  # Defines score variable and initiates its value as 0
  score = 0

  # Creates array of values so that Jack, Queen, King are read as a digital value of 10, and temporarily assigns a value of 11 to any Ace card
  array_of_values = hand.map do |card|
    if card == "Jack" || card == "Queen" || card == "King"
      card = 10
    elsif card == "Ace"
      card = 11
    else
      card = card
    end
  end

  # Initiates score (which is the total), and score_without_aces (which is the score without the aces)
  score = 0
  score_without_aces = 0

  # Finds the score without the value of the aces
  array_of_values.each do |card|
    score_without_aces += card unless card == 11
  end

  # Finds the total score, counting each Ace as 11, for now
  array_of_values.each do |card|
    score += card
  end

  # Organizes the hand from least value to biggest value so that aces end up at the end of the array with its temp values of 11 if they are present in the hand
  increasing_order_hand = array_of_values.sort { |a, b| a <=> b }

  # This ensures aces are counted as 1 instead of 11 if needed
  increasing_order_hand.each do |card_value|
    if card_value == 11 && score > 21 && score_without_aces <= 21
      score -= 10
    end
  end

  # Raises an ArgumentError if the score exceeds 21 otherwise
  if score > 21
    raise ArgumentError.new("Bust Hand! Your hand exceeded 21.")
  end

  return score
end
=begin
# THIS IS CODE FOR THE TESTING PORTION OF THE ASSIGNMENT

require 'minitest/autorun'
require 'minitest/reporters'

# Tests for an Ace and a Queen
describe 'blackjack_score' do
  it 'return 21 for an Ace and a Queen' do
    hand = ["Ace", "Queen"]
    actual_score = blackjack_score(hand)
    expect(actual_score).must_equal 21
  end
end

# Tests for a Jack and two Aces
describe 'blackjack_score' do
  it 'return 12 for a Jack and two Aces' do
    hand = ["Ace", "Jack", "Ace"]
    actual_score = blackjack_score(hand)
    expect(actual_score).must_equal 12
  end
end

# Tests for 5 Aces
describe 'blackjack_score' do
  it 'return 15 for 5 Aces' do
    hand = ["Ace", "Ace", "Ace", "Ace", "Ace"]
    actual_score = blackjack_score(hand)
    expect(actual_score).must_equal 15
  end
end
=end