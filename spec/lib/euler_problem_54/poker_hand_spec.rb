require 'spec_helper'

module EulerProblem54
  RSpec.describe PokerHand do
    let(:ace_s){Card.new('A','S')}
    let(:ace_c){Card.new('A','C')}
    let(:ace_h){Card.new('A','H')}
    let(:ace_d){Card.new('A','D')}
    let(:duece_s){Card.new('2','S')}
    let(:duece_c){Card.new('2','C')}
    let(:duece_h){Card.new('2','H')}
    let(:duece_d){Card.new('2','D')}

    describe '#find_matches' do
      it 'correctly finds 0 matches' do
        hand = PokerHand.new ace_d, Card.new('K','S'),Card.new('Q','S'),Card.new('J','S'), Card.new('T','S')
        expect(hand.find_matches.size).to be 0
      end

      it 'correctly finds 1 match' do
        hand = PokerHand.new ace_d, Card.new('K','S'),Card.new('Q','S'),Card.new('J','S'), ace_h
        expect(hand.find_matches.size).to be 1
        expect(hand.find_matches['A'].size).to be 2

      end

      it 'correctly finds 2 match' do
        hand = PokerHand.new ace_d, Card.new('K','S'),ace_c,Card.new('J','S'), ace_h
        expect(hand.find_matches.size).to be 1
        expect(hand.find_matches['A'].size).to be 3
      end
    end

    describe '#one_pair?' do
      it 'returns true when there is exactly one pair' do
        hand = PokerHand.new ace_d, ace_h, Card.new('K','S'),Card.new('Q','S'),Card.new('J','S')
        expect(hand.one_pair?).to be true
      end
      it 'returns false when there is no pair' do
        hand = PokerHand.new ace_d, Card.new('4','D'), Card.new('K','S'),Card.new('Q','S'),Card.new('J','S')
        expect(hand.one_pair?).to be false
      end
      it 'also returns true when there are 3 of a kind' do
        hand = PokerHand.new ace_d, ace_h, ace_c,Card.new('Q','S'),Card.new('J','S')
        expect(hand.one_pair?).to be true
      end
      it 'also returns true when there are two pairs' do
        hand = PokerHand.new ace_d, ace_h, duece_h, duece_s, Card.new('J','S')
        expect(hand.one_pair?).to be true
      end
    end

    describe '#two_pairs?' do
      it 'returns true when there is exactly two pairs' do
        hand = PokerHand.new ace_d, ace_h, Card.new('K','S'), duece_d, duece_h
        expect(hand.two_pairs?).to be true
      end
      it 'returns false when there is no pairs' do
        hand = PokerHand.new ace_d, duece_h, Card.new('K','S'),Card.new('Q','S'),Card.new('J','S')
        expect(hand.two_pairs?).to be false
      end
      it 'returns false when there is only one pair' do
        hand = PokerHand.new ace_d, duece_h, duece_d,Card.new('Q','S'),Card.new('J','S')
        expect(hand.two_pairs?).to be false
      end
      it 'also returns true when there 3 of a kind or a full house' do
        hand = PokerHand.new ace_d, ace_h, ace_c, duece_h, duece_c
        expect(hand.two_pairs?).to be true
      end
    end

    describe '#three_of_a_kind?' do
      it 'returns true when there is exactly three of a kind' do
        hand = PokerHand.new ace_d, ace_h, Card.new('K','S'), Card.new('Q','S'), ace_s
        expect(hand.three_of_a_kind?).to be true
      end
      it 'returns false when there are no pairs' do
        hand = PokerHand.new ace_d, Card.new('4','D'), Card.new('K','S'),Card.new('Q','S'), duece_s
        expect(hand.three_of_a_kind?).to be false
      end
      it 'returns false when there are two pairs' do
        hand = PokerHand.new ace_d, ace_h, Card.new('K','S'), duece_s, duece_h
        expect(hand.three_of_a_kind?).to be false
      end
      it 'also returns true when there are three of a kind and a pair (full house)' do
        hand = PokerHand.new ace_d, ace_h, duece_c, duece_s, ace_s
        expect(hand.three_of_a_kind?).to be true
      end
    end

    describe '#straight?' do
      it 'returns true when all cards are in sequential order' do
        hand = PokerHand.new Card.new('8','D'),Card.new('9','D'),Card.new('T','S'),Card.new('J','H'),Card.new('Q','S')
        expect(hand.straight?).to be true
      end

      it 'returns true when all cards can be sequentially ordered' do
        hand = PokerHand.new Card.new('J','H'),Card.new('9','D'),Card.new('8','D'),Card.new('T','S'),Card.new('Q','S')
        expect(hand.straight?).to be true
      end
      it 'returns false when cards can not make sequential sequence' do
        hand = PokerHand.new Card.new('5','D'),Card.new('9','D'),Card.new('2','S'),Card.new('J','H'),Card.new('Q','S')
        expect(hand.straight?).to be false
      end
    end

    describe '#flush?' do
      it 'returns true when all cards have the same suit' do
        hand = PokerHand.new Card.new('8','D'),Card.new('9','D'),Card.new('T','D'),Card.new('J','D'),Card.new('Q','D')
        expect(hand.flush?).to be true
      end
      it 'returns false when all cards are not the same suit' do
        hand = PokerHand.new Card.new('8','D'),Card.new('9','D'),Card.new('T','C'),Card.new('J','D'),Card.new('Q','D')
        expect(hand.flush?).to be false
      end
    end

    describe '#full_house?' do
      it 'returns true when three of a kind and a pair' do
        hand = PokerHand.new ace_d, ace_h, duece_c, duece_s, ace_s
        expect(hand.full_house?).to be true
      end
      it 'returns false when not a full house' do
        hand = PokerHand.new ace_d, ace_h, duece_c, duece_s, Card.new('4','D')
        expect(hand.full_house?).to be false
      end
    end

    describe '#four_of_a_kind?' do
      it 'returns true when there are four of a kind' do
        hand = PokerHand.new ace_d, ace_h, ace_s, duece_s, ace_c
        expect(hand.four_of_a_kind?).to be true
      end
      it 'returns false when there are not four of a kind' do
        hand = PokerHand.new ace_d, ace_h, ace_s, duece_s, duece_h
        expect(hand.four_of_a_kind?).to be false
      end
    end

    describe '#straight_flush?' do
      it 'returns true when a straight of the same suit' do
        hand = PokerHand.new Card.new('8','D'),Card.new('9','D'),Card.new('T','D'),Card.new('J','D'),Card.new('Q','D')
        expect(hand.straight_flush?).to be true
      end
      it 'returns false when a straight but not the same suit' do
        hand = PokerHand.new Card.new('8','D'),Card.new('9','D'),Card.new('T','S'),Card.new('J','H'),Card.new('Q','S')
        expect(hand.straight?).to be true
        expect(hand.straight_flush?).to be false
      end
      it 'returns false when a flush but not a straight' do
        hand = PokerHand.new Card.new('A','D'),Card.new('9','D'),Card.new('T','D'),Card.new('J','D'),Card.new('Q','D')
        expect(hand.flush?).to be true
        expect(hand.straight_flush?).to be false
      end
    end

    describe '#royal_flush?' do
      it 'returns true when a straight flush from 10 to A' do
        hand = PokerHand.new Card.new('T','D'),Card.new('J','D'),Card.new('Q','D'),Card.new('K','D'),Card.new('A','D')
        expect(hand.straight_flush?).to be true
      end
      it 'returns false when a straight from 10 to A but not the same suit' do
        hand = PokerHand.new Card.new('T','D'),Card.new('J','D'),Card.new('Q','S'),Card.new('K','H'),Card.new('A','S')
        expect(hand.straight?).to be true
        expect(hand.royal_flush?).to be false
      end
      it 'returns false when a straight flush but not starting with 10' do
        hand = PokerHand.new Card.new('8','D'),Card.new('9','D'),Card.new('T','D'),Card.new('J','D'),Card.new('Q','D')
        expect(hand.straight_flush?).to be true
        expect(hand.royal_flush?).to be false
      end
    end

    describe '#rank' do
      it 'ranks a royal flush higest (9)' do
        hand = PokerHand.new Card.new('T','D'),Card.new('J','D'),Card.new('Q','D'),Card.new('K','D'),Card.new('A','D')
        expect(hand.rank).to be 9
      end
      it 'ranks a straight flush as an 8' do
        hand = PokerHand.new Card.new('T','D'),Card.new('J','D'),Card.new('Q','D'),Card.new('K','D'),Card.new('9','D')
        expect(hand.rank).to be 8
      end
      it 'ranks a four of a kind as a 7' do
        hand = PokerHand.new duece_s,duece_c,duece_h,duece_d,Card.new('A','D')
        expect(hand.rank).to be 7
      end
      it 'ranks a full house as a 6' do
        hand = PokerHand.new ace_h,duece_s,ace_s,duece_c,ace_c
        expect(hand.rank).to be 6
      end
      it 'ranks a flush as 5' do
        hand = PokerHand.new Card.new('2','D'),Card.new('J','D'),Card.new('3','D'),Card.new('K','D'),Card.new('A','D')
        expect(hand.rank).to be 5
      end
      it 'ranks a straight as 4' do
        hand = PokerHand.new Card.new('T','D'),Card.new('J','D'),Card.new('Q','D'),Card.new('K','D'),Card.new('9','H')
        expect(hand.rank).to be 4
      end
      it 'ranks a three of a kind as 3' do
        hand = PokerHand.new ace_h,ace_c,Card.new('Q','D'),Card.new('K','D'),Card.new('A','D')
        expect(hand.rank).to be 3
      end
      it 'ranks a two pairs as 2' do
        hand = PokerHand.new duece_s,duece_c,ace_h,Card.new('K','D'),Card.new('A','D')
        expect(hand.rank).to be 2
      end
      it 'ranks a one pair as 1' do
        hand = PokerHand.new ace_s,ace_h,Card.new('Q','D'),Card.new('K','D'),Card.new('2','D')
        expect(hand.rank).to be 1
      end
      it 'ranks nothing but a high card lowest (0)' do
        hand = PokerHand.new Card.new('T','D'),Card.new('9','C'),Card.new('7','H'),Card.new('2','S'),Card.new('A','D')
        expect(hand.rank).to be 0
      end
    end

  end
end
