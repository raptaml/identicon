defmodule Identicon do

    def main(input) do
        input 
        |> hash_input()
        |> set_color()
        |> build_grid   
    end

    @doc
    """

    """
    def hash_input(input) do
        hex = :crypto.hash(:md5, input) 
        |> :binary.bin_to_list()   

        %Identicon.Image{hex: hex}
    end

    @doc
    """

    """
    def set_color(image) do
        %Identicon.Image{hex: hex_list} = image
        [r,g,b | _tail] = hex_list
        %Identicon.Image{image | color: {r,g,b}}

        
    end

    def build_grid(image) do
        grid =
            image.hex
            |> Enum.chunk(3)
            |> Enum.map(&mirror_row/1)
            |> List.flatten
            |> Enum.with_index
            
        %Identicon.Image{image | grid: grid }
    end

    defp mirror_row(row) do
        #[a,b | _tail] =  row
        first = Enum.slice(row,0,2)
        row ++ Enum.reverse(first)       
    end
end
