json.array!(@games) do |game|
  json.extract! game, :id, :name, :passcode, :max_players, :max_observers, :players, :observers, :status
  json.url game_url(game, format: :json)
end
