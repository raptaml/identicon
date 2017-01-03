defmodule Identicon do

    def main(input) do
        input 
        |> hash_input()   
    end

    @doc
    """

    """
    defp hash_input(input) do
        :crypto.hash(:md5, input) 
        |> :binary.bin_to_list()   
    end

    @doc
    """

    """
    defp do_sthg(username) do
        
    end
end
