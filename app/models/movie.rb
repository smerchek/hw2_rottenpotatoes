class Movie < ActiveRecord::Base
  def Movie.all_ratings()
    {"G" => "1", "PG" => "1", "PG-13" => "1", "R" => "1", "NC-17" => "1"}
  end
end
