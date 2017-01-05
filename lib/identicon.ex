defmodule Identicon do

    def main(input) do
        input 
        |> hash_input()
        |> set_color()
        |> build_grid
        |> filter_odd
        |> build_pixel_map
        |> draw_image
        |> save_image(input)
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

    def filter_odd(image) do
        grid = Enum.filter(image.grid, fn({number, _index}) ->
            rem(number,2) == 0 
        end)
        %Identicon.Image{image | grid: grid}
    end

    def build_pixel_map(image) do
        grid = image.grid
        step = 50
        pixelmap = Enum.map(grid, fn({_number, index}) ->
            {{x1,x2},{y1,y2}} = {{rem(index, 5) * 50, div(index, 5) * 50}, {rem(index, 5) * 50 + 50, div(index, 5) * 50 + 50  }}
        end)
        %Identicon.Image{image | pixel_map: pixelmap}
 
    end

    def draw_image(image) do
        color = image.color
        pixel_map = image.pixel_map

        img = :egd.create(250, 250)
        fill = :egd.color(color)

        Enum.each(pixel_map, fn({start, stop}) ->
            :egd.filledRectangle(img, start, stop, fill)     
        end)

        :egd.render(img)

    end

    def save_image(img, input) do
        File.write("#{input}.png", img)

    end

    defp mirror_row(row) do
        #[a,b | _tail] =  row
        first = Enum.slice(row,0,2)
        row ++ Enum.reverse(first)       
    end
end
