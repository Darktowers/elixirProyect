defmodule Cards do
  @moduledoc """
   Provee metodos para la manipulacion de barajas
  """
  @doc """
   retorna una lista de strings que representan una baraja
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four"]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]
    # cards =
    #   for value <- values do
    #     for suit <- suits do
    #       "#{value} of #{suit}"
    #     end
    #   end
    # List.flatten(cards)
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Desordena un baraja
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Retorna si existe una carta en una baraja
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Retorna una dupla con la mano deseada de una baraja
  ## Ejemplos
      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
   Guarda un archivo con las cartas deseadas
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)

    File.write!(filename, binary)
  end

  @doc """
   Carga un archivo con las cartas guardadas
  """
  def load(filename) do
    # {status, binary} = File.read(filename)
    # case status do
    #   :ok -> :erlang.binary_to_term(binary)
    #   :error -> "That file doesn't exists"
    # end
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file doesn't exists"
    end
  end

  @doc """
   Crea una mano dependiendo el tamaño enviado lo desordena y retorna una
   dupla con la mano y el restante de cartas
  """
  def create_hand(hand_size) do
    # Pipes
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
