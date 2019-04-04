defmodule Puz do
  @moduledoc """
  Documentation for Puz.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Puz.hello()
      :world

  """
  def hello do
    :world
  end

  def decode(path) do
    puz = File.read!(path)

    <<
      checksum::integer-little-size(16),
      magic::binary-little-size(11),
      _::binary-little-size(1),
      _::binary-little-size(10),
      version::binary-little-size(3),
      _::binary-little-size(1),
      reserved::binary-little-size(2),
      scrambled_checksum::integer-little-size(16),
      _reserved20::binary-little-size(12),
      width::little-integer,
      height::little-integer,
      number_of_clues::integer-little-size(16),
      _unknown::integer-little-size(16),
      scrambled_tag::integer-little-size(16),
      rest::binary
    >> = puz

    puzzle_size = width * height

    <<
      solution::binary-little-size(puzzle_size),
      player_state::binary-little-size(puzzle_size),
      rest::binary
    >> = rest

    strings = String.split(rest, "\0")

    [title, author, copyright | rest] = strings

    clues = Enum.take(rest, number_of_clues)
    rest = Enum.take(rest, (length(rest) - number_of_clues) * -1)

    length(clues) |> IO.inspect()

    %{
      checksum: checksum,
      file_magic: magic,
      version: version,
      reserved: reserved,
      scrambled_checksum: scrambled_checksum,
      width: width,
      height: height,
      number_of_clues: number_of_clues,
      scrambled_tag: scrambled_tag,
      solution: solution,
      player_state: player_state,
      title: title,
      author: author,
      copyright: copyright,
      clues: clues,
      rest: rest
    }
  end
end
