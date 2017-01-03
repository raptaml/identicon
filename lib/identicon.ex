defmodule Identicon do

    def main(input) do
        input 
        |> hash_input()
        |> set_color()   
    end

    @doc
    """

    """
    defp hash_input(input) do
        hex = :crypto.hash(:md5, input) 
        |> :binary.bin_to_list()   

        %Identicon.Image{hex: hex}
    end

    @doc
    """

    """
    defp set_color(image) do
        color = Enum.chunk(image.hex, 3)
        image = 
        
    end
end
