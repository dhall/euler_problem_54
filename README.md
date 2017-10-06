# Instructions

clone repo

bundle

bin/solve to see solution

bin/console to poke around

rspec or guard to run tests

# Design notes

There are a lot of ways to approach this problem starting from a simple script
and going up to a full featured application. I took the approach of modeling
the objects and trying to make the code and logic readable.

I didn't build it around the poker.txt file and structure. I felt that the card
class shouldn't need to know how to parse the contents of a file it doesn't own.
Instead the Card class takes two arguments and parsing the file handled by a method
in the Tournament class.

Originally I made the methods for checking for one_pair?, two_pairs?, etc ensure
that ONLY one_pair, two_pairs, etc existed i.e. one_pair? would return false for
a hand that had 3 of a kind but it didn't feel right since, technically speaking,
3 of a kind does contain one pair. I had decent test coverage so relaxing this
approach was pretty straight forward to do and feel confident everything else
still was still working as expected. I then relied on the 'rank' method to test
a hand in order from highest possible hand to lowest.

I had overlooked an edge case in my approach to test for a straight, which took
me a bit to realize. I was trying to be a little to clever for my own good by
subtracting the high card from the low card and looking for a distance of 4 but
neglected to account for possible matches between the high and low. Once I found
the problem it was an easy failing test to write, then make the test pass.

Overall this was really fun to solve, this was my 28th projecteuler.net problem
solved.

# EulerProblem54

In the card game poker, a hand consists of five cards and are ranked,
from lowest to highest, in the following way:

High Card: Highest value card.

One Pair: Two cards of the same value.

Two Pairs: Two different pairs.

Three of a Kind: Three cards of the same value.

Straight: All cards are consecutive values.

Flush: All cards of the same suit.

Full House: Three of a kind and a pair.

Four of a Kind: Four cards of the same value.

Straight Flush: All cards are consecutive values of same suit.

Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.

The cards are valued in the order:

2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.

If two players have the same ranked hands then the rank made up of the highest
value wins; for example, a pair of eights beats a pair of fives (see example 1
below). But if two ranks tie, for example, both players have a pair of queens,
then highest cards in each hand are compared (see example 4 below); if the
highest cards tie then the next highest cards are compared, and so on.

Consider the following five hands dealt to two players:

5H 5C 6S 7S KD -vs- 2C 3S 8S 8D TD => Player 2

5D 8C 9S JS AC -vs- 2C 5C 7D 8S QH => Player 1

2D 9C AS AH AC -vs- 3D 6D 7D TD QD => Player 2

4D 6S 9H QH QC -vs- 3D 6D 7H QD QS => Player 1

2H 2D 4C 4D 4S -vs- 3C 3D 3S 9S 9D => Player 1


The file, poker.txt, contains one-thousand random hands dealt to two players.
Each line of the file contains ten cards (separated by a single space): the
first five are Player 1's cards and the last five are Player 2's cards. You can
assume that all hands are valid (no invalid characters or repeated cards), each
player's hand is in no specific order, and in each hand there is a clear winner.

How many hands does Player 1 win?
