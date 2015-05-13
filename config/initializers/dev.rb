# @mark = Time.now
#
# def pl
#   @player ||= Player.last
# end
#
# def ex
#   pl.ex
# end
#
# def act
#   pl.action_processor
# end
#
# def recent
#   y pl.recent_events.map(&:to_s).reverse
#   status
# end
#
# def events_since_mark
#   Event.gte(created_at: @mark)
# end
#
# def status
#   out = y({new_events: events_since_mark.map(&:to_s).reverse,
#     available_actions: pl.available_action_keys})
#   @player = nil
#   out
# end
#
# def known_locations
#   pl.location_states.map(&:slug)
# end
#
# def input action_slug
#   @mark = Time.now
#   pl.input action_slug
#   status
# end
#
# def sk slug, metadata = {}
#   pl.sk slug, metadata
#   status
# end
#
# def debug *args
#   return nil unless Rails.env.development?
#   puts args.join(', ')
# end
#
# def r
#   reload!
#   status
# end
