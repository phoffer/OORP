class Player < Volt::Model
  has_many :votes

  field :points, Numeric
  field :name

end
