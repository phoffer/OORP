class Vote < Volt::Model

  belongs_to :player
  belongs_to :round

  field :target_id
  field :value

end