require 'spec_helper'

module EulerProblem54
  RSpec.describe Tournament do
    subject{Tournament.new}
    # examples from the problem statement
    describe '#battle' do
      it 'correctly identifies the winner between Pair of Fives and Pair of Eights' do
        hand_1 = PokerHand.new Card.new('5','H'), Card.new('5','C'), Card.new('6','S'),
          Card.new('7','S'), Card.new('K','D')
        hand_2 = PokerHand.new Card.new('2','C'), Card.new('3','S'), Card.new('8','S'),
          Card.new('8','D'), Card.new('T','D')
        expect(subject.battle hand_1, hand_2).to be :two
      end
      it 'correctly identifies the winner between high A and high Q' do
        hand_1 = PokerHand.new Card.new('5','D'), Card.new('8','C'), Card.new('9','S'),
          Card.new('J','S'), Card.new('A','C')
        hand_2 = PokerHand.new Card.new('2','C'), Card.new('5','C'), Card.new('7','D'),
          Card.new('8','S'), Card.new('Q','H')
        expect(subject.battle hand_1, hand_2).to be :one
      end
      it 'correctly identifies the winner between three aces and flush with diamonds' do
        hand_1 = PokerHand.new Card.new('2','D'), Card.new('9','C'), Card.new('A','S'),
          Card.new('A','H'), Card.new('A','C')
        hand_2 = PokerHand.new Card.new('3','D'), Card.new('6','D'), Card.new('7','D'),
          Card.new('T','D'), Card.new('Q','D')
        expect(subject.battle hand_1, hand_2).to be :two
      end
      it 'correctly identifies the winner between matching pairs by the high_card' do
        hand_1 = PokerHand.new Card.new('4','D'), Card.new('6','S'), Card.new('9','H'),
          Card.new('Q','H'), Card.new('Q','C')
        hand_2 = PokerHand.new Card.new('3','D'), Card.new('6','D'), Card.new('7','H'),
          Card.new('Q','D'), Card.new('Q','S')
        expect(subject.battle hand_1, hand_2).to be :one
      end
      it 'correctly identifies the winner between two full houses by higher match' do
        hand_1 = PokerHand.new Card.new('2','H'), Card.new('2','D'), Card.new('4','C'),
          Card.new('4','D'), Card.new('4','S')
        hand_2 = PokerHand.new Card.new('3','C'), Card.new('3','D'), Card.new('3','S'),
          Card.new('9','S'), Card.new('9','D')
        expect(subject.battle hand_1, hand_2).to be :one
      end

    end
  end
end
