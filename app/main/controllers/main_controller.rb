# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    model :store
    def index
      # page._name ||= ''
      # Add code for when the index view is loaded
    end

    def about
      # Add code for when the about view is loaded
    end

    private

    def add_player
      page._name = page._name
      store.players << {name: page._name, points: 0}
      page._name = ''
    end
    def current_player
      store.players.find(name: page._name).first
    end
    def current_round
      store.rounds.find(id: 0).first
    end
    def add_vote(target_id, value)
      current_player.votes.create(target_id: target_id, value: value)
      store.players.find(id: target_id).first.then do |target|
        target.points = target.points + value
      end
    end
    def reset_round
      store.votes.reverse.each(&:destroy)
      store.players.each{ |p| p.points = 0 }
    end
    def standings
      store.players.order(:points).reverse
    end


    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
