defmodule BeerSong do
  def verse(no_of_bottles) do
    check_pluralisation(no_of_bottles)
  end

  def check_pluralisation(no_of_bottles) do
    case no_of_bottles do
      2 ->
        """
        #{no_of_bottles} bottles of beer on the wall, #{no_of_bottles} bottles of beer.
        Take one down and pass it around, #{no_of_bottles - 1} bottle of beer on the wall.
        """ 
      1 ->
        """
        #{no_of_bottles} bottle of beer on the wall, #{no_of_bottles} bottle of beer.
        Take it down and pass it around, no more bottles of beer on the wall.
        """ 
      0 ->
        """
        No more bottles of beer on the wall, no more bottles of beer.
        Go to the store and buy some more, 99 bottles of beer on the wall.
        """ 
      _ -> 
        """
        #{no_of_bottles} bottles of beer on the wall, #{no_of_bottles} bottles of beer.
        Take one down and pass it around, #{no_of_bottles - 1} bottles of beer on the wall.
        """ 
    end
  end

  def lyrics(span \\ 99..0) do
    verses_list = 
    for verse <- span do
      check_pluralisation(verse)
    end
    Enum.join(verses_list, "\n")
  end
end
