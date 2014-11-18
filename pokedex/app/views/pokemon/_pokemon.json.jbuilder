json.extract!(
  pokemon, :id, :attack, :defense, :image_url, :moves, :name, :poke_type
)

if show_toys
  json.toys do
    json.array!(cat.toys) do |toy|
      json.partial!("toys/toy", toy: toy)
    end
  end
end
