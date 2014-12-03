json.array!(@players) do |player|
  json.extract! player, :id, :name, :score, :count, :answer, :people_fooled, :num_people_fooled, :game_id
  json.url player_url(player, format: :json)
end
