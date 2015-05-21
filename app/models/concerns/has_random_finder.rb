module HasRandomFinder
  extend ActiveSupport::Concern

  included do

    field :random, type: Float, default: -> { Random.rand }
    index({random: 1})

  end

  module ClassMethods

    def find_random
      r = Random.rand
      gt = gte(random: r).first
      gt.presence or lte(random: r).first
    end

  end

end